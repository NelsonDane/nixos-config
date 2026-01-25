{ config, pkgs, lib, ... }:

{
  # imports = [
    # ../../modules/common/packages.nix
    # ../../modules/common/shell.nix
    # ../../modules/common/git.nix

    # (lib.mkIf pkgs.stdenv.isLinux ./desktop.nix)
    # (lib.mkIf pkgs.stdenv.isDarwin ./darwin.nix)
    # ./darwin.nix
  # ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };
  programs.home-manager.enable = true;
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
  home.username = "ndane";
  home.homeDirectory =
    if pkgs.stdenv.isDarwin
    then lib.mkForce "/Users/ndane"
    else lib.mkForce "/home/ndane";

  home.stateVersion = "24.05";
  programs.git.settings = {
    enable = true;
    userName = "ndane";
    userEmail = "47427072+NelsonDane@users.noreply.github.com";
    extraConfig = {
      github.user = "NelsonDane";
    };
  };
}
