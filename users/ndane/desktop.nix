{ pkgs, lib, ... }:

lib.mkIf pkgs.stdenv.isLinux {
  home.packages = with pkgs; [ ];

  # GPG configuration
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
  };
}
