{ pkgs, ... }:

{
  networking.hostName = "macbook";

  system.defaults.dock.autohide = true;
  system.defaults.finder.AppleShowAllExtensions = true;

  services.nix-daemon.enable = true;
}
