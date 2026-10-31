let
  dockerModule = _: {
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
in
{
  flake.modules.nixos.docker = dockerModule;
  flake.modules.darwin.docker = { pkgs, ... }: {
    imports = [ dockerModule ];
    environment.systemPackages = with pkgs; [ colima ];
  };
}
