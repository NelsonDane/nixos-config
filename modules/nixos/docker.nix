_: {
  flake.modules.nixos.docker = {
    virtualisation.docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
      autoPrune = {
        enable = true;
        flags = [ "--all" ];
        dates = "weekly";
      };
    };
  };

  flake.modules.darwin.docker = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      colima
      docker
      docker-compose
    ];
  };
}
