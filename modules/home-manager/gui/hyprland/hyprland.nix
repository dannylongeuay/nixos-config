{ config, lib, ... }:

{
  config = {
    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        "$mod" = "SUPER";
        monitor = config.hyprland_monitor;
        exec-once =
          [
            "waybar"
            "[workspace special silent] kitty"
          ] ++ config.hyprland_startup_apps;
        general = {
          border_size = 3;
          gaps_in = 5;
          gaps_out = 10;
          "col.active_border" = "$accent";
          "col.inactive_border" = "$surface0";
        };
        dwindle =
          {
            force_split = 2;
          };
        decoration = {
          rounding = 10;
          active_opacity = 1.0;
          inactive_opacity = 1.0;
          blur = {
            enabled = false;
          };
        };
        bezier =
          [
            "easeInOutCirc,0.85,0,0.15,1"
            "easeInOutQuart,0.75,0,0.25,1"
            "easeInOutBack,0.65,-0.5,0.35,1.5"
            "easeOutExpo,0.15,1,0.3,1"
          ];
        animation =
          [
            "windowsIn,1,10,easeInOutQuart,popin"
            "windowsMove,1,10,easeInOutBack,slide"
            "specialWorkspace,1,5,easeInOutCirc,slidevert"
          ];
        ecosystem = {
          no_update_news = true;
          no_donation_nag = true;
        };
        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          background_color = "$base";
        };
        input = {
          sensitivity = config.hyprland_input_sensitivity;
          accel_profile = "adaptive";
          kb_options = "caps:escape";
          follow_mouse = 2;
          repeat_rate = 32;
          repeat_delay = 200;
        };
        device = {
          name = "dll0945:00-04f3:311c-touchpad";
          sensitivity = 0.1;
        };
        cursor = {
          no_hardware_cursors = true;
        };
        env = [
          "LIBVA_DRIVER_NAME,nvidia"
          "XDG_SESSION_TYPE,wayland"
          "GBM_BACKEND,nvidia-drm"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        ];
        windowrulev2 = [
          "tile, class:(firefox)"
          "opacity 0.95 override 0.85 override, class:(kitty)"
        ];
        bind =
          [
            "$mod, T, exec, kitty"
            "$mod CTRL, B, exec, firefox"
            "$mod, S, exec, spotify"
            "$mod, SPACE, exec, tofi-drun | xargs hyprctl dispatch exec --"
            "$mod CTRL, SPACE, exec, tofi-run | xargs hyprctl dispatch exec --"
            "$mod, Q, killactive,"

            "$mod CTRL, Q, exec, hyprctl dispatch exit"
            "$mod, ESCAPE, exec, sleep 1 && hyprctl dispatch dpms off && hyprlock"
            ", PRINT, exec, hyprshot -m region"

            "$mod SHIFT, W, exec, pkill waybar; waybar"

            "$mod CTRL, F, togglefloating,"
            "$mod SHIFT, F, fullscreen, 0"

            "$mod, H, movefocus, l"
            "$mod, J, movefocus, d"
            "$mod, K, movefocus, u"
            "$mod, L, movefocus, r"

            "$mod CTRL, H, swapwindow, l"
            "$mod CTRL, J, swapwindow, d"
            "$mod CTRL, K, swapwindow, u"
            "$mod CTRL, L, swapwindow, r"

            "$mod, 1, workspace, 1"
            "$mod, 2, workspace, 2"
            "$mod, 3, workspace, 3"
            "$mod, 4, workspace, 4"
            "$mod, 5, workspace, 5"

            "$mod SHIFT, 1, movetoworkspace, 1"
            "$mod SHIFT, 2, movetoworkspace, 2"
            "$mod SHIFT, 3, movetoworkspace, 3"
            "$mod SHIFT, 4, movetoworkspace, 4"
            "$mod SHIFT, 5, movetoworkspace, 5"

            "$mod, RETURN, togglespecialworkspace"
          ];
        bindl =
          [
            "$mod, BACKSPACE, exec, sleep 1 && hyprctl dispatch dpms on"
            ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            ", XF86AudioPrev, exec, playerctl -p spotify previous"
            ", XF86AudioPlay, exec, playerctl -p spotify play-pause"
            ", XF86AudioNext, exec, playerctl -p spotify next"
            ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
            ", XF86MonBrightnessUp, exec, brightnessctl s +10%"
          ];
        bindel =
          [
            ", XF86AudioRaiseVolume, exec, wpctl set-volume --limit 1.0 @DEFAULT_AUDIO_SINK@ 5%+"
            ", XF86AudioLowerVolume, exec, wpctl set-volume --limit 1.0 @DEFAULT_AUDIO_SINK@ 5%-"
          ];
        binde =
          [
            "$mod ALT, h, resizeactive, -10 0"
            "$mod ALT, j, resizeactive, 0 10"
            "$mod ALT, k, resizeactive, 0 -10"
            "$mod ALT, l, resizeactive, 10 0"
          ];
        bindm =
          [
            "$mod,mouse:272,movewindow"
            "$mod,mouse:273,resizewindow"
          ];
      };
    };
  };
  options = {
    hyprland_startup_apps = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
    hyprland_monitor = lib.mkOption {
      type = lib.types.str;
      default = ",highrr,auto,1";
    };
    hyprland_input_sensitivity = lib.mkOption {
      type = lib.types.float;
      default = -0.1;
    };
  };
}
