{
  imports = [
    ./programs/programs.nix
  ];

  home.file = {
    # ".config/wezterm/conf.lua".source = ./wezterm.lua;
  };

  home.sessionVariables = {
    # EDITOR = "hx";
  };
}
