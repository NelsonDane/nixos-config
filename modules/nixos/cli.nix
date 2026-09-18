let
  cliModule = { pkgs, ... }: {
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
  };
in
{
  flake.modules.nixos.cli = cliModule;
  flake.modules.darwin.cli = cliModule;
}
