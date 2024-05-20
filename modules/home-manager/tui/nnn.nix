{ config, pkgs, ... }:

{
  home.sessionVariables = {
    NNN_OPENER = "${config.home.homeDirectory}/.config/nnn/plugins/nuke";
  };

  programs.fish.shellAbbrs.nnn = "nnn -c";

  programs.nnn = {
    enable = true;
    plugins = {
      mappings = {
        f = "fzcd";
      };
      src =
        (pkgs.fetchFromGitHub {
          owner = "jarun";
          repo = "nnn";
          rev = "v4.9";
          sha256 = "sha256-g19uI36HyzTF2YUQKFP4DE2ZBsArGryVHhX79Y0XzhU=";
        }) + "/plugins";
    };
    package = pkgs.nnn.override ({ withNerdIcons = true; });
    extraPackages = with pkgs;
      [
        atool
        exiftool
        fzf
        glow
        mediainfo
        sxiv
      ];
  };
}
