_: {
  flake.modules.nixos.nas-zfs = _: {
    # https://nixos.wiki/wiki/ZFS
    boot.supportedFilesystems = [ "zfs" ];
    boot.zfs.extraPools = [ "Shell" ];
    services.zfs = {
      autoScrub.enable = true;
      autoSnapshot.enable = true;
      trim.enable = true;
    };
  };
}
