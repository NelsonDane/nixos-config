let
  cliModule = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      curl
      dos2unix
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
  flake.modules.nixos.cli = { pkgs, ... }: {
    imports = [ cliModule ];
    environment.systemPackages = with pkgs; [ ethtool ];
  };

  flake.modules.darwin.cli = cliModule;
}
