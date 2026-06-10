{ pkgs, username, lib, ... }:
{
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
