{
  description = "Minimal NixOS ISO";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

  outputs =
    { nixpkgs }:
    {
      nixosConfigurations = {
        exampleIso = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            (
              { modulesPath, ... }:
              {
                imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];
                boot.zfs.forceImportRoot = false;
                security.sudo.wheelNeedsPassword = false;
                services.openssh.enable = true;
                users.users.root.openssh.authorizedKeys.keys = [
                  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINFAapmuD0l/rfYUK1fpfgDkrEPQQF2skVLRsmN6P/r6"
                ];
              }
            )
          ];
        };
      };
    };
}
