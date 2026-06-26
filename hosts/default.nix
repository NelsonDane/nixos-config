{ pkgs, username, ... }: {
  # Nix settings
  nixpkgs.config.allowUnfree = true;
  nix = {
    enable = true;
    # Garbage collection + store optimise
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
    optimise.automatic = true;
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [ username ];
      # Other cache locations
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

  # Timezone
  time.timeZone = "America/New_York";

  # Set default shell to zsh
  programs.zsh.enable = true;
  users.users.${username}.shell = pkgs.zsh;

  # Direnv configuration (temp environments)
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    silent = true;
    enableZshIntegration = true;
  };

  # Fonts
  fonts.packages = with pkgs; [ nerd-fonts.fira-code ];
}
