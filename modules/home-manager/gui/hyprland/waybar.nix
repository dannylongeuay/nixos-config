{
  programs.waybar = {
    enable = true;
    catppuccin.enable = true;
    settings = {
      primary = {
        position = "top";
        modules-left = [ "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ ];
        modules-right = [ "battery" "clock" ];
        "hyprland/workspaces" = {
          "format" = "{icon}";
          "on-click" = "activate";
          "format-icons" = {
            "1" = " ";
            "2" = " ";
            "3" = "";
            "4" = "";
            "5" = "";
            "urgent" = "";
            "active" = "";
            "default" = "";
          };
          "sort-by-number" = true;
        };
        # "hyprland/workspaces" = {
        #   format = "<sub>{icon}</sub>{windows}";
        #   window-rewrite-default = "";
        #   window-rewrite = {
        #     "title<.*youtube.*>" = "";
        #     "class<firefox>" = "";
        #     "class<kitty>" = "";
        #     "class<spotify>" = "";
        #   };
        # };
        "hyprland/window" = {
          format = "{class}{title}";
          rewrite = {
            "firefox(.*) — Mozilla Firefox" = "🌎 $1";
            "kitty(.*)" = "> [$1]";
          };
          separate-outputs = true;
        };
        battery = {
          format = "{capacity}% {icon}";
          format-icons = [ "" "" "" "" "" ];
        };
        clock = {
          format-alt = "{:%a, %d. %b  %H:%M}";
        };
      };
    };
    style = ''
      * {
        font-family: JetBrainsMono Nerd Font Mono;
        font-size: 16pt;
        padding: 0;
        margin: 0 0.5em;
      }

      window#waybar {
        padding: 0;
        border-radius: 0;
        background-color: @base;
        /* background-color: shade(@base, 0.2); */
        /* border: 2px solid alpha(@crust, 0.3); */
      }

      #workspaces button {
        padding: 0 0.5em;
        background-color: @surface0;
        color: @text;
        margin: 0.25em;
      }

      #workspaces button.empty {
        color: @overlay0;
      }

      #workspaces button.visible {
        color: @blue;
      }

      #workspaces button.active {
        color: @green
      }

      #workspaces button.urgent {
        background-color: @red;
        border-radius: 1em;
        color: @text;
      }
    '';
  };
}
