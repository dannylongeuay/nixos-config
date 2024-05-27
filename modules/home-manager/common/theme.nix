{ pkgs, ... }:

{
  catppuccin = {
    enable = true;
    flavour = "mocha";
    accent = "mauve";
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

  xdg.enable = true;
}
