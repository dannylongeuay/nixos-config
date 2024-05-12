{
  imports =
    [
      ../../common/common.nix
      ./hardware-configuration.nix
    ];

  networking.hostName = "desktop";

  services.xserver.videoDrivers = [ "nvidia" ];
}
