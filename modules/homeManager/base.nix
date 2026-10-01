{ config, ... }: {
  flake.modules.homeManager.base = { pkgs, lib, ... }: {
    programs.home-manager.enable = true;
    home.stateVersion = "25.11";
    home.username = config.people.primaryUsername;
    home.homeDirectory =
      if pkgs.stdenv.hostPlatform.isDarwin then
        lib.mkForce "/Users/${config.people.primaryUsername}"
      else
        lib.mkForce "/home/${config.people.primaryUsername}";

    programs.nix-index.enable = true;
    programs.nix-index-database.comma.enable = true;

    services.ssh-agent.enable = true;

    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings = {
        "*" = {
          forwardAgent = true;
        };
        "*github.com" = {
          user = "git";
          identityFile = "~/.ssh/github";
          identitiesOnly = true;
        };
        "ssh.dev.azure.com" = {
          user = "git";
          identityFile = "~/.ssh/ctc-azure";
          identitiesOnly = true;
        };
      };
    };
  };
}
