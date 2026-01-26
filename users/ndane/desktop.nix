{ pkgs, ... }:

lib.mkIf pkgs.stdenv.isDarwin {
  home.packages = with pkgs; [];
}
