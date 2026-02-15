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
      k = "kubectl";
      v = "nvim";
      c = "clear";
      p = "python";
      lg = "lazygit";
      reload = "exec zsh";
      nix-shell = "nix-shell --run $SHELL";
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
    themeFile = "rose-pine";
    settings = {
      enable_audio_bell = false;
      font_size = 16;
    };
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
        # Rose theme: https://github.com/rose-pine/lazygit/blob/main/themes/rose-pine.yml
        theme = {
          activeBorderColor = [
            "#31748f"
            "bold"
          ];
          inactiveBorderColor = [ "#6e6a86" ];
          searchingActiveBorderColor = [
            "#ebbcba"
            "bold"
          ];
          optionsTextColor = [ "#9ccfd8" ];
          selectedLineBgColor = [ "#31748f" ];
          inactiveViewSelectedLineBgColor = [
            "#26233a"
            "bold"
          ];
          cherryPickedCommitFgColor = [ "#1f1d2e" ];
          cherryPickedCommitBgColor = [ "#ebbcba" ];
          markedBaseCommitFgColor = [ "#9ccfd8" ];
          markedBaseCommitBgColor = [ "#f6c177" ];
          unstagedChangesColor = [ "#eb6f92" ];
          defaultFgColor = [ "#e0def4" ];
        };
      };
    };
  };
}
