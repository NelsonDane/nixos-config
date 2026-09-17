_: {
  flake.modules.nixos.impermanence = { config, ... }: {
    # Much thanks to:
    # https://github.com/Swarsel/.dotfiles/blob/main/modules/nixos/common/impermanence.nix
    # https://notashelf.dev/posts/impermanence
    boot.tmp.useTmpfs = true;
    boot.initrd.systemd = {
      enable = true;
      services.rollback = {
        description = "Rollback BTRFS root subvolume to a pristine state";
        wantedBy = [ "initrd.target" ];
        after = [ "dev-disk-by\\x2dlabel-nixos.device" ];
        requires = [ "dev-disk-by\\x2dlabel-nixos.device" ];
        before = [ "sysroot.mount" ];

        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";
        script = ''
          mkdir -p /mnt
          mount -o subvolid=5 -t btrfs /dev/disk/by-label/nixos /mnt
          btrfs subvolume list -o /mnt/root

          btrfs subvolume list -o /mnt/root |
            cut -f9 -d' ' |
            while read subvolume; do
              echo "deleting /$subvolume subvolume..."
              btrfs subvolume delete "/mnt/$subvolume"
            done &&
            echo "deleting /root subvolume..." &&
            btrfs subvolume delete /mnt/root
          echo "restoring blank /root subvolume..."
          btrfs subvolume snapshot /mnt/root-blank /mnt/root

          umount /mnt
        '';
      };
    };

    environment.persistence."/persist" = {
      enable = true;
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/var/db/sudo"
      ]
      ++ (if config.networking.networkmanager.enable then [ "/var/lib/NetworkManager" ] else [ ]);
      files = [
        "/etc/machine-id"
        # needed for ssh
        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_ed25519_key.pub"
        "/etc/ssh/ssh_host_rsa_key"
        "/etc/ssh/ssh_host_rsa_key.pub"
      ];
    };
  };
}
