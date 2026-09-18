{ config, ... }: {
  flake.darwinConfigurations.macbook = config.flake.lib.mkDarwin {
    modules = [
      config.flake.modules.darwin.base
      config.flake.modules.darwin.discord
      config.flake.modules.darwin.git-signing
      config.flake.modules.darwin.macbook-dock
      config.flake.modules.darwin.macbook-homebrew
      config.flake.modules.darwin.macbook-linux-builder
      config.flake.modules.darwin.macbook-rosetta
      ({ pkgs, ... }: {
        # System settings
        system.stateVersion = 6;
        networking.hostName = "macbook";
        system.primaryUser = config.people.primaryUsername;
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

        # Home Manager Modules
        home-manager.users.${config.people.primaryUsername} = {
          imports = [
            config.flake.modules.homeManager.base
            config.flake.modules.homeManager.git
            config.flake.modules.homeManager.git-signing
            config.flake.modules.homeManager.shell
            config.flake.modules.homeManager.nvim
            config.flake.modules.homeManager.gui
            config.flake.modules.homeManager.ai
            config.flake.modules.homeManager.darwin-extras
          ];
        };
      })
    ];
  };
}
