{ pkgs, ... }:

{
  catppuccin = {
    flavour = "mocha";
    accent = "mauve";
  };

  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.mochaDark;
    name = "Catppuccin-Mocha-Dark-Cursors";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  home.packages =
    [
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
    ];

  gtk = {
    enable = true;
    catppuccin.enable = true;
  };

  xdg.enable = true;
}
