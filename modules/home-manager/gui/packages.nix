{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      brightnessctl
      digital
      firefox
      libnotify
    ];
}
