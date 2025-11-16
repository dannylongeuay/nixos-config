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
      "[workspace 2 silent] kitty"
    ];

  imports =
    [
      ./common.nix
    ];
}
