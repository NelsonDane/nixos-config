{
  username,
  pkgs,
  lib,
  ...
}:
let
  ctcRootCa = "/etc/nixos-local/ctc-root.crt";
in
{
  wsl.enable = true;
  wsl.defaultUser = username;
  wsl.interop.register = true;
  users.users.${username} = {
    isNormalUser = true;
    uid = 1001;
    extraGroups = [ "docker" ];
  };
  programs.nix-ld.enable = true; # Needed for vscode launching

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
}
