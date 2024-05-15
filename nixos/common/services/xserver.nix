{ host_info, ... }:

{
  services = {
    displayManager.sddm.enable = true;
    libinput.enable = true;
    xserver = {
      enable = true;
      desktopManager.plasma5.enable = true;
      videoDrivers = host_info.video_drivers;
    };
  };
}
