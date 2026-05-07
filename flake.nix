{
  description = "flake for nixos configuration of vimlinuz";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    qml-niri = {
      url = "github:imiric/qml-niri/main";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nh = {
      url = "github:nix-community/nh";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    crane-rs = {
      url = "github:vimlinuz/crane-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mdwatch = {
      url = "github:vimlinuz/mdwatch";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wallpaper-archive = {
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

    black-metal-theme-neovim = {
      url = "github:metalelf0/black-metal-theme-neovim";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nixvim,
      ...
    }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {

        santosh = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/helios/configuration.nix
            ./overlay.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                sharedModules = [ nixvim.homeModules.nixvim ];
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
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt;
    };
}
