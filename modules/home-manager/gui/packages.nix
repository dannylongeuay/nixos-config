{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      firefox
      libnotify
      playerctl
      spotify
    ];
}
