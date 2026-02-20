{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pinentry_mac
    httptoolkit
  ];

  # GPG configuration
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry_mac;
  };
}
