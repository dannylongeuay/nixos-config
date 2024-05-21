{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      bc
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
