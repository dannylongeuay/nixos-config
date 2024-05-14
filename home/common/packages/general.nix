{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      jq
      libnotify
      neofetch
      spotify
      tldr
      unzip
    ];
}
