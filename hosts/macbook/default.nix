{ pkgs, username, ... }:
{
  # System settings
  system.stateVersion = 6;
  networking.hostName = "macbook";
  system.primaryUser = username;
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
    user = username;
    mutableTaps = true; # Required for some reason: https://github.com/zhaofengli/nix-homebrew/issues/53
  };
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    taps = [ "TheBoredTeam/boring-notch" ];
    brews = [ "mole" ];
    casks = [
      "emclient"
      "pgadmin4"
      "boring-notch"
      "seafile-client"
      "iloader"
    ];
  };
}
