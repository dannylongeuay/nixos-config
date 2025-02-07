{
  networking.hostName = "laptop";

  users.users.cyberdan = {
    isNormalUser = true;
    description = "Daniel Longeuay";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  nix.gc.dates = "20:00";

  imports =
    [
      ./hardware-configuration.nix
      ../../common
      ../../gui
      ../../nvidia
      ../../sound
    ];
}
