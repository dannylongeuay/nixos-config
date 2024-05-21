{
  description = "Home Manager configuration of cyberdan";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { nixpkgs, home-manager, catppuccin, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { system = system; config.allowUnfree = true; };
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations.desktop = lib.nixosSystem {
        inherit system;
        inherit pkgs;
        modules =
          [
            ./modules/nixos/hosts/desktop
            catppuccin.nixosModules.catppuccin
          ];
      };
      homeConfigurations."cyberdan@desktop" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules =
          [
            ./modules/home-manager/user/cyberdan
            catppuccin.homeManagerModules.catppuccin
          ];
      };
      nixosConfigurations.laptop = lib.nixosSystem {
        inherit system;
        inherit pkgs;
        modules =
          [
            ./modules/nixos/hosts/laptop
            catppuccin.nixosModules.catppuccin
          ];
      };
      homeConfigurations."cyberdan@laptop" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules =
          [
            ./modules/home-manager/user/cyberdan
            catppuccin.homeManagerModules.catppuccin
          ];
      };
    };
}
