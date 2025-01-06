{ config, ... }:

{
  catppuccin = {
    cursors = {
      enable = true;
      accent = "dark";
      flavor = config.catppuccin.flavor;
    };
  };

  home.username = "cyberdan";
  home.homeDirectory = "/home/cyberdan";
  home.stateVersion = "23.11";

  imports = [
    ../../common
    ../../gui
    ../../shell
    ../../tui
    ../../vc
  ];
}
