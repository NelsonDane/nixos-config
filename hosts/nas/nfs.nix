_: {
  services.nfs.server = {
    enable = true;
    exports = ''
      /Shell/media        10.0.2.0/24(rw,all_squash,anonuid=1000,anongid=1000,no_subtree_check)
      /Shell/ISOs         10.0.2.5(rw,all_squash,anonuid=1000,anongid=1000,no_subtree_check)
    '';
  };
  networking.firewall.allowedTCPPorts = [ 2049 ];
}
