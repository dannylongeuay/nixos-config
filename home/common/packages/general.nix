{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      jq
      libnotify
      neofetch
      playerctl
      spotify
      tldr
      unzip
    ];
}
