_: {
  flake.modules.nixos.frp = { config, ... }: {
    age.secrets.frp-token = {
      rekeyFile = ../../secrets/frp-token.age;
      mode = "0400";
    };

    services.frp.instances.main = {
      enable = true;
      role = "server";
      environmentFiles = [ config.age.secrets.frp-token.path ];
      settings = {
        bindAddr = "0.0.0.0";
        bindPort = 2333;
        auth.token = "{{ .Envs.FRP_TOKEN }}";
      };
    };

    networking.firewall.allowedTCPPorts = [
      2333
      443
    ];
  };
}
