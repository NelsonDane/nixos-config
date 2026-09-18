_: {
  flake.modules.homeManager.git = _: {
    programs.git = {
      enable = true;
      lfs.enable = true;
      ignores = [
        ".codex"
        ".claude/*"
        ".DS_Store"
        ".envrc"
        ".direnv/*"
      ];
      settings = {
        user = {
          name = "Nelson Dane";
          email = "47427072+NelsonDane@users.noreply.github.com";
        };
        init.defaultBranch = "main";
        fetch.prune = true;
        pull.rebase = true;
        rebase = {
          autoStash = true;
          autoSquash = true;
          updateRefs = true;
        };
      };
      includes = [
        {
          condition = "hasconfig:remote.*.url:*ssh.dev.azure.com:v3/**";
          contents = {
            user = {
              name = "Nelson Dane";
              email = "ndane@ctconline.com";
            };
            commit.gpgSign = false;
            tag.gpgSign = false;
          };
        }
      ];
    };
  };

  # Enable commit signing if imported by host
  flake.modules.homeManager.git-signing = { lib, ... }: {
    programs.git.signing = {
      format = "ssh";
      key = "~/.ssh/signing_ed25519";
      signByDefault = true;
      allowedSigners =
        let
          signingPub = lib.strings.trim (builtins.readFile ../../secrets/signing_ed25519.pub);
        in
        "47427072+NelsonDane@users.noreply.github.com namespaces=\"git\" ${signingPub}";
    };
  };
}
