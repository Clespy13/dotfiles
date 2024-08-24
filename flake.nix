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

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
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
    in
    {
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs unstable outputs; };
        modules = [
          ./profiles/personal
        ];
      };

      homeConfigurations = {
        # replace with your username@hostname
        "clem@nixos" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = {inherit inputs outputs unstable;};
          modules = [
            ./profiles/personal/home.nix
          ];
        };
      };
    };
}
