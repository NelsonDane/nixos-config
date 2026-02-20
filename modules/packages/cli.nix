{ pkgs, ... }:
{
  home.packages = with pkgs; [
    act
    curl
    dos2unix
    fastfetch
    gh
    htop
    just
    ncdu
    uv
    wget
    # K8s tools
    kubectl
    kube-linter
    k9s
    talosctl
  ];
}
