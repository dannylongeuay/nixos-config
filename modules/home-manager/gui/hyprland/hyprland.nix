{ config, lib, ... }:

# When {option}wayland.windowManager.hyprland.configType is "lua",
# each attribute maps to an hl.(...) call. List values generate
# one call per element.

# Attribute values with an _args list generate multi-argument calls.
# Attribute values with _var generate a Lua local variable instead of
# an hl.(...) call. If no name is set, the attribute name is
# used as the Lua variable name.
# Values created with lib.generators.mkLuaInline are rendered as raw
# Lua expressions.

let
  lua = lib.generators.mkLuaInline;

  dsp = {
    exec = cmd: lua ''hl.dsp.exec_cmd("${cmd}")'';
    close = lua "hl.dsp.window.close()";
    exit = lua "hl.dsp.exit()";
    float = lua ''hl.dsp.window.float({ action = "toggle" })'';
    fullscreen = lua "hl.dsp.window.fullscreen()";
    focus = dir: lua ''hl.dsp.focus({ direction = "${dir}" })'';
    swap = dir: lua ''hl.dsp.window.swap({ direction = "${dir}" })'';
    toggleSpecial = name: lua ''hl.dsp.workspace.toggle_special("${name}")'';
    moveToSpecial = name: lua ''hl.dsp.window.move({ workspace = "special:${name}" })'';
    focusWorkspace = ws: lua ''hl.dsp.focus({ workspace = "${toString ws}" })'';
    moveToWorkspace = ws: lua ''hl.dsp.window.move({ workspace = "${toString ws}" })'';
    drag = lua "hl.dsp.window.drag()";
    resize = lua "hl.dsp.window.resize()";
    resizeOpts = opts: lua "hl.dsp.window.resize({ ${opts} })";
  };

  bind = keys: dispatcher: { _args = [ keys dispatcher ]; };
  bindOpts = keys: dispatcher: opts: { _args = [ keys dispatcher opts ]; };

  workspaceBinds = lib.concatMap
    (i:
      let key = toString (lib.mod i 10);
      in [
        (bind "SUPER + ${key}" (dsp.focusWorkspace i))
        (bind "SUPER + SHIFT + ${key}" (dsp.moveToWorkspace i))
      ]
    )
    (lib.range 1 10);
