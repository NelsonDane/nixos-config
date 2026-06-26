{ pkgs, username, ... }: {
  imports = [
    # (import ../../modules/system/disko.nix) { diskID = "nvme-Samsung_SSD_970_EVO_Plus_2TB_S6S2NS0W208794D"; }
    ../../modules/system/disko.nix
    ./hardware.nix
    ../../modules/system/impermanence.nix
    ./niri.nix
    ./theme.nix
    ./sddm.nix
  ];
  # Set disk ID
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

  # Displays
  services.xserver.enable = true;

  services.openssh.enable = true;

  # User
  users.users.${username} = {
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
    gnupg
    pinentry-curses # for gpg
    pavucontrol
    pamixer
    gamescope
    mangohud
    vesktop
  ];

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
}
