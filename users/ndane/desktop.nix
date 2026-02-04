{ pkgs, ... }:
{
  home.packages = with pkgs; [ ];

  # GPG configuration
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-curses;
  };

  xdg.configFile."niri/config.kdl" = {
    source = ./niri.kdl;
    force = true;
  };
}
