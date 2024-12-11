{
  programs.fish = {
    shellAbbrs = {
      hms = "home-manager switch --flake .#cyberdan@desktop";
      nhs = "nh home switch --ask --configuration cyberdan@desktop .";
      nrs = "sudo nixos-rebuild switch --flake .#desktop";
      nos = "nh os switch --ask --hostname desktop .";
    };
  };

  waybar_font_size = "16";
  hyprland_startup_apps =
    [
      "[workspace 1 silent] firefox"
      "[workspace 1 silent] sleep 1 && kitty"
      "[workspace 2 silent] kitty"
      "[workspace 3 silent] spotify"
    ];

  imports =
    [
      ./common.nix
    ];
}
