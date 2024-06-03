{
  networking.hostName = "desktop";

  users.users.cyberdan = {
    isNormalUser = true;
    description = "Daniel Longeuay";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  nix.gc.dates = "03:00";

  imports =
    [
      ./hardware-configuration.nix
      ../../common
      ../../gui
      ../../nvidia
      ../../sound
    ];
}
