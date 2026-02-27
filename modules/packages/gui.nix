{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brave
    cinny-desktop
    vscode
    vesktop
  ];
}
