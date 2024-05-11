{
  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./extraConfig.lua;
  };
}
