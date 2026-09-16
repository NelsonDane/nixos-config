{ pkgs, username, ... }: {
  programs.opencode = {
    enable = true;
    enableMcpIntegration = true;
    extraPackages = with pkgs; [
      lsof
      ripgrep
    ];
    settings = {
      plugin = [ "superpowers@git+https://github.com/obra/superpowers.git" ];
      skills.paths = [ "/home/${username}/slop/skills" ];
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
        command = "nix";
        args = [
          "run"
          "github:utensils/mcp-nixos"
        ];
      };
    };
  };
}
