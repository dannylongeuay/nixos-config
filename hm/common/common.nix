{ config, ... }:

{
  imports = [
    ./programs/programs.nix
  ];

  home.sessionVariables = {
    NNN_OPENER = "${config.home.homeDirectory}/.config/nnn/plugins/nuke";
  };

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "SUPER";
      monitor = ",3440x1440@120,auto,1";
      general = {
        layout = "dwindle";
      };
      windowrule = [
        "tile,^(firefox)"
      ];
      cursor = {
        no_hardware_cursors = true;
      };
      bind =
        [
          "$mod, T, exec, kitty"
          "$mod, F, exec, firefox"
          "$mod, Q, killactive,"

          "$mod SHIFT, Q, exit,"

          "$mod, h, movefocus, l"
          "$mod, j, movefocus, d"
          "$mod, k, movefocus, u"
          "$mod, l, movefocus, r"

          "$mod CTRL, h, swapwindow, l"
          "$mod CTRL, j, swapwindow, d"
          "$mod CTRL, k, swapwindow, u"
          "$mod CTRL, l, swapwindow, r"

          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
        ];
    };
  };
}
