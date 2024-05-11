{
  description = "Home Manager configuration of cyberdan";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { system = system; config.allowUnfree = true; };
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations."desktop" = lib.nixosSystem {
        inherit system;
        inherit pkgs;
        modules = [ ./nixos/home/desktop/configuration.nix ];
      };
      homeConfigurations."cyberdan@desktop" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./hm/home/desktop/home.nix ];
      };
    };
}
