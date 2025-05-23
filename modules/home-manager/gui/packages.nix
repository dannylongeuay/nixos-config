{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      brightnessctl
      digital
      firefox
      libnotify
      playerctl
      spotify # ncspot - rust TUI alternative
    ];
}
