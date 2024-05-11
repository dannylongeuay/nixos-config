{ pkgs, ... }:

{
  imports =
    [
      ./fish/fish.nix
      ./helix.nix
      ./nnn.nix
      ./vc.nix
      ./wezterm/wezterm.nix
    ];

  home.packages = with pkgs;
    [
      cargo
      go
      jq
      neofetch
      (pkgs.nerdfonts.override {
        fonts =
          [
            "CascadiaCode"
            "DroidSansMono"
            "Hack"
            "JetBrainsMono"
            "SourceCodePro"
          ];
      })
      rustc
      spotify
      tldr
      unzip
      wl-clipboard
    ];

  programs = {
    home-manager.enable = true;
    fzf.enable = true;
    zoxide.enable = true;
  };
}
