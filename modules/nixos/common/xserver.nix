{
  services.xserver = {
    enable = true;
    # LightDM is enabled by default when no other display manager is enabled
    # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/x11/xserver.nix#L644
    displayManager.lightdm.enable = false;
  };
}
