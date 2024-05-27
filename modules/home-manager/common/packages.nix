{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      asciinema
      asciiquarium
      awscli2
      bc
      doctl
      eza
      fd
      httpie
      jq
      kubectl
      fastfetch
      ncdu
      nix-your-shell
      ripgrep
      tldr
      unzip
    ];

  programs.fish = {
    shellAbbrs = {
      grep = "rg";
      ls = "eza";
      k = "kubectl";
    };
  };
}
