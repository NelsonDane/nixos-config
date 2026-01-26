{ pkgs, ... }:

{
  nix.enable = false;
  system.stateVersion = 6;

  # System settings
  networking.hostName = "macbook";
  system.primaryUser = "ndane";
  system.defaults.dock.autohide = true;
  system.defaults.finder.AppleShowAllExtensions = true;
  security.pam.services.sudo_local.touchIdAuth = true;

  # Homebrew packages
  homebrew = {
    enable = true;
    taps = [];
    brews = [
        "mole"
    ];
    casks = [
        "http-toolkit"
        "kitty"
    ];
  };
}
