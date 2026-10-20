{
  inputs,
  lib,
  config,
  ...
}:
{
  options.flake.lib.mkNixos = lib.mkOption { type = lib.types.functionTo lib.types.raw; };

  config.flake.lib.mkNixos =
    {
      modules,
      system ? "x86_64-linux",
    }:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules =
        modules
        ++ [ inputs.home-manager.nixosModules.home-manager ]
        ++ config.flake.lib.mkSystemModules { inherit inputs system; };
    };
}
