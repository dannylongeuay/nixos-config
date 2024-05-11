{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    plugins = with pkgs.fishPlugins;
      [
        {
          name = "fzf.fish";
          src = fzf-fish.src;
        }
        {
          name = "tide";
          src = tide.src;
        }
      ];
    interactiveShellInit = builtins.readFile ./interactiveShellInit.fish;
    shellInit = builtins.readFile ./shellInit.fish;
  };
}
