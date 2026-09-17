{
  pkgs,
  lib,
  profile,
  username,
  ...
}:
{
  imports = [
    ./shell.nix
    ./nvim.nix
  ]
  ++ lib.optionals (profile == "desktop") [ ./desktop.nix ]
  ++ lib.optionals (profile == "macbook") [ ./darwin.nix ]
  ++
    lib.optionals
      (
        !builtins.elem profile [
          "work"
          "nas"
        ]
      )
      [
        ../../modules/packages/gui.nix
        ../../modules/packages/ai.nix
      ];

  # Home Manager configuration
  programs.home-manager.enable = true;
  home.stateVersion = "25.11";
  home.username = username;
  home.homeDirectory =
    if pkgs.stdenv.hostPlatform.isDarwin then
      lib.mkForce "/Users/${username}"
    else
      lib.mkForce "/home/${username}";

  # Nix package cache
  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;

  # Git configuration
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
    # Signing
    signing =
      lib.mkIf
        (builtins.elem profile [
          "desktop"
          "macbook"
        ])
        {
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

  # SSH Keys
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        forwardAgent = true;
      };
      "*github.com" = {
        user = "git";
        identityFile = "~/.ssh/github";
        identitiesOnly = true;
      };
      "ssh.dev.azure.com" = {
        user = "git";
        identityFile = "~/.ssh/ctc-azure";
        identitiesOnly = true;
      };
    };
  };
}
