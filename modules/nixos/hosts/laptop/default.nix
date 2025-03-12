{
  networking.hostName = "laptop";

  users.users.cyberdan = {
    isNormalUser = true;
    description = "Daniel Longeuay";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nix.gc.dates = "20:00";

  services.blueman.enable = true;

  imports =
    [
      ./hardware-configuration.nix
      ../../common
      ../../gui
      ../../nvidia
      ../../sound
    ];
}
