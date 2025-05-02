{ config, lib, ... }:

let
  palette = (lib.importJSON "${config.catppuccin.sources.palette}/palette.json").${config.catppuccin.flavor}.colors;
  coloredIcon = icon: color: "<span color='${palette.${color}.hex}'>${icon}</span>";
in
{
  config = {
    programs.waybar = {
      enable = true;
      settings = {
        primary = {
          position = "top";
          modules-left = [ "hyprland/window" ];
          modules-center = [ "hyprland/workspaces" ];
          modules-right = [
            "pulseaudio"
            "temperature"
            "disk"
            "cpu"
            "memory"
            "battery"
            "network"
            "clock"
          ];
          "hyprland/workspaces" = {
            on-click = "activate";
          };
          "hyprland/window" = {
            format = "${coloredIcon "" "overlay1"} {class} {title}";
            rewrite = {
              ".*firefox (.*) — Mozilla Firefox" = "${coloredIcon "" "flamingo"} $1";
              ".*kitty (.*)" = "${coloredIcon "" "rosewater"} [$1]";
            };
            separate-outputs = true;
          };
          pulseaudio = {
            format = "${coloredIcon "{icon}" "rosewater"} {volume:3}%";
            format-muted = "${coloredIcon "" "red"} {volume:3}%";
            format-icons = {
              default = [ "" "" ];
            };
            scroll-step = 5;
            on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          };
          network = {
            format = "${coloredIcon "󱂇" "blue"} {bandwidthTotalBytes:>1}";
            format-wifi = "${coloredIcon "" "blue"} {icon}";
            format-icons =
              [
                "${coloredIcon "󰣾" "overlay2"}"
                "${coloredIcon "󰣴" "red"}"
                "${coloredIcon "󰣶" "peach"}"
                "${coloredIcon "󰣸" "yellow"}"
                "${coloredIcon "󰣺" "green"}"
              ];
            tooltip-format = ''UP: {bandwidthDownBytes:<1} | DOWN: {bandwidthUpBytes:<1}
IF: {ifname} | IP: {ipaddr} | GW: {gwaddr}
SSID: {essid:10} | STRENGTH: {signalStrength}% | FREQ: {frequency}'';
            interval = 5;
          };
          temperature = {
            format = "${coloredIcon "" "green"} {temperatureC:2}°C";
            critical-threshold = 80;
            format-critical = "${coloredIcon "" "red"} {temperatureC:2}°C";
            tooltip-format = "{temperatureF:3}°F";
            interval = 5;
          };
          disk = {
            format = "${coloredIcon "" "peach"} {percentage_used:2}%";
            interval = 60;
          };
          cpu = {
            format = "${coloredIcon "" "yellow"} {usage:2}%";
            interval = 5;
          };
          memory = {
            format = "${coloredIcon "" "teal"} {percentage:2}%";
            tooltip-format = "Memory: {used:0.1f}G/{total:0.1f}G\nSwap: {swapUsed:0.1f}G/{swapTotal:0.1f}G";
            interval = 5;
          };
          battery = {
            format = "${coloredIcon "{icon}" "green"} {capacity:3}%";
            format-icons = [ "" "" "" "" "" ];
          };
          clock = {
            format = "${coloredIcon "" "lavender"} {:%R (%Z)}";
            format-alt = "${coloredIcon "" "lavender"} {:%A %F %R (%Z)}";
            tooltip-format = "{tz_list}";
            timezones =
              [
                "America/New_York"
                "America/Chicago"
                "America/Los_Angeles"
                "Etc/UTC"
                "Asia/Tokyo"
              ];
          };
        };
      };
      style = ''
        * {
          border: none;
          border-radius: 0;
          min-height: 0;
          margin: 0;
          padding: 0;
          box-shadow: none;
          text-shadow: none;
          icon-shadow: none;
        }

        #waybar {
          background-color: transparent;
          color: @text;
          font-family: JetBrainsMono Nerd Font Mono;
          font-size: ${config.waybar_font_size}pt;
        }

        #window,
        #workspaces,
        #pulseaudio,
        #temperature,
        #disk,
        #load,
        #cpu,
        #memory,
        #battery,
        #network,
        #clock
        {
          margin: 0 0.1em;
          padding: 0.25em 0.5em;
          background-color: @crust;
          border-width: .25em;
          border-style: outset;
          border-color: @surface0;
          border-radius: 1em;
        }

        #workspaces button {
          padding: 0 0.25em;
          margin: 0 0.25em;
          border-radius: 0.5em;
          color: @overlay1;
        }
     
        #workspaces button.active {
          background-color: @mauve;
          color: @surface0
        }

        #workspaces button:hover {
          background-color: @flamingo;
          color: @surface2;
        }
      '';
    };
  };
  options = {
    waybar_font_size = lib.mkOption {
      type = lib.types.str;
      default = "12";
    };
  };
}
