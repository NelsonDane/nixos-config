{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    curl
    dos2unix
    fastfetch
    htop
    just
    nh
    ncdu
    uv
    wget
  ];
}
