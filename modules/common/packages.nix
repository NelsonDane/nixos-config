{ pkgs, ... }:

{
  home.packages = with pkgs; [
    brave
    dos2unix
    fastfetch
    gh
    git
    gnupg
    htop
    lazygit
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
