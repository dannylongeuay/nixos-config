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
      c = "clear";
      # break muscle memory
      clear = "clear foo";
      grep = "rg";
      ll = "eza -la";
      ls = "eza";
      k = "kubectl";
    };
  };
}
