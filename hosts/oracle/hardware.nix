_: {
  flake.modules.nixos.oracle-hardware = { lib, modulesPath, ... }: {
    imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

    boot.kernelParams = [
      "console=ttyAMA0"
      "console=tty1"
    ];

    zramSwap.enable = true;

    nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
  };
}
