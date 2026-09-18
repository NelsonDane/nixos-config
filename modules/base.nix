{ config, ... }:
let
  # Shared base config for both NixOS and darwin hosts
  mkBase = cliModule: ageModule: { pkgs, lib, ... }: {
    imports = [
      cliModule
      ageModule
    ];

    nixpkgs.config.allowUnfree = true;
    nix = {
      enable = true;
      package = pkgs.lixPackageSets.stable.lix;
      gc = {
        automatic = true;
        options = "--delete-older-than 7d";
      };
      optimise.automatic = true;
      settings = {
        auto-optimise-store = lib.mkIf (!pkgs.stdenv.hostPlatform.isDarwin) true;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        trusted-users = [ config.people.primaryUsername ];
        always-allow-substitutes = true;
        substituters = [
          "https://cache.nixos.org/"
          "https://nix-community.cachix.org"
          "https://numtide.cachix.org"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
        ];
      };
    };

    time.timeZone = "America/New_York";

    programs.zsh.enable = true;
    users.users.${config.people.primaryUsername}.shell = pkgs.zsh;

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
      enableZshIntegration = true;
    };

    fonts.packages = with pkgs; [ nerd-fonts.fira-code ];

    documentation = {
      enable = false;
      doc.enable = false;
      info.enable = false;
      man.enable = false;
    };
  };
in
{
  flake.modules.nixos.base = mkBase config.flake.modules.nixos.cli config.flake.modules.nixos.age;
  flake.modules.darwin.base = mkBase config.flake.modules.darwin.cli config.flake.modules.darwin.age;
}
