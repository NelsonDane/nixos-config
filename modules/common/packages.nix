{ pkgs, ... }:

{
  home.packages = with pkgs; [
    dos2unix
    fastfetch
    gh
    git
    htop
    lazygit
    ncdu
    neovim
    nixfmt
    vim
    zsh-autosuggestions
    zsh-syntax-highlighting
    # K8s tools
    kubectl
    k9s
    talosctl
  ];
}
