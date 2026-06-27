{ pkgs, ... }: {
  # Linux-builder on macOS
  nix.linux-builder = {
    enable = true;
    package = pkgs.darwin.linux-builder-x86_64;
    ephemeral = true;
    systems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    maxJobs = 4;
    config = {
      virtualisation = {
        darwin-builder = {
          diskSize = 20 * 1024; # 20GB
          memorySize = 16 * 1024; # 16GB
        };
        cores = 8;
      };
      # Binfmt for running aarch64-linux builds on x86_64
      boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
    };
  };
}
