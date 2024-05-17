{ pkgs, ... }:

{
  home.username = "cyberdan";
  home.homeDirectory = "/home/cyberdan";
  home.stateVersion = "23.11";

  home.pointerCursor = {
    gtk.enable = true;
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
  };

  gtk = {
    enable = true;
  };

  imports = [
    ../../../home/common
  ];
}
