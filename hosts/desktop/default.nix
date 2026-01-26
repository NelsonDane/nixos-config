{ config, pkgs, ... }:

{
  imports = [
    # ../../modules/nixos/services.nix
    ./hardware.nix
    ./disko.nix
  ];

  system.stateVersion = "24.05";
  time.timeZone = "America/New_York";

  # Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "desktop";
  networking.networkmanager.enable = true;

  # Audio
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  # Graphics
  services.xserver.enable = true;
  programs.niri.enable = true;

  services.openssh.enable = true;
}
