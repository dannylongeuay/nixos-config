{ pkgs, ... }:

{
  programs.fish = {
    shellAbbrs = {
      hms = "home-manager switch --flake .#workUser";
      nhs = "nh home switch --ask --configuration workUser .";
      drs = "darwin-rebuild switch --flake .#workLaptop";
    };
  };

  home.username = "daniel.longeuay";
  home.homeDirectory = "/Users/daniel.longeuay";
  home.stateVersion = "23.11";

  programs.kitty.settings = {
    macos_show_window_title_in = "menubar";
    hide_window_decorations = "titlebar-only";
    window_margin_width = 5;
  };

  home.packages = with pkgs;
    [
      aws-nuke
      skhd
      yabai
    ];

  imports =
    [
      ../../common
      ../../gui/terminal/kitty.nix
      ../../shell
      ../../tui
      ../../vc
    ];
}
