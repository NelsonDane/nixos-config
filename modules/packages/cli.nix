{ pkgs, ... }:
{
  home.packages = with pkgs; [
    act
    dos2unix
    fastfetch
    gh
    htop
    ncdu
    # K8s tools
    kubectl
    k9s
    talosctl
  ];
}
