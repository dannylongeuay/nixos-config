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
    shellAbbrs = {
      nhs = "nh home switch --ask .";
      nos = "nh os switch --ask .";
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
  };
}