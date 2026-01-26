{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      ignoreDups = true;
    };

    shellAliases = {
      ls = "ls --color=auto";
      grep = "grep --color=auto";
      ssh = "kitten ssh";
      ff = "fastfetch";
      neofetch = "fastfetch";
      v = "nvim";
      c = "clear";
      p = "python";
      lg = "lazygit";
      reload = "exec zsh";
    };

    initContent = ''
      export GPG_TTY=$(tty)
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;
    };
  };

  programs.kitty = {
    enable = true;
  };

  programs.pay-respects.enable = true;
}
