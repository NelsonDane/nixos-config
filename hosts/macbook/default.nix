{ pkgs, username, ... }: {
  imports = [
    ../../modules/packages/discord.nix
    ../../modules/system/git-signing.nix
    ./linux-builder.nix
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

  # Disable darwin uninstaller (https://github.com/nix-darwin/nix-darwin/issues/1817)
  system.tools.darwin-uninstaller.enable = false;
}
