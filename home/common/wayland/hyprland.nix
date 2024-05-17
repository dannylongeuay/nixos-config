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
      input = {
        sensitivity = -0.2;
        accel_profile = "flat";
        kb_options = "caps:escape";
      };
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
          "$mod CTRL, SPACE, exec, tofi-run | xargs hyprctl dispatch exec --"
          "$mod, Q, killactive,"

          "$mod CTRL, Q, exec, wlogout --buttons-per-row 2 --column-spacing 125 --row-spacing 25 --show-binds"
          "$mod, ESCAPE, exec, sleep 1 && hyprctl dispatch dpms off && hyprlock"
          ", PRINT, exec, hyprshot -m region"

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
          "$mod, RETURN, togglespecialworkspace"
        ];
      bindl =
        [
          "$mod, BACKSPACE, exec, sleep 1 && hyprctl dispatch dpms on"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioPrev, exec, playerctl -p spotify previous"
          ", XF86AudioPlay, exec, playerctl -p spotify play-pause"
          ", XF86AudioNext, exec, playerctl -p spotify next"
        ];
      bindel =
        [
          ", XF86AudioRaiseVolume, exec, wpctl set-volume --limit 1.0 @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume --limit 1.0 @DEFAULT_AUDIO_SINK@ 5%-"
        ];
    };
  };
}
