{
  programs.fish = {
    shellAbbrs = {
      nhs = "nh home switch --ask --configuration cyberdan@desktop .";
      nos = "nh os switch --ask --hostname desktop .";
    };
  };

  waybar_font_size = "16";
  hyprland_startup_apps =
    [
      "[workspace 1 silent] firefox"
      "[workspace 1 silent] sleep 1 && spotify"
      "[workspace 2 silent] kitty"
    ];

  imports =
    [
      ./common.nix
    ];
}
