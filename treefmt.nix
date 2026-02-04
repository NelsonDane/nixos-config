_: {
  projectRootFile = "flake.nix";
  programs = {
    deadnix.enable = true;
    statix.enable = true;
    keep-sorted.enable = true;
    nixfmt = {
      enable = true;
      strict = true;
    };
    actionlint.enable = true;
    dos2unix.enable = true;
  };
  settings.excludes = [
    "*.age"
    "*.png"
    "*.kdl"
    "flake.lock"
  ];
  settings.formatter = {
    deadnix = {
      priority = 1;
    };
    statix = {
      priority = 2;
    };
    nixfmt = {
      priority = 3;
    };
  };
}
