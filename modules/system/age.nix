{
  config,
  lib,
  pkgs,
  agenix-rekey,
  ...
}:
with lib;
{
  options.age.hostPubkey = mkOption {
    type = types.nullOr types.str;
    default = null;
    description = "The system's public key for age encryption.";
  };

  config = {
    age.rekey = {
      hostPubkey = mkIf (config.age.hostPubkey != null) config.age.hostPubkey;
      masterIdentities = [ ../../secrets/yubikey.pub ];
      storageMode = "local";
      localStorageDir = ../../secrets/rekeyed/${config.networking.hostName};
    };
    environment.systemPackages = mkIf (config.age.hostPubkey != null) [
      agenix-rekey.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
