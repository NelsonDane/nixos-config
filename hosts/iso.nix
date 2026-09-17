{ inputs, ... }: {
  flake.nixosConfigurations.iso = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    modules = [
      (
        {
          pkgs,
          lib,
          inputs,
          ...
        }:
        {
          # Minimal ISO image
          image.modules.iso = "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix";
          boot.zfs.forceImportRoot = false;
          hardware.enableRedistributableFirmware = lib.mkForce false;
          hardware.firmware = lib.mkForce [ ];
          # Enable flake support
          nix.settings.experimental-features = [
            "nix-command"
            "flakes"
          ];
          security.sudo.wheelNeedsPassword = false;
          services.openssh.enable = true;
          users.users.root.openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINFAapmuD0l/rfYUK1fpfgDkrEPQQF2skVLRsmN6P/r6"
          ];
          # Needed to install the full system
          environment.systemPackages = with pkgs; [
            git
            just
            nh
            vim
          ];
          # Disable man/docs to save space
          documentation = {
            enable = false;
            dev.enable = false;
            doc.enable = false;
            info.enable = false;
            man.enable = false;
            nixos.enable = false;
          };
        }
      )
    ];
  };
}
