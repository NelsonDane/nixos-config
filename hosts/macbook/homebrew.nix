{ username, ... }: {
  # https://github.com/zhaofengli/nix-homebrew
  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = username;
    mutableTaps = true; # Required for some reason: https://github.com/zhaofengli/nix-homebrew/issues/53
    trust = {
      casks = [ "boring-notch" ];
    };
  };
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    taps = [ "TheBoredTeam/boring-notch" ];
    brews = [ "mole" ];
    casks = [
      "pgadmin4"
      "boring-notch"
      "seafile-client"
      "readdle-spark"
    ];
  };
}
