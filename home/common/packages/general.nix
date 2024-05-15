{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      firefox
      jq
      libnotify
      neofetch
      playerctl
      spotify
      tldr
      unzip
    ];
}
