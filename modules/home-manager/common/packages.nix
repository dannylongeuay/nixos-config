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
      just
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
      ll = "eza -la";
      k = "kubectl";
    };
  };
}
