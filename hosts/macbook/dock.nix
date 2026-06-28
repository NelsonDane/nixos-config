{ username, ... }: {
  system.defaults = {
    dock = {
      persistent-apps = [
        { app = "/Users/${username}/Applications/Home Manager Apps/Brave Browser.app"; }
        { app = "/System/Applications/Photos.app"; }
        { app = "/Applications/Spark Desktop.app"; }
        { app = "/System/Applications/Messages.app"; }
        { app = "/System/Applications/Calendar.app"; }
        { app = "/System/Applications/Notes.app"; }
        { app = "/System/Applications/App Store.app"; }
        { app = "/System/Applications/System Settings.app"; }
        { app = "/System/Applications/Utilities/Activity Monitor.app"; }
        { app = "/Users/${username}/Applications/Home Manager Apps/Visual Studio Code.app"; }
        { app = "/Users/${username}/Applications/Home Manager Apps/Kitty.app"; }
        { app = "/Users/${username}/Applications/Home Manager Apps/Vesktop.app"; }
      ];
    };
  };
}
