{ pkgs, ... }:

{
  services.nix-daemon.enable = true;

  system.stateVersion = 4;

  nixpkgs.hostPlatform = "aarch64-darwin";

  environment.systemPackages = with pkgs;
    [
      nh
    ];

  imports =
    [
      ../../nixos/common/environment.nix
      ../../nixos/common/nix.nix
      ../../nixos/common/programs.nix
    ];
}
