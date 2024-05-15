{
  description = "Home Manager configuration of cyberdan";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { system = system; config.allowUnfree = true; };
      lib = nixpkgs.lib;
      host_info_home_desktop = {
        name = "desktop";
        video_drivers = [ "nvidia" ];
      };
      user_info_home = rec {
        name = "cyberdan";
        description = "Daniel Longeuay";
        home_dir = "/home/${name}";
      };
    in
    {
      nixosConfigurations."${host_info_home_desktop.name}" = lib.nixosSystem {
        inherit system;
        inherit pkgs;
        specialArgs = {
          host_info = host_info_home_desktop;
          user_info = user_info_home;
        };
        modules = [ ./profiles/cyberdan/desktop/configuration.nix ];
      };
      homeConfigurations."${user_info_home.name}@${host_info_home_desktop.name}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          user_info = user_info_home;
        };
        modules = [ ./profiles/cyberdan/desktop/home.nix ];
      };
    };
}
