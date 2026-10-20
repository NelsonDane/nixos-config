{
  inputs,
  lib,
  config,
  ...
}:
{
  options.flake.lib.mkDarwin = lib.mkOption { type = lib.types.functionTo lib.types.raw; };

  config.flake.lib.mkDarwin =
    {
      modules,
      system ? "aarch64-darwin",
    }:
    inputs.nix-darwin.lib.darwinSystem {
      specialArgs = { inherit inputs; };
      modules =
        modules
        ++ [
          inputs.home-manager.darwinModules.home-manager
          inputs.nix-homebrew.darwinModules.nix-homebrew
        ]
        ++ config.flake.lib.mkSystemModules { inherit inputs system; };
    };
}
