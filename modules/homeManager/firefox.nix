_: {
  flake.modules.homeManager.firefox = { inputs, pkgs, ... }: {
    # https://mynixos.com/home-manager/options/programs.firefox
    programs.firefox = {
      enable = true;

      # Global Preferences
      policies = {
        # Get AI out of my browser
        AIControls = {
          Default = {
            Value = "blocked";
            Locked = true;
          };
        };
        DisableTelemetry = true;
        DisablePocket = true;
        DisplayBookmarksToolbar = "never";
        NoDefaultBookmarks = true;
        PasswordManagerEnabled = false;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
      };

      # https://github.com/NixOS/nixpkgs/issues/535123
      configPath = ".firefox";

      profiles.default = {
        id = 0;
        name = "default";
        isDefault = true;

        # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.firefox.profiles._name_.containersForce
        containersForce = true;
        # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.firefox.profiles._name_.search.force
        search.force = true;

        # Preferences
        settings = {
          # Security
          "privacy.resistFingerprinting" = true;
          "privacy.trackingprotection.emailtracking.enabled" = true;
          "dom.security.https_only_mode" = true;
          "media.peerconnection.ice.no_host" = true;

          # Auto add extensions
          "extensions.autoDisableScopes" = 0;
          "extensions.update.autoUpdateDefault" = false;
          "extensions.update.enabled" = false;

          # Disable telemetry
          "app.shield.optoutstudies.enabled" = false;
          "browser.discovery.enabled" = false;

          # Hide the sponsored stories feed and disable weather widget
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.showWeather" = false;
          "browser.newtabpage.activity-stream.system.showWeather" = false;

          # Disable Password/autofill
          "extensions.formautofill.addresses.enabled" = false;
          "extensions.formautofill.creditCards.enabled" = false;

          # Disable "Suggest Firefox Relay email masks" prompt
          "signon.firefoxRelay.feature" = "not available";

          # Open previous windows and tabs on startup
          "browser.startup.page" = 3;
        };

        # Extensions
        extensions = {
          # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.firefox.profiles._name_.extensions.force
          force = true;
          packages = with inputs.nur.legacyPackages.${pkgs.system}.repos.rycee.firefox-addons; [
            bitwarden
            darkreader
            sponsorblock
            return-youtube-dislikes
            ublock-origin
          ];
        };
      };
    };
  };
}
