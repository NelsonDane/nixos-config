{ config, inputs, ... }: {
  flake.nixosConfigurations.oracle = config.flake.lib.mkNixos {
    system = "aarch64-linux";
    modules = [
      inputs.disko.nixosModules.disko
      inputs.impermanence.nixosModules.impermanence
      config.flake.modules.nixos.base
      config.flake.modules.nixos.disko
      config.flake.modules.nixos.impermanence
      config.flake.modules.nixos.oracle-hardware
      config.flake.modules.nixos.frp
      (_: {
        # Set disk ID
        disko.diskID = "scsi-360aac1585b7b4c6581ce68b1a1ce9888";

        # Bootloader
        boot.loader.systemd-boot = {
          enable = true;
          configurationLimit = 10; # protects the small ESP
        };
        boot.loader.efi.canTouchEfiVariables = true;

        # Age settings
        age.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGXB0goYrLls46igKdUD3LH7SQvsSFOFn1CASCyiiMsB";

        # User
        users.users.${config.people.primaryUsername} = {
          isNormalUser = true;
          extraGroups = [ "wheel" ];
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ7geyVxgkn37dI1qZ/bZ2kAOFYXCrMYvTEOF7Pqewkg"
          ];
          hashedPassword = config.people.hashedPassword;
        };
        security.sudo.wheelNeedsPassword = false;

        # Network
        networking.firewall.enable = true;
        networking = {
          hostName = "oracle";
          useDHCP = true;
        };

        # SSH
        services.openssh = {
          enable = true;
          settings = {
            PasswordAuthentication = false;
            KbdInteractiveAuthentication = false;
            PermitRootLogin = "no";
          };
        };
        networking.firewall.allowedTCPPorts = [ 22 ];

        # State version
        system.stateVersion = "26.11";

        # Home Manager Modules
        home-manager.users.${config.people.primaryUsername} = {
          imports = [
            config.flake.modules.homeManager.base
            config.flake.modules.homeManager.shell
          ];
        };
      })
    ];
  };
}
