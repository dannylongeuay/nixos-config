{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      jq
      fastfetch
      tldr
      unzip
    ];
}
