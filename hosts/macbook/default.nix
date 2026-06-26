{ pkgs, username, ... }: {
  imports = [
    ./dock.nix
    ./homebrew.nix
  ];

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
}
