let
  wallpaper_path = ../../../../assets/nixos-wallpaper-catppuccin-mocha.png;
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      preload =
        [
          "${wallpaper_path}"
        ];
      wallpaper =
        [
          ",${wallpaper_path}"
        ];
    };
  };
}
