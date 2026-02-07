{ pkgs, ... }:
{
  home.packages = with pkgs; [
    act
    dos2unix
    fastfetch
    gh
    htop
    ncdu
    uv
    # K8s tools
    kubectl
    k9s
    talosctl
  ];
}
