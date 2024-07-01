{ pkgs, config, ... }:

{
  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "mauve";
    pointerCursor = {
      enable = true;
      accent = "dark";
      flavor = config.catppuccin.flavor;
    };
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
