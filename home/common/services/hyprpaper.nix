{ user_info, ... }:

let
  wallpaper_path = "${user_info.home_dir}/Pictures/wallpaper/current.png";
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      preload =
        [
          wallpaper_path
        ];
      wallpaper =
        [
          ",${wallpaper_path}"
        ];
    };
  };
}
