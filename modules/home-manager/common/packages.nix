{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      asciinema
      asciiquarium
      bc
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
