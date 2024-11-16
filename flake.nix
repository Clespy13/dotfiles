{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plugin-tiger-vim.url = "github:chclouse/tiger-vim";
    plugin-tiger-vim.flake = false;
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };

      unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      helperLib = import ./helperLib/default.nix { inherit inputs unstable; };
    in
      with helperLib; {
        nixosModules.default = ./modules/nixos;
        homeManagerModules.default = ./modules/home-manager;

        nixosConfigurations = {
          nixos = mkSystem ./profiles/personal/configuration.nix;
        };

        homeConfigurations = {
          "clem@nixos" = mkHome "x86_64-linux" ./profiles/personal/home.nix;
        };
    };
}
