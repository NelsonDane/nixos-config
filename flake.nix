{
  description = "Nix based machine config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    agenix.url = "github:ryantm/agenix";

    agenix-rekey = {
      url = "github:oddlama/agenix-rekey";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    nix-linux-builder.url = "github:input-output-hk/nix-linux-builder";

    impermanence = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    systems = {
      url = "github:nix-systems/default";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      agenix,
      agenix-rekey,
      home-manager,
      nix-darwin,
      nix-homebrew,
      nix-linux-builder,
      impermanence,
      disko,
      nixos-wsl,
      treefmt-nix,
      nix-index-database,
      systems,
      nixvim,
      stylix,
      ...
    }:
    let
      # User
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
        agenix.nixosModules.default
        agenix-rekey.nixosModules.default
      ];
      hmDarwinModule = [
        home-manager.darwinModules.home-manager
        nix-homebrew.darwinModules.nix-homebrew
        nix-linux-builder.darwinModules.default
        hmCommon
        agenix.nixosModules.default
        agenix-rekey.nixosModules.default
      ];

      # Functions to create NixOS and Darwin systems
      mkNixos =
        { modules, profile }:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit username agenix-rekey; };
          modules =
            modules
            ++ [ (_: { home-manager.extraSpecialArgs = { inherit profile username agenix-rekey; }; }) ]
            ++ hmNixosModule;
        };
      mkDarwin =
        { modules, profile }:
        nix-darwin.lib.darwinSystem {
          specialArgs = { inherit username agenix-rekey; };
          modules =
            modules
            ++ [ (_: { home-manager.extraSpecialArgs = { inherit profile username agenix-rekey; }; }) ]
            ++ hmDarwinModule;
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
            impermanence.nixosModules.impermanence
            stylix.nixosModules.stylix
            { nixpkgs.hostPlatform = "x86_64-linux"; }
          ];
        };

        nas = mkNixos {
          profile = "nas";
          modules = [
            ./hosts/default.nix
            ./hosts/nas
            disko.nixosModules.disko
            impermanence.nixosModules.impermanence
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

      agenix-rekey = agenix-rekey.configure {
        userFlake = self;
        inherit (self) nixosConfigurations;
        inherit (self) darwinConfigurations;
      };

      # Formatting
      formatter = eachSystem (pkgs: treefmtEval.${pkgs.stdenv.hostPlatform.system}.config.build.wrapper);
      checks = eachSystem (pkgs: {
        formatting = treefmtEval.${pkgs.stdenv.hostPlatform.system}.config.build.check self;
      });
    };
}
