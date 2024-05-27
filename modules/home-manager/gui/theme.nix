{ pkgs, ... }:

{
  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.mochaDark;
    name = "Catppuccin-Mocha-Dark-Cursors";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;
    catppuccin = {
      enable = true;
      gnomeShellTheme = false;
      cursor.enable = false;
      icon.enable = false;
    };
  };
}
