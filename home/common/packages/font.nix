{ pkgs, ... }:

{
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
}
