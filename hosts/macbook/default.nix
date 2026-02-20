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

  environment.systemPackages = with pkgs; [
    colima
    docker
    docker-compose
  ];

  # Homebrew
  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "ndane";
    mutableTaps = true; # Required for some reason: https://github.com/zhaofengli/nix-homebrew/issues/53
  };
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    taps = [ ];
    brews = [ "mole" ];
    casks = [ ];
  };
}
