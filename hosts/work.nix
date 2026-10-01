{ config, inputs, ... }: {
  flake.nixosConfigurations.work = config.flake.lib.mkNixos {
    modules = [
      inputs.nixos-wsl.nixosModules.default
      config.flake.modules.nixos.base
      (
        { pkgs, lib, ... }:
        let
          ctcRootCa = "/etc/nixos-local/ctc-root.crt";
        in
        {
          wsl.enable = true;
          wsl.defaultUser = config.people.primaryUsername;
          wsl.interop.register = true;
          users.users.${config.people.primaryUsername} = {
            isNormalUser = true;
            uid = 1001;
            extraGroups = [ "docker" ];
          };
          programs.nix-ld.enable = true; # Needed for vscode launching

          environment.systemPackages = with pkgs; [
            azure-cli
            azure-functions-core-tools
            dotnet-sdk_8
            uv
            python313
          ];

          virtualisation.docker.enable = true;

          security.pki.certificates = lib.optional (builtins.pathExists ctcRootCa) (
            builtins.readFile ctcRootCa
          );

          # This value determines the NixOS release from which the default
          # settings for stateful data, like file locations and database versions
          # on your system were taken. It's perfectly fine and recommended to leave
          # this value at the release version of the first install of this system.
          # Before changing this value read the documentation for this option
          # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
          system.stateVersion = "25.05"; # Did you read the comment?

          # Home Manager Modules
          home-manager.users.${config.people.primaryUsername} = {
            imports = [
              config.flake.modules.homeManager.ai
              config.flake.modules.homeManager.base
              config.flake.modules.homeManager.git
              config.flake.modules.homeManager.shell
              config.flake.modules.homeManager.nvim
            ];
            programs.zsh.shellAliases.ssh = lib.mkForce "ssh"; # Disable ssh kitten
            programs.kitty.enable = lib.mkForce false; # Disable kitty terminal
          };
        }
      )
    ];
  };
}
