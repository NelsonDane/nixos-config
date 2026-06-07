{
  pkgs,
  username,
  config,
  lib,
  ...
}:
{
  # Nix settings
  nixpkgs.config.allowUnfree = true;
  nix = {
    # GC/Optimise requires nix.enable which can be false on platforms like macOS
    gc = lib.mkIf config.nix.enable {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    optimise.automatic = config.nix.enable;
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [ username ];
    };
  };

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
