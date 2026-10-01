_: {
  flake.modules.homeManager.gui = { pkgs, ... }: {
    home.packages = with pkgs; [
      brave
      vscode
      httptoolkit
    ];
  };
}
