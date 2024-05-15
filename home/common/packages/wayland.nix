{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      dunst
      hyprshot
      hyprcursor
      wl-clipboard
    ];
}
