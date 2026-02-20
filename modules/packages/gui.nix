{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brave
    cinny-desktop
    vscode
    vesktop
  ];

  # Needed on mac until this is fixed: https://github.com/nixos/nixpkgs/issues/484618
  nixpkgs.overlays = [
    (_final: prev: {
      vesktop = prev.vesktop.overrideAttrs (_old: {
        buildPhase = ''
          runHook preBuild

          pnpm build
          pnpm exec electron-builder \
            --dir \
            -c.asarUnpack="**/*.node" \
            -c.electronDist=${if prev.stdenv.hostPlatform.isDarwin then "." else "electron-dist"} \
            -c.electronVersion=${prev.electron.version} \
            ${prev.lib.optionalString prev.stdenv.hostPlatform.isDarwin "-c.mac.identity=null"}

          runHook postBuild
        '';
      });
    })
  ];
}
