{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      hyprlock
      hyprshot
      hyprpaper
      hyprcursor
      wl-clipboard
    ];
}
