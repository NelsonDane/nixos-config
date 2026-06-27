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
  };

  # Network
  services.resolved.enable = true;
  networking = {
    hostName = "nas";
    hostId = "daecee53";
    networkmanager.enable = true;
    interfaces.enp1s0 = {
      ipv4.addresses = [
        {
          address = "10.0.2.20";
          prefixLength = 24;
        }
      ];
    };
  };

  # SSH
  services.openssh.enable = true;

  # State version
  system.stateVersion = "26.11";
}
