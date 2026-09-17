{ config, inputs, ... }: {
  flake.nixosConfigurations.desktop = config.flake.lib.mkNixos {
    modules = [
      inputs.disko.nixosModules.disko
      inputs.impermanence.nixosModules.impermanence
      inputs.stylix.nixosModules.stylix
      config.flake.modules.nixos.base
      config.flake.modules.nixos.discord
      config.flake.modules.nixos.disko
      config.flake.modules.nixos.impermanence
      config.flake.modules.nixos.git-signing
      config.flake.modules.nixos.desktop-hardware
      config.flake.modules.nixos.desktop-niri
      config.flake.modules.nixos.desktop-theme
      config.flake.modules.nixos.desktop-sddm
      ({ pkgs, ... }: {
        # Set Disk ID
        disko.diskID = "nvme-Samsung_SSD_970_EVO_Plus_2TB_S6S2NS0W208794D";

        system.stateVersion = "24.05";

        # Boot
        boot.loader.systemd-boot.enable = true;
        boot.loader.efi.canTouchEfiVariables = true;

        # Networking
        networking.hostName = "desktop";
        networking.networkmanager.enable = true;

        # Audio
        security.rtkit.enable = true;
        services.pipewire = {
          enable = true;
          pulse.enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
        };

        services.xserver.enable = true;
        services.openssh.enable = true;

        # User
        users.users.${config.people.primaryUsername} = {
          isNormalUser = true;
          extraGroups = [
            "wheel"
            "networkmanager"
            "libvirt"
            "docker"
            "audio"
          ];
          hashedPassword = "$6$DwA4Gh5R6yoYOsSV$OKy2T3F/O7woBQcVVDAhkYR62pIhsLxC3Ko7FhbhYb5Yb4CQyYhgTe/7YMth8ScxIbYZ3Lc8lAB0a/AnMuxGT.";
        };

        # System packages
        environment.systemPackages = with pkgs; [
          pavucontrol
          pamixer
          gamescope
          mangohud
        ];

        # Discord
        discord.gameDetect = true;

        # Steam
        programs.gamemode.enable = true;
        programs.steam = {
          enable = true;
          remotePlay.openFirewall = true;
          localNetworkGameTransfers.openFirewall = true;
        };
        nixpkgs.config.packageOverrides = pkgs: {
          steam = pkgs.steam.override {
            extraPkgs =
              pkgs: with pkgs; [
                libXcursor
                libXi
                libXinerama
                libXScrnSaver
                libpng
                libpulseaudio
                libvorbis
                stdenv.cc.cc.lib
                libkrb5
                keyutils
                mangohud
              ];
          };
        };

        # Home Manager Modules
        home-manager.users.${config.people.primaryUsername} = {
          imports = [
            config.flake.modules.homeManager.base
            config.flake.modules.homeManager.git
            config.flake.modules.homeManager.git-signing
            config.flake.modules.homeManager.shell
            config.flake.modules.homeManager.nvim
            config.flake.modules.homeManager.desktop
            config.flake.modules.homeManager.gui
            config.flake.modules.homeManager.ai
          ];
        };
      })
    ];
  };
}
