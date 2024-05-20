{ pkgs, ... }:

{
  programs.wlogout = {
    enable = true;
    layout =
      [
        {
          label = "lock";
          action = "sleep 1 && hyprctl dispatch dpms off && hyprlock";
          text = "Lock";
          keybind = "l";
        }
        {

          label = "logout";
          action = "loginctl terminate-user $USER";
          text = "Logout";
          keybind = "x";
        }
        {
          label = "reboot";
          action = "systemctl reboot";
          text = "Reboot";
          keybind = "r";
        }
        {
          label = "shutdown";
          action = "systemctl poweroff";
          text = "Shutdown";
          keybind = "s";
        }
      ];
    style = ''
      * {
      	background-image: none;
      	box-shadow: none;
      }

      window {
      	background-color: rgba(12, 12, 12, 0.9);
      }

      button {
        border-radius: 0;
        border-color: black;
      	text-decoration-color: #FFFFFF;
        color: #FFFFFF;
      	background-color: #1E1E1E;
      	border-style: solid;
      	border-width: 1px;
      	background-repeat: no-repeat;
      	background-position: center;
      	background-size: 25%;
      }

      button:active, button:hover {
      	background-color: #3700B3;
      	outline-style: none;
      }

      #lock {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/lock.png"));
      }

      #logout {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/logout.png"));
      }

      #shutdown {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png"));
      }

      #reboot {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/reboot.png"));
      }
    '';
  };
}
