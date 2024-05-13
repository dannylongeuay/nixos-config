{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      jq
      neofetch
      spotify
      tldr
      unzip
    ];
}
