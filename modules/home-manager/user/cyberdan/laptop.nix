{
  programs.fish = {
    shellAbbrs = {
      nhs = "nh home switch --ask --configuration cyberdan@laptop .";
      nos = "nh os switch --ask --hostname laptop .";
    };
  };

  hyprland_startup_apps =
    [
      "[workspace 1 silent] firefox"
      "[workspace 2 silent] kitty"
    ];

  imports =
    [
      ./common.nix
    ];
}
