{ config, ... }:

{
  imports = [
    ./packages/entry.nix
    ./programs/entry.nix
    ./wayland/entry.nix
  ];

  home.sessionVariables = {
    FLAKE = "${config.home.homeDirectory}/nixos-config";
  };
}
