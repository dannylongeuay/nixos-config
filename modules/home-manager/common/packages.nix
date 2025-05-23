{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      asciinema
      asciiquarium
      awscli2
      doctl
      eza
      fd
      httpie # xh - rust alternative
      # hyperfine - benchmarking tool
      jq
      just # mask - CLI task runner defined by markdown
      kubectl
      libqalculate
      fastfetch
      ncdu
      nix-your-shell
      # presenterm - terminal slideshow presentation tool
      ripgrep
      unzip
      watchexec
    ];

  programs.fish = {
    shellAbbrs = {
      c = "clear";
      # break muscle memory
      clear = "# stop typing 'clear', use 'c' instead!";
      find = "fd";
      grep = "rg";
      ll = "eza -la";
      ls = "eza";
      k = "kubectl";
      we = "watchexec";
    };
  };
}
