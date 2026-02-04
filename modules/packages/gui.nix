{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brave
    vscode
    # vesktop # doesn't build on macos
  ];
}
