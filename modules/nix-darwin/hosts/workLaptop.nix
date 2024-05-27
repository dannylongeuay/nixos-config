{
  services.nix-daemon.enable = true;

  system.stateVersion = 4;

  nixpkgs.hostPlatform = "aarch64-darwin";

  imports =
    [
      ../../../nixos/common/environment.nix
      ../../../nixos/common/nix.nix
      ../../../nixos/common/programs.nix
    ];
}
