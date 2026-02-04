{ profile, ... }:
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
      ssh = if (profile != "work") then "kitten ssh" else "ssh";
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
      scan_timeout = 1000;
    };
  };

  programs.kitty = {
    enable = profile != "work";
  };

  programs.pay-respects.enable = true;

  programs.lazygit = {
    enable = true;
    settings = {
      disableStartupPopups = true;
      notARepository = "skip";
      promptToReturnFromSubprocess = false;
      update.method = "never";
      git = {
        commit.signOff = true;
        parseEmoji = true;
      };
      gui = {
        showListFooter = false;
        showRandomTip = false;
        showCommandLog = false;
        nerdFontsVersion = "3";
      };
    };
  };
}
