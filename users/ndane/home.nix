{ config, pkgs, lib, ... }:

{
  imports = [
    ../modules/common/packages.nix
    ../modules/common/shell.nix
    ../modules/common/git.nix

    (lib.mkIf pkgs.stdenv.isLinux ./desktop.nix)
    (lib.mkIf pkgs.stdenv.isDarwin ./darwin.nix)
  ];

  home.username = "ndane";
  home.homeDirectory =
    if pkgs.stdenv.isDarwin
    then "/Users/ndane"
    else "/home/ndane";

  home.stateVersion = "24.05";
}
