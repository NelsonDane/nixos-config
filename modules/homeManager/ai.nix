_: {
  flake.modules.homeManager.ai = { inputs, pkgs, ... }: {
    programs.opencode = {
      enable = true;
      enableMcpIntegration = true;
      extraPackages = with pkgs; [
        lsof
        ripgrep
        uv
      ];
      settings = {
        plugin = [ "superpowers@git+https://github.com/obra/superpowers.git" ];
        skills.paths = [ (inputs.slop + "/skills") ];
        permission = {
          edit = "allow";
          bash = "allow";
          webfetch = "allow";
        };
      };
    };

    programs.mcp = {
      enable = true;
      servers = {
        nix = {
          command = "uvx";
          args = [ "mcp-nixos" ];
        };
      };
    };
  };
}
