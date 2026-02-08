{ pkgs, ... }:
{
  home.packages = with pkgs; [ ];

  # GPG configuration
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-curses;
  };

  # Niri config
  xdg.configFile."niri/config.kdl" = {
    source = ./niri.kdl;
    force = true;
  };

  # Waybar Config
  programs.waybar = {
    enable = true;
    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 32;

      modules-left = [ "niri/workspaces" ];
      modules-center = [ "clock" ];
      modules-right = [
        "cpu"
        "memory"
        "network"
        "pulseaudio"
        "pulseaudio#microphone"
        "tray"
      ];
      cpu = {
        interval = 10;
        format = "  {usage}%";
        on-click-right = "kitty --start-as=fullscreen --title=CPU-Usage htop";
        tooltip = false;
      };
      memory = {
        interval = 10;
        format = "  {}%";
        on-click-right = "kitty --start-as=fullscreen --title=Memory-Usage htop";
      };
      clock = {
        format = "{:%A, %B %e, %Y | %OI:%M:%S %p}";
        interval = 1;
        tooltip = false;
      };
      network = {
        interface = "enp3s0";
        format = "󰱓";
        format-disconnected = "󰅛";
        tooltip = true;
        tooltip-format = "{ifname}: {ipaddr}";
      };
      pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = "{icon} Muted";
        format-icons = {
          headphone = "";
          "hands-free" = "";
          "headset" = "";
          "phone" = "";
          "portable" = "";
          "car" = "";
          "default" = [
            ""
            ""
            ""
          ];
        };
        on-click-right = "pavucontrol";
        scroll-step = 5;
      };
      "pulseaudio#microphone" = {
        format = "{format_source}";
        format-source = "";
        format-source-muted = "";
        on-click-right = "pavucontrol";
        scroll-step = 5;
        tooltip = true;
      };
    };
    # https://github.com/rose-pine/waybar/blob/main/rose-pine.css
    style = ''
      @define-color base            #191724;
      @define-color surface         #1f1d2e;
      @define-color overlay         #26233a;

      @define-color muted           #6e6a86;
      @define-color subtle          #908caa;
      @define-color text            #e0def4;

      @define-color love            #eb6f92;
      @define-color gold            #f6c177;
      @define-color rose            #ebbcba;
      @define-color pine            #31748f;
      @define-color foam            #9ccfd8;
      @define-color iris            #c4a7e7;

      @define-color highlightLow    #21202e;
      @define-color highlightMed    #403d52;
      @define-color highlightHigh   #524f67;

      * {
        font-weight: bold;
        font-size: 16px;
        min-height: 0;
        background: @base;
        border: none;
        border-radius: 0;
      }

      #workspaces button {
        padding: 0 5px 0 10px;
        background-color: transparent;
        color: @muted;
        transition-property: color;
        transition-duration: 0.35s;
        border-radius: 50%;
      }

      #workspaces button.active {
          color: @text;
      }

      #workspaces button.urgent {
          background-color: @rose;
          color: @base;
      }

      #workspaces,
      #clock,
      #cpu,
      #memory,
      #network,
      #pulseaudio {
        padding: 0 15px;
        margin-right: 8px;
        border-radius: 10px;
        border: 2px solid @iris;
        background-color: transparent;
      }

      #cpu,
      #clock {
        color: @love;
      }

      #memory {
        color: @gold;
      }

      #network {
        color: @foam;
      }

      #pulseaudio {
        color: @pine;
      }
    '';
  };
}
