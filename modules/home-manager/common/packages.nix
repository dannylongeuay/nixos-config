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
      httpie
      jq
      just
      kubectl
      libqalculate
      fastfetch
      ncdu
      nix-your-shell
      ripgrep
      unzip
      watchexec
    ];

  programs.fish = {
    shellAbbrs = {
      c = "clear";
      # break muscle memory
      clear = "# stop typing 'clear', use 'c' instead!";
      grep = "rg";
      ll = "eza -la";
      ls = "eza";
      k = "kubectl";
      we = "watchexec";
    };
  };
}
