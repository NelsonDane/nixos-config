{ pkgs, ... }:

{
  home.packages = with pkgs; [
    act
    brave
    dos2unix
    fastfetch
    gh
    git
    gnupg
    htop
    ncdu
    neovim
    nixfmt
    vesktop
    vim
    vscode
    zsh-autosuggestions
    zsh-syntax-highlighting
    # K8s tools
    kubectl
    k9s
    talosctl
  ];
}
