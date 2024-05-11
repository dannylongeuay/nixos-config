{ pkgs, ... }:

{
  imports =
    [
      ./fish/fish.nix
      ./helix.nix
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
      xclip
    ];

  programs = {
    home-manager.enable = true;
    fzf.enable = true;
    zoxide.enable = true;
    nnn.enable = true;
  };
}
