{
  description = "Nix based machine config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";

    nix-darwin.url = "github:LnL7/nix-darwin";

    disko.url = "github:nix-community/disko";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    nixvim.url = "github:nix-community/nixvim";

    nix-index-database.url = "github:nix-community/nix-index-database";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-darwin,
      disko,
      nixos-wsl,
      treefmt-nix,
      nix-index-database,
      systems,
      nixvim,
      ...
    }:
    let
      # User and homepath
      username = "ndane";
      userHome = import ./users/${username}/home.nix;

      # Home Manager common settings
      hmCommon = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = ".nixbak";
        home-manager.users.${username} = userHome;
        home-manager.sharedModules = [
          nixvim.homeModules.nixvim
          nix-index-database.homeModules.default
        ];
      };

      # Home Manager modules
      hmNixosModule = [
        home-manager.nixosModules.home-manager
        hmCommon
      ];
      hmDarwinModule = [
        home-manager.darwinModules.home-manager
        hmCommon
      ];

      # Functions to create NixOS and Darwin systems
      mkNixos =
        { modules, profile }:
        nixpkgs.lib.nixosSystem {
          modules =
            modules ++ [ (_: { home-manager.extraSpecialArgs = { inherit profile; }; }) ] ++ hmNixosModule;
        };
      mkDarwin =
        { modules, profile }:
        nix-darwin.lib.darwinSystem {
          modules =
            modules ++ [ (_: { home-manager.extraSpecialArgs = { inherit profile; }; }) ] ++ hmDarwinModule;
        };

      # Formatting
      eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});
      treefmtEval = eachSystem (pkgs: treefmt-nix.lib.evalModule pkgs ./treefmt.nix);
    in
    {
      nixosConfigurations = {
        desktop = mkNixos {
          profile = "desktop";
          modules = [
            ./hosts/default.nix
            ./hosts/desktop
            disko.nixosModules.disko
            { nixpkgs.hostPlatform = "x86_64-linux"; }
          ];
        };

        work = mkNixos {
          profile = "work";
          modules = [
            ./hosts/default.nix
            ./hosts/work
            nixos-wsl.nixosModules.default
            { nixpkgs.hostPlatform = "x86_64-linux"; }
          ];
        };
      };

      darwinConfigurations = {
        macbook = mkDarwin {
          profile = "macbook";
          modules = [
            ./hosts/default.nix
            ./hosts/macbook
            { nixpkgs.hostPlatform = "aarch64-darwin"; }
          ];
        };
      };

      # Formatting
      formatter = eachSystem (pkgs: treefmtEval.${pkgs.stdenv.hostPlatform.system}.config.build.wrapper);
      checks = eachSystem (pkgs: {
        formatting = treefmtEval.${pkgs.stdenv.hostPlatform.system}.config.build.check self;
      });
    };
}
