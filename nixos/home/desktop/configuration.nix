{
  imports =
    [
      ../../common/common.nix
      ./hardware-configuration.nix
    ];

  networking.hostName = "desktop";
}
