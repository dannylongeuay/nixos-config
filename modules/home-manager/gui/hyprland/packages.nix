{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      hyprshot
      hyprcursor
      wl-clipboard
    ];
}
