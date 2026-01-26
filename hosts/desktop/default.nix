{ config, pkgs, ... }:

{
  imports = [
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
  services.xserver.displayManager.sddm.enable = true;
  programs.niri.enable = true;
  # Nvidia
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;

  services.openssh.enable = true;

  # User
  users.users.ndane = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "libvirt" "docker" ];
    hashedPassword = "$6$DwA4Gh5R6yoYOsSV$OKy2T3F/O7woBQcVVDAhkYR62pIhsLxC3Ko7FhbhYb5Yb4CQyYhgTe/7YMth8ScxIbYZ3Lc8lAB0a/AnMuxGT.";
  };
}
