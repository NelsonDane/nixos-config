{ config, ... }:
let
  gitSigningModule = { lib, pkgs, ... }: with lib;
    {
      config = {
        age = {
          hostPubkey = mkDefault "age1yubikey1qdqlzzmfggrcd22747urjfdj74sgahju4gv3czmyc8497juu6pakgs8u3m5";
          identityPaths = [ ../../secrets/yubikey.pub ];
          secrets.git-signing-key = {
            rekeyFile = ../../secrets/git-signing-key.age;
            owner = config.people.primaryUsername;
            mode = "0600";
            path = "${
              if pkgs.stdenv.hostPlatform.isDarwin then
                "/Users/${config.people.primaryUsername}"
              else
                "/home/${config.people.primaryUsername}"
            }/.ssh/signing_ed25519";
          };
        };
        environment.systemPackages = [ pkgs.age-plugin-yubikey ];
      };
    };
in
{
  flake.modules.nixos.git-signing = gitSigningModule;
  flake.modules.darwin.git-signing = gitSigningModule;
}
