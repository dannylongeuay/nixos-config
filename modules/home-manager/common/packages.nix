{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      aichat
      asciinema
      asciiquarium
      awscli2
      cbonsai
      doctl
      # dysk
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
      nix-search-tv
      (
        pkgs.writeShellScriptBin
          "ns"
          (builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh")
      )
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
      k = "kubectl";
      ll = "eza -la";
      ls = "eza";
      we = "watchexec";
    };
  };
}
