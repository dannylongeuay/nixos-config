{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      digital
      firefox
      libnotify
      playerctl
      spotify
    ];
}
