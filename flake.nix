{
  description = "flake for nixos configuration of vimlinuz";

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      mnw,
      nix-index-database,
      treefmt-nix,
      ...
    }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
    in
    {
      nixosConfigurations = {

        santosh = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/helios/configuration.nix
            ./overlay.nix
            nix-index-database.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                sharedModules = [
                  mnw.homeManagerModules.mnw
                ];
                useGlobalPkgs = true;
                useUserPackages = true;
                users.santosh = import ./homes/santosh/home.nix;
                extraSpecialArgs = { inherit inputs; };
              };
            }
          ];
          specialArgs = { inherit inputs; };
        };

      };

      formatter.${system} = treefmtEval.config.build.wrapper;

      checks.${system}.formatting = treefmtEval.config.build.check self;

      devShells.${system}.default = treefmtEval.config.build.devShell;

      packages.${system} = {
        neovimDev =
          self.nixosConfigurations.santosh.config.home-manager.users.santosh.programs.mnw.finalPackage.devMode;
        neovim =
          self.nixosConfigurations.santosh.config.home-manager.users.santosh.programs.mnw.finalPackage;
      };

    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    crane-rs = {
      url = "github:vimlinuz/crane-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wall-archive = {
      url = "github:vimlinuz/wall-archive";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    mnw.url = "github:Gerg-L/mnw";

    black-metal-theme-neovim = {
      url = "github:metalelf0/black-metal-theme-neovim";
      flake = false;
    };

    present-neovim = {
      url = "github:chaitanyabsprip/present.nvim";
      flake = false;
    };

    vague-gtk = {
      url = "github:vague-theme/vague-gtk";
      flake = false;
    };
  };
}
