{ pkgs, ... }: {
  home.packages = with pkgs; [
    curl
    dos2unix
    fastfetch
    gh
    htop
    just
    nh
    ncdu
    uv
    wget
  ];
}
