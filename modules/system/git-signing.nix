{
  lib,
  pkgs,
  username,
  ...
}:
with lib;
{
  imports = [ ./age.nix ];

  # Provision the SSH git commit signing key via agenix, decrypted with the
  # yubikey identity at activation.
  config = {
    age = {
      hostPubkey = mkDefault "age1yubikey1qdqlzzmfggrcd22747urjfdj74sgahju4gv3czmyc8497juu6pakgs8u3m5";
      identityPaths = [ ../../secrets/yubikey.pub ];
      secrets.git-signing-key = {
        rekeyFile = ../../secrets/git-signing-key.age;
        owner = username;
        mode = "0600";
        path = "${
          if pkgs.stdenv.hostPlatform.isDarwin then "/Users/${username}" else "/home/${username}"
        }/.ssh/signing_ed25519";
      };
    };
    environment.systemPackages = [ pkgs.age-plugin-yubikey ];
  };
}
