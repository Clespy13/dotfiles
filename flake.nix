{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };    

    plugin-tiger-vim.url = "github:chclouse/tiger-vim";
    plugin-tiger-vim.flake = false;
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

    in
      rec {
        inherit lib;

        nixosModules = ./modules/nixos;
        homeManagerModules = import ./modules/home-manager;

        nixosConfigurations = {
          nixos = lib.nixosSystem {
            modules = [
              ./profiles/personal
              nixosModules
              home-manager.nixosModules.default
            ];
            specialArgs = {
              inherit inputs outputs unstable;
            };
          };

          server = lib.nixosSystem {
            specialArgs = { inherit inputs; };
            modules = [ 
              ./profiles/server
              nixosModules
              home-manager.nixosModules.default
            ];
          };
        };
    };
}
