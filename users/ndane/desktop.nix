{ pkgs, ... }:

{
  home.packages = with pkgs; [
    xclip
    wl-clipboard
  ];
}
