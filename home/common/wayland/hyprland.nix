{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "SUPER";
      monitor = ",highrr,auto,1";
      exec-once = [
        "waybar"
        "dunst"
      ];
      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "WLR_NO_HARDWARE_CURSORS,1"
      ];
      general = {
        layout = "dwindle";
      };
      windowrule = [
        "tile,^(firefox)"
      ];
      bind =
        [
          "$mod, T, exec, kitty"
          "$mod, F, exec, firefox"
          "$mod, S, exec, spotify"
          "$mod, SPACE, exec, tofi-drun | xargs hyprctl dispatch exec --"
          "$mod, RETURN, exec, tofi-run | xargs hyprctl dispatch exec --"
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
