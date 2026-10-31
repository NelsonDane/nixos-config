_: {
  flake.modules.homeManager.darwin-extras = { pkgs, ... }: {
    home.packages = with pkgs; [ httptoolkit ];
  };
}
