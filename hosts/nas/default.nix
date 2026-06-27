{ username, ... }: {
  imports = [
    ../../modules/system/disko.nix
    ./hardware.nix
    ../../modules/system/impermanence.nix
    ./nfs.nix
    ./zfs.nix
  ];
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set disk ID
  disko.diskID = "usb-JMicron_Tech_DD56419884E16-0:0";

  # User
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN99egqt9QVRlvnRBv7oCwl4qcO6MmaA32Y7y8RC1bhQ"
    ];
    hashedPassword = "$6$DwA4Gh5R6yoYOsSV$OKy2T3F/O7woBQcVVDAhkYR62pIhsLxC3Ko7FhbhYb5Yb4CQyYhgTe/7YMth8ScxIbYZ3Lc8lAB0a/AnMuxGT.";
  };

  # Network
  networking.firewall.enable = true;
  services.resolved.enable = true;
  networking = {
    hostName = "nas";
    hostId = "daecee53";
    interfaces.enp1s0 = {
      ipv4.addresses = [
        {
          address = "10.0.2.20";
          prefixLength = 24;
        }
      ];
    };
    defaultGateway = {
      address = "10.0.2.1";
      interface = "enp1s0";
    };
    nameservers = [ "10.0.2.3" ];
  };

  # SSH
  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];

  # State version
  system.stateVersion = "26.11";
}
