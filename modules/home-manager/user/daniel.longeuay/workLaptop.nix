{
  programs.fish = {
    shellAbbrs = {
      hms = "home-manager switch --flake .#workUser";
      nhs = "nh home switch --ask --configuration workUser .";
      drs = "sudo darwin-rebuild switch --flake .#workLaptop";
    };
  };

  home.username = "daniel.longeuay";
  home.homeDirectory = "/Users/daniel.longeuay";
  home.stateVersion = "23.11";

  imports =
    [
      ../../common
      ../../shell
      ../../tui
      ../../vc
    ];
}
