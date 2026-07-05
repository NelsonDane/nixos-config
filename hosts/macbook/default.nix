{ pkgs, username, ... }: {
  imports = [
    ../../modules/packages/discord.nix
    ./linux-builder.nix
    ./dock.nix
    ./homebrew.nix
  ];
  # Age settings
  age.hostPubkey = "age1yubikey1qdqlzzmfggrcd22747urjfdj74sgahju4gv3czmyc8497juu6pakgs8u3m5";

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
