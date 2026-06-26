{ ... }: {
  imports = [
    ../../modules/system/disko.nix
    ./hardware.nix
    ../../modules/system/impermanence.nix
  ];
  # Set disk ID
  disko.diskID = "unknown"; # TODO

}
