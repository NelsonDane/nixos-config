_: {
  # Linux-builder on macOS (https://github.com/input-output-hk/nix-linux-builder)
  services.nix-linux-builder = {
    enable = true;
    usePrebuilt = true;
    systems = [
      "aarch64-linux"
      "x86_64-linux"
    ];
  };
}
