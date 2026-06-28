{ pkgs, ... }: {
  home.packages = with pkgs; [
    brave
    vscode
    vesktop
    httptoolkit
  ];
}
