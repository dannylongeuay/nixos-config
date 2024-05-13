{
  programs = {
    home-manager.enable = true;

    wlogout.enable = true;
    waybar = {
      enable = true;
    };

    fzf.enable = true;

    zoxide.enable = true;
    fish.shellAbbrs.zz = "z -";
  };
}
