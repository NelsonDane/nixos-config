{ pkgs, config, lib, ... }:
let
  westonIni = pkgs.writeText "weston-sddm.ini" ''
    [libinput]
    enable-tap=${lib.boolToString config.services.libinput.mouse.tapping}
    left-handed=${lib.boolToString config.services.libinput.mouse.leftHanded}

    [keyboard]
    keymap_model=${config.services.xserver.xkb.model}
    keymap_layout=${config.services.xserver.xkb.layout}
    keymap_variant=${config.services.xserver.xkb.variant}
    keymap_options=${config.services.xserver.xkb.options}

    [output]
    name=HDMI-A-1
    mode=off

    [output]
    name=DP-1
    mode=off

    [output]
    name=DP-2
    mode=preferred
  '';
in {
  services.displayManager.sddm = {
    enable = true;
    wayland = {
      enable = true;
      compositorCommand = "${pkgs.weston}/bin/weston --shell=kiosk -c ${westonIni}";
    };
    package = pkgs.kdePackages.sddm;
    theme = "sddm-astronaut-theme";
  };

  environment.systemPackages = with pkgs; [
    (sddm-astronaut.override { embeddedTheme = "black_hole"; })
    kdePackages.qtmultimedia
  ];
}
