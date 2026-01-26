{ config, pkgs, lib, ... }:

{
  imports = [
    ../../modules/common/packages.nix
    ./darwin.nix
    ./desktop.nix
  ];
  # Home Manager configuration
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
  home.username = "ndane";
  home.homeDirectory =
    if pkgs.stdenv.isDarwin
    then lib.mkForce "/Users/ndane"
    else lib.mkForce "/home/ndane";

  # Shell configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
  
  # Git configuration
  programs.git = {
    enable = true;
    signing = {
      key = "8739A1D9F4ADECB967B4094F1D405F49029EB38E";
      signByDefault = true;
    };
    ignores = [
      ".DS_Store"
    ];
    settings = {
      user = {
        name = "Nelson Dane";
        email = "47427072+NelsonDane@users.noreply.github.com";
      };
      init.defaultBranch = "main";
    };
  };
}
