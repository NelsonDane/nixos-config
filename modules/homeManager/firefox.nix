_: {
  flake.modules.homeManager.firefox = { inputs, pkgs, ... }: {
    programs.firefox = {
      enable = true;
      package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
        extraPolicies = {
          EnableTrackingProtection = {
            Value = true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
          };
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
          "privacy.resistFingerprinting" = true;
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.emailtracking.enabled" = true;
          "dom.security.https_only_mode" = true;
          "media.peerconnection.ice.no_host" = true;

          # Auto add extensions
          "extensions.autoDisableScopes" = 0;
          "extensions.update.autoUpdateDefault" = false;
          "extensions.update.enabled" = false;

          # Disable telemetry
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "app.shield.optoutstudies.enabled" = false;
          "browser.discovery.enabled" = false;

          # Hide the sponsored stories feed and disable weather widget
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.showWeather" = false;
          "browser.newtabpage.activity-stream.system.showWeather" = false;
        };

        # Extensions
        extensions = {
          # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.firefox.profiles._name_.extensions.force
          force = true;
          packages = with inputs.nur.legacyPackages.${pkgs.system}.repos.rycee.firefox-addons; [
            bitwarden
            darkreader
            ublock-origin
            sponsorblock
          ];
        };
      };
    };
  };
}
