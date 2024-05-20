{
  networking.hostName = "desktop";

  imports =
    [
      ./hardware-configuration.nix
      ./user.nix
      ../../common
      ../../gui
      ../../nvidia
      ../../sound
    ];
}
