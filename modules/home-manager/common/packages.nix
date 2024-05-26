{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      asciinema
      asciiquarium
      bc
      dua
      eza
      fd
      httpie
      jq
      fastfetch
      ncdu
      nix-your-shell
      ripgrep
      tldr
      unzip
    ];
}
