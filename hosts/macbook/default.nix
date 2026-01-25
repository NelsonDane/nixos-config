{ pkgs, ... }:

{
  nix.enable = false;
  networking.hostName = "macbook";

  system.stateVersion = 6;
  system.primaryUser = "ndane";
  system.defaults.dock.autohide = true;
  system.defaults.finder.AppleShowAllExtensions = true;
}
