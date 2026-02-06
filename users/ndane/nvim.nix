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
    plugins.neo-tree.enable = true;

    # Telescope
    plugins.telescope.enable = true;

    # Git signs
    plugins.gitsigns.enable = true;

    # Toggleterm
    plugins.toggleterm.enable = true;

    # Lazygit
    plugins.lazygit.enable = true;

    # QoL Plugins
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
  };

  # Env configuration
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
