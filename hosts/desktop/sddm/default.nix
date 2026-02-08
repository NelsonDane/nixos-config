{ pkgs, lib, ... }:
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
    theme = "sddm-astronaut-theme";
  };
  services.xserver.displayManager.setupCommands = ''
    ${lib.getExe pkgs.xorg.xrandr} --output DP-2 --mode 2560x1440 --rate 144 --primary
  '';

  environment.systemPackages = with pkgs; [
    (sddm-astronaut.override {
      embeddedTheme = "black_hole";
    })
    kdePackages.qtmultimedia
  ];
}
