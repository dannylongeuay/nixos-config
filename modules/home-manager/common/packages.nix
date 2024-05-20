{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      jq
      neofetch
      tldr
      unzip
    ];
}
