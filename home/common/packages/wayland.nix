{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      dunst
      hyprlock
      hyprshot
      hyprpaper
      hyprcursor
      wl-clipboard
    ];
}
