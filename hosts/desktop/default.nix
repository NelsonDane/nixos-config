{ config, pkgs, ... }:

{
  networking.hostName = "desktop";

  services.openssh.enable = true;
  services.pipewire.enable = true;

  imports = [
    ../../modules/nixos/services.nix
  ];
}
