{
  description = "Minimal NixOS ISO";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

  outputs = { nixpkgs, ... }: {
    nixosConfigurations = {
      iso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ({ pkgs, lib, ... }: {
            # Minimal ISO image
            image.modules.iso = "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix";
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
          })
        ];
      };
    };
  };
}
