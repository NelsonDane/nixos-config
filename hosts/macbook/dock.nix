{ pkgs, ... }: {
  system.defaults = {
    dock = {
      persistent-apps = [
        { app = "${pkgs.brave}/Applications/Brave Browser.app"; }
        { app = "/System/Applications/Photos.app"; }
        { app = "/Applications/Spark Desktop.app"; }
        { app = "/System/Applications/Messages.app"; }
        { app = "/System/Applications/Calendar.app"; }
        { app = "/System/Applications/Notes.app"; }
        { app = "/System/Applications/App Store.app"; }
        { app = "/System/Applications/System Settings.app"; }
        { app = "/System/Applications/Utilities/Activity Monitor.app"; }
        { app = "${pkgs.vscode}/Applications/Visual Studio Code.app"; }
        { app = "${pkgs.kitty}/Applications/Kitty.app"; }
        { app = "${pkgs.vesktop}/Applications/Vesktop.app"; }
      ];
    };
  };
}
