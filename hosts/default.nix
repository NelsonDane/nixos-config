{ pkgs, ... }:
{
  # Nix settings
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.trusted-users = [ "ndane" ];

  # Set default shell to zsh
  programs.zsh.enable = true;
  users.users.ndane.shell = pkgs.zsh;

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
