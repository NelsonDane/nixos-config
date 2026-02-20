{ pkgs, ... }:
{
  # Neovim config
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    waylandSupport = pkgs.stdenv.isLinux;
    nixpkgs.useGlobalPkgs = true;

    # Performance
    performance = {
      byteCompileLua = {
        enable = true;
        configs = true;
        initLua = true;
        luaLib = true;
        nvimRuntime = true;
        plugins = true;
      };
      # Combine plugins
      combinePlugins = {
        enable = true;
        standalonePlugins = [ ];
      };
    };

    # Options
    opts = {
      number = true;
      relativenumber = true;
      showtabline = 2;
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      softtabstop = 2;
      autoindent = true;
      showmode = false;
      cursorline = true;
      hlsearch = true;
      undofile = true;
      wrap = false;
      guicursor = "";
    };

    # Global leader key
    globals.mapleader = " ";

    # Colorscheme
    colorschemes.rose-pine = {
      enable = true;
      autoLoad = true;
      settings.variant = "main";
    };

    # Icons
    plugins.mini = {
      enable = true;
      mockDevIcons = true;
      modules.icons = { };
    };

    # Lualine
    plugins.lualine.enable = true;

    # File explorer
    plugins.neo-tree = {
      enable = true;
      settings = {
        window.position = "left";
        window.width = 32;
        filesystem.filtered_items = {
          visible = true;
          hide_dotfiles = false;
          hide_gitignored = false;
        };
      };
    };

    # Telescope
    plugins.telescope.enable = true;

    # Git signs
    plugins.gitsigns.enable = true;

    # Toggleterm
    plugins.toggleterm = {
      enable = true;
      settings = {
        direction = "horizontal";
        size = 15;
        open_mapping = null;
      };
    };

    # Lazygit
    plugins.lazygit.enable = true;

    # QoL Plugins
    plugins.nvim-autopairs.enable = true;
    plugins.nvim-surround.enable = true;
    plugins.whitespace.enable = true;
    plugins.comment.enable = true;
    plugins.snacks = {
      enable = true;
      settings.bigfile.enabled = true;
    };
    plugins.todo-comments.enable = true;

    # LSP
    plugins.lspconfig = {
      enable = true;
      inlayHints.enable = true;
      servers = {
        ts_ls.enable = true; # TypeScript
        pylsp.enable = true; # Python
        ruff.enable = true; # Python formatter
        ty.enable = true; # Python type checker
        harper_ls.enable = true; # Grammar
        jsonls.enable = true; # JSON
        typos_lsp.enable = true; # Spelling
        yamlls.enable = true; # YAML
      };
    };

    # Completion
    plugins.cmp = {
      enable = true;
      settings = {
        mapping = {
          "<Tab>" = "cmp.mapping.confirm({ select = true })";
        };
        sources = [
          { name = "nvim_lsp"; }
          { name = "buffer"; }
          { name = "path"; }
        ];
      };
    };

    # Keybinds
    keymaps = [
      # Neotree
      {
        mode = "n";
        key = "<C-/>";
        action = "<cmd>Neotree toggle<cr>";
        options = {
          desc = "Toggle Neotree";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<C-_>";
        action = "<cmd>Neotree toggle<cr>";
        options = {
          desc = "Toggle Neotree";
          silent = true;
        };
      }

      # Lazygit
      {
        mode = "n";
        key = "lg";
        action = "<cmd>LazyGit<cr>";
        options = {
          desc = "LazyGit";
          silent = true;
        };
      }

      # Toggleterm
      {
        mode = "n";
        key = "<S-T>";
        action = "<cmd>ToggleTerm<cr>";
        options = {
          desc = "Toggle terminal";
          silent = true;
        };
      }
      {
        mode = "t";
        key = "<Esc>";
        action = "<C-\\><C-n>";
        options = {
          desc = "Exit terminal mode";
          silent = true;
        };
      }

      # Window nav
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
        options = {
          desc = "Go left";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
        options = {
          desc = "Go down";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
        options = {
          desc = "Go up";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
        options = {
          desc = "Go right";
          silent = true;
        };
      }

      # Same window navigation while *in* terminal mode
      {
        mode = "t";
        key = "<C-h>";
        action = "<C-\\><C-n><C-w>h";
        options = {
          desc = "Go left (terminal)";
          silent = true;
        };
      }
      {
        mode = "t";
        key = "<C-j>";
        action = "<C-\\><C-n><C-w>j";
        options = {
          desc = "Go down (terminal)";
          silent = true;
        };
      }
      {
        mode = "t";
        key = "<C-k>";
        action = "<C-\\><C-n><C-w>k";
        options = {
          desc = "Go up (terminal)";
          silent = true;
        };
      }
      {
        mode = "t";
        key = "<C-l>";
        action = "<C-\\><C-n><C-w>l";
        options = {
          desc = "Go right (terminal)";
          silent = true;
        };
      }
    ];
  };

  # Env configuration
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
