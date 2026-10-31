{ lib, ... }: {
  options.flake.lib.mkSystemModules = lib.mkOption {
    type = lib.types.functionTo lib.types.raw;
    description = "Shared agenix and home-manager wiring to both mkNixos and mkDarwin's modules lists.";
  };

  config.flake.lib.mkSystemModules = { inputs, system }: [
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
}