in
{
  config = {
    wayland.windowManager.hyprland = {
      enable = true;
      configType = "lua";

      settings = {
        monitor = config.hyprland_monitor;

        config = {
          general = {
            border_size = 3;
            gaps_in = 5;
            gaps_out = 10;
            col.active_border = lua "colors.accent";
            col.inactive_border = lua "colors.surface0";

          };
          decoration = {
            rounding = 10;
            active_opacity = 1.0;
            inactive_opacity = 1.0;
            blur = {
              enabled = false;
            };
          };
          ecosystem = {
            no_update_news = true;
            no_donation_nag = true;
          };
          misc = {
            disable_hyprland_logo = true;
            disable_splash_rendering = true;
            background_color = lua "colors.base";
          };
          input = {
            sensitivity = config.hyprland_input_sensitivity;
            accel_profile = "adaptive";
            kb_options = "caps:escape";
            follow_mouse = 2;
            repeat_rate = 32;
            repeat_delay = 200;
          };
          dwindle =
            {
              force_split = 2;
            };
          cursor = {
            no_hardware_cursors = true;
          };
        };
        animation = [
          { leaf = "windowsIn"; enabled = true; speed = 10; bezier = "easeInOutQuart"; style = "popin"; }
          { leaf = "windowsMove"; enabled = true; speed = 10; bezier = "easeInOutBack"; style = "slide"; }
          { leaf = "specialWorkspace"; enabled = true; speed = 5; bezier = "easeInOutCirc"; style = "slidevert"; }
        ];
        device = {
          name = "dll0945:00-04f3:311c-touchpad";
          sensitivity = 0.1;
        };
        on = {
          _args = [
            "hyprland.start"
            (lua /* lua */ ''
              function()
                hl.exec_cmd("waybar")
                hl.exec_cmd("firefox")
              end
            '')
          ];
        };
        curve = [
          {
            _args = [
              "easeInOutCirc"
              {
                type = "bezier";
                points = lua "{ { 0.85, 0 }, { 0.15, 1 } }";
              }
            ];
          }
          {
            _args = [
              "easeInOutQuart"
              {
                type = "bezier";
                points = lua "{ { 0.75, 0 }, { 0.25, 1 } }";

              }
            ];
          }
          {
            _args = [
              "easeInOutBack"
              {
                type = "bezier";
                points = lua "{ { 0.65, -0.5 }, { 0.35, 1.5 } }";
              }
            ];
          }
          {
            _args = [
              "easeOutExpo"
              {
                type = "bezier";
                points = lua "{ { 0.15, 1 }, { 0.3, 1 } }";
              }
            ];
          }
        ];
        env = [
          {
            _args = [
              "LIBVA_DRIVER_NAME"
              "nvidia"
            ];
          }
          {
            _args = [
              "XDG_SESSION_TYPE"
              "wayland"
            ];
          }
          {
            _args = [
              "GBM_BACKEND"
              "nvidia-drm"
            ];
          }
          {
            _args = [
              "__GLX_VENDOR_LIBRARY_NAME"
              "nvidia"
            ];
          }
        ];
        window_rule = [
          {
            match = {
              class = "firefox";
            };
            tile = true;
          }
          {
            match = {
              class = "kitty";
            };
            opacity = "0.95 override 0.85 override";
          }
        ];
        bind =
          [
            (bind "SUPER + T" (dsp.exec "kitty"))
            (bind "SUPER + CTRL + B" (dsp.exec "firefox"))
            (bind "SUPER + SPACE" (dsp.exec "tofi-drun | xargs hyprctl dispatch exec --"))
            (bind "SUPER + CTRL + SPACE" (dsp.exec "tofi-run | xargs hyprctl dispatch exec --"))

            (bind "SUPER + Q" dsp.close)

            (bind "SUPER + CTRL + Q" dsp.exit)
            (bind "SUPER + ESCAPE" (dsp.exec "sleep 1 && hyprctl dispatch 'hl.dsp.dpms({ action = \\\"disable\\\" })' && hyprlock"))
            (bind "PRINT" (dsp.exec "hyprshot -m region"))

            (bind "SUPER + SHIFT + W" (dsp.exec "pkill waybar; waybar"))

            (bind "SUPER + CTRL + F" dsp.float)
            (bind "SUPER + SHIFT + F" dsp.fullscreen)

            (bind "SUPER + H" (dsp.focus "left"))
            (bind "SUPER + J" (dsp.focus "down"))
            (bind "SUPER + K" (dsp.focus "up"))
            (bind "SUPER + L" (dsp.focus "right"))

            (bind "SUPER + CTRL + H" (dsp.swap "left"))
            (bind "SUPER + CTRL + J" (dsp.swap "down"))
            (bind "SUPER + CTRL + K" (dsp.swap "up"))
            (bind "SUPER + CTRL + L" (dsp.swap "right"))

            (bind "SUPER + ALT + H" (dsp.resizeOpts "x = -100, y = 0, relative = true"))
            (bind "SUPER + ALT + J" (dsp.resizeOpts "x = 0, y = 100, relative = true"))
            (bind "SUPER + ALT + K" (dsp.resizeOpts "x = 0, y = -100, relative = true"))
            (bind "SUPER + ALT + L" (dsp.resizeOpts "x = 100, y = 0, relative = true"))

            (bind "SUPER + RETURN" (dsp.toggleSpecial "magic"))

            (bindOpts "SUPER + BACKSPACE" (dsp.exec "sleep 1 && hyprctl dispatch 'hl.dsp.dpms({ action = \\\"enable\\\" })'") { locked = true; })
            (bindOpts "XF86AudioMute" (dsp.exec "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") { locked = true; })
            (bindOpts "XF86MonBrightnessUp" (dsp.exec "brightnessctl s +10%") { locked = true; })
            (bindOpts "XF86MonBrightnessDown" (dsp.exec "brightnessctl s 10%-") { locked = true; })

            (bindOpts "XF86AudioRaiseVolume" (dsp.exec "wpctl set-volume --limit 1.0 @DEFAULT_AUDIO_SINK@ 5%+") { locked = true; repeating = true; })
            (bindOpts "XF86AudioLowerVolume" (dsp.exec "wpctl set-volume --limit 1.0 @DEFAULT_AUDIO_SINK@ 5%-") { locked = true; repeating = true; })

            (bindOpts "SUPER + mouse:272" dsp.drag { mouse = true; })
            (bindOpts "SUPER + mouse:273" dsp.resize { mouse = true; })
          ] ++ workspaceBinds;
      };
    };
  };
  options = {
    hyprland_startup_apps = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
    hyprland_monitor = lib.mkOption {
      type = lib.types.listOf (lib.types.attrsOf lib.types.str);
      default = [{
        output = "";
        mode = "highrr";
        position = "auto";
        scale = "1";
      }];
    };
    hyprland_input_sensitivity = lib.mkOption {
      type = lib.types.float;
      default = -0.1;
    };
  };
}
