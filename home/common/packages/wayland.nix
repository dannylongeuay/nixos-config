{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      dunst
      hyprshot
      hyprpaper
      hyprcursor
      wl-clipboard
    ];
}
