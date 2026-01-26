{ pkgs, lib, ... }:

lib.mkIf pkgs.stdenv.isLinux {
  home.packages = with pkgs; [
    pinentry-curses # for gpg
  ];
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinetryFormat = "curses";
  };
}
