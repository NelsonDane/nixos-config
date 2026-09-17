{ inputs, lib, ... }: {
  options.flake.lib.mkDarwin = lib.mkOption { type = lib.types.functionTo lib.types.raw; };

  config.flake.lib.mkDarwin =
    {
      modules,
      system ? "aarch64-darwin",
    }:
    inputs.nix-darwin.lib.darwinSystem {
      specialArgs = { inherit inputs; };
      modules = modules ++ [
        inputs.home-manager.darwinModules.home-manager
        inputs.nix-homebrew.darwinModules.nix-homebrew
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
