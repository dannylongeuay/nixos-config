{
  programs.fish = {
    shellAbbrs = {
      nhs = "nh home switch --ask --configuration daniel.longeuay .";
      nos = "nh os switch --ask --hostname workLaptop .";
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
