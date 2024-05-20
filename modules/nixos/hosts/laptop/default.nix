{
  networking.hostName = "laptop";

  users.users.cyberdan = {
    isNormalUser = true;
    description = "Daniel Longeuay";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  imports =
    [
      ./hardware-configuration.nix
      ../../common
      ../../gui
      ../../nvidia
      ../../sound
    ];
}
