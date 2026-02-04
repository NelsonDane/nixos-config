{
  pkgs,
  lib,
  profile,
  ...
}:
{
  imports = [
    ./shell.nix
    ./nvim.nix
    ../../modules/packages/cli.nix
  ]
  ++ lib.optionals (profile == "desktop") [ ./desktop.nix ]
  ++ lib.optionals (profile == "macbook") [ ./darwin.nix ]
  ++ lib.optionals (profile != "work") [ ../../modules/packages/gui.nix ];

  # Home Manager configuration
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
  home.username = "ndane";
  home.homeDirectory =
    if pkgs.stdenv.isDarwin then lib.mkForce "/Users/ndane" else lib.mkForce "/home/ndane";

  # Nix package cache
  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;

  # Git configuration
  programs.git = {
    enable = true;
    lfs.enable = true;
    ignores = [ ".DS_Store" ];
    settings = {
      user = {
        name = "Nelson Dane";
        email =
          if (profile == "work") then
            "ndane@ctconline.com"
          else
            "47427072+NelsonDane@users.noreply.github.com";
      };
      init.defaultBranch = "main";
      fetch.prune = true;
      pull.rebase = true;
      rebase = {
        autoStash = true;
        autoSquash = true;
        updateRefs = true;
      };
    };
    # Signing
    signing = lib.mkIf (profile != "work") {
      key = "8739A1D9F4ADECB967B4094F1D405F49029EB38E";
      signByDefault = true;
    };
  };

  # GPG configuration
  programs.gpg.enable = profile != "work";

  # SSH Keys
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        forwardAgent = true;
      };
      "*github.com" = {
        user = "git";
        identityFile = "~/.ssh/github";
        identitiesOnly = true;
      };
      "*azure.com" = {
        user = "git";
        identityFile = "~/.ssh/azure";
        identitiesOnly = true;
      };
    };
  };
}
