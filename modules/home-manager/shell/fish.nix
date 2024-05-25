{ config, lib, pkgs, ... }:

let
  palette = (lib.importJSON "${config.catppuccin.sources.palette}/palette.json").${config.catppuccin.flavour}.colors;
  fishColor = color: lib.removePrefix "#" "${palette.${color}.hex}";
in
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
    shellAbbrs = {
      nhs = "nh home switch --ask .";
      nos = "nh os switch --ask .";
      ls = "eza";
      k = "kubectl";
      xc = "xclip -selection clipboard";
    };
    functions = {
      fish_title = {
        body = ''
          set -l title
          set -q argv[1]; or set argv fish
          set title (basename (prompt_pwd)) \| $argv
          echo $title
        '';
      };
      fish_greeting = "fastfetch";
      kprof = "kubectl config use-context (kubectl config get-contexts -o name | fzf)";
      show_path = {
        body = ''
          for item in $PATH
              echo $item
          end
        '';
      };
    };
    interactiveShellInit = ''
      set -U tide_pwd_color_dirs ${fishColor "blue"}
      set -U tide_character_color ${fishColor "green"}
      set -U tide_character_failure ${fishColor "red"}
      set -U tide_jobs_number_threshold 2
    '';
  };
}
