_: {
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.extraPools = [ "Shell" ];
  services.zfs.autoScrub.enable = true;
  services.zfs.trim.enable = true;
}
