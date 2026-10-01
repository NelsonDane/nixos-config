_: {
  flake.modules.darwin.macbook-linux-builder = { pkgs, lib, ... }: {
    nix.linux-builder = {
      enable = true;
      # https://github.com/applicative-systems/vzvm
      package = pkgs.darwin.linux-builder-vz;
      systems = [
        "aarch64-linux"
        "x86_64-linux"
      ];
      supportedFeatures = [
        "kvm"
        "benchmark"
        "big-parallel"
        # "nixos-test" # Requires M3
      ];
      config.virtualisation = {
        # vz.nestedVirtualization = true; # Requires M3
        cores = lib.mkForce 4;
        memorySize = lib.mkForce 8192;
      };
    };
  };
}
