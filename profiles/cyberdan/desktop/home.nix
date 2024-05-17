{ pkgs, ... }:

{
  home.username = "cyberdan";
  home.homeDirectory = "/home/cyberdan";
  home.stateVersion = "23.11";

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.catppuccin-cursors.mochaDark;
    name = "Catppuccin-Mocha-Dark-Cursors";
    size = 24;
  };

  gtk = {
    enable = true;
  };

  imports = [
    ../../../home/common
  ];
}
