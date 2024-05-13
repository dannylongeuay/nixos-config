{
  imports =
    [
      ../../../nixos/common/entry.nix
      ./hardware-configuration.nix
    ];

  networking.hostName = "desktop";

  services.xserver.videoDrivers = [ "nvidia" ];
}
