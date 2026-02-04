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
    alejandra.enable = true;
    actionlint.enable = true;
    dos2unix.enable = true;
  };
  settings.excludes = [
    "*.age"
    "*.png"
    "flake.lock"
  ];
  settings.formatter = {
    deadnix = {
      priority = 1;
    };
    alejandra = {
      priority = 2;
    };
    statix = {
      priority = 3;
    };
    nixfmt = {
      priority = 4;
    };
  };
}
