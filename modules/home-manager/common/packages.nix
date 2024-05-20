{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      bc
      bottom
      dua
      eza
      fd
      httpie
      jq
      fastfetch
      ncdu
      ripgrep
      tldr
      unzip
    ];
}
