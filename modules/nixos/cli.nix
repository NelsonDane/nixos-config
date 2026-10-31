let
  cliModule = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      curl
      dos2unix
      ethtool
      fastfetch
      htop
      iperf3
      just
      nh
      ncdu
      ripgrep
      speedtest-go
      uv
      wget
    ];
  };
in
{
  flake.modules.nixos.cli = cliModule;
  flake.modules.darwin.cli = cliModule;
}
