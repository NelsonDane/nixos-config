{ inputs, lib, ... }: {
  options.flake.lib.mkNixos = lib.mkOption { type = lib.types.functionTo lib.types.raw; };

  config.flake.lib.mkNixos =
    {
      modules,
      system ? "x86_64-linux",
    }:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = modules ++ [
        inputs.home-manager.nixosModules.home-manager
        inputs.agenix.nixosModules.default
        inputs.agenix-rekey.nixosModules.default
        {
          nixpkgs.hostPlatform = system;
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = ".nixbak";
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.sharedModules = [
            inputs.nixvim.homeModules.nixvim
            inputs.nix-index-database.homeModules.default
          ];
        }
      ];
    };
}
