{
  programs.fish = {
    shellAbbrs = {
      hms = "home-manager switch --flake .#cyberdan@laptop";
      nhs = "nh home switch --ask --configuration cyberdan@laptop .";
      nrs = "sudo nixos-rebuild switch --flake .#laptop";
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
