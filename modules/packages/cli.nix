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
    kube-linter
    k9s
    talosctl
  ];
}
