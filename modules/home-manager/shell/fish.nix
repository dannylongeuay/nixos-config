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
      grep = "rg";
      ls = "eza";
      k = "kubectl";
      nhs = "nh home switch --ask .";
      nos = "nh os switch --ask .";
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
      set -U tide_aws_bg_color ${fishColor "base"}
      set -U tide_aws_color ${fishColor "peach"}
      set -U tide_character_color ${fishColor "green"}
      set -U tide_character_color_failure ${fishColor "red"}
      set -U tide_cmd_duration_bg_color ${fishColor "base"}
      set -U tide_cmd_duration_color ${fishColor "rosewater"}
      set -U tide_context_bg_color ${fishColor "base"}
      set -U tide_context_color_default ${fishColor "peach"}
      set -U tide_context_color_root ${fishColor "yellow"}
      set -U tide_context_color_ssh ${fishColor "peach"}
      set -U tide_crystal_bg_color ${fishColor "base"}
      set -U tide_crystal_color ${fishColor "text"}
      set -U tide_direnv_bg_color ${fishColor "base"}
      set -U tide_direnv_bg_color_denied ${fishColor "base"}
      set -U tide_direnv_color ${fishColor "yellow"}
      set -U tide_direnv_color_denied ${fishColor "red"}
      set -U tide_distrobox_bg_color ${fishColor "base"}
      set -U tide_distrobox_color ${fishColor "pink"}
      set -U tide_docker_bg_color ${fishColor "base"}
      set -U tide_docker_color ${fishColor "blue"}
      set -U tide_elixir_bg_color ${fishColor "base"}
      set -U tide_elixir_color ${fishColor "pink"}
      set -U tide_gcloud_bg_color ${fishColor "base"}
      set -U tide_gcloud_color ${fishColor "blue"}
      set -U tide_git_bg_color ${fishColor "base"}
      set -U tide_git_bg_color_unstable ${fishColor "base"}
      set -U tide_git_bg_color_urgent ${fishColor "base"}
      set -U tide_git_color_branch ${fishColor "green"}
      set -U tide_git_color_conflicted ${fishColor "red"}
      set -U tide_git_color_dirty ${fishColor "yellow"}
      set -U tide_git_color_operation ${fishColor "red"}
      set -U tide_git_color_staged ${fishColor "yellow"}
      set -U tide_git_color_stash ${fishColor "green"}
      set -U tide_git_color_untracked ${fishColor "blue"}
      set -U tide_git_color_upstream ${fishColor "green"}
      set -U tide_go_bg_color ${fishColor "base"}
      set -U tide_go_color ${fishColor "teal"}
      set -U tide_java_bg_color ${fishColor "base"}
      set -U tide_java_color ${fishColor "peach"}
      set -U tide_jobs_bg_color ${fishColor "base"}
      set -U tide_jobs_color ${fishColor "green"}
      set -U tide_kubectl_bg_color ${fishColor "base"}
      set -U tide_kubectl_color ${fishColor "blue"}
      set -U tide_nix_shell_bg_color ${fishColor "base"}
      set -U tide_nix_shell_color ${fishColor "blue"}
      set -U tide_node_bg_color ${fishColor "base"}
      set -U tide_node_color ${fishColor "green"}
      set -U tide_os_bg_color ${fishColor "base"}
      set -U tide_os_color ${fishColor "peach"}
      set -U tide_php_bg_color ${fishColor "base"}
      set -U tide_php_color ${fishColor "blue"}
      set -U tide_private_mode_bg_color ${fishColor "base"}
      set -U tide_private_mode_color ${fishColor "text"}
      set -U tide_prompt_color_frame_and_connection ${fishColor "rosewater"}
      set -U tide_prompt_color_separator_same_color ${fishColor "rosewater"}
      set -U tide_pulumi_bg_color ${fishColor "base"}
      set -U tide_pulumi_color ${fishColor "peach"}
      set -U tide_pwd_bg_color ${fishColor "base"}
      set -U tide_pwd_color_anchors ${fishColor "blue"}
      set -U tide_pwd_color_dirs ${fishColor "blue"}
      set -U tide_pwd_color_truncated_dirs ${fishColor "pink"}
      set -U tide_python_bg_color ${fishColor "base"}
      set -U tide_python_color ${fishColor "teal"}
      set -U tide_ruby_bg_color ${fishColor "base"}
      set -U tide_ruby_color ${fishColor "red"}
      set -U tide_rustc_bg_color ${fishColor "base"}
      set -U tide_rustc_color ${fishColor "red"}
      set -U tide_shlvl_bg_color ${fishColor "base"}
      set -U tide_shlvl_color ${fishColor "peach"}
      set -U tide_status_bg_color ${fishColor "base"}
      set -U tide_status_bg_color_failure ${fishColor "base"}
      set -U tide_status_color ${fishColor "green"}
      set -U tide_status_color_failure ${fishColor "red"}
      set -U tide_terraform_bg_color ${fishColor "base"}
      set -U tide_terraform_color ${fishColor "pink"}
      set -U tide_time_bg_color ${fishColor "base"}
      set -U tide_time_color ${fishColor "rosewater"}
      set -U tide_toolbox_bg_color ${fishColor "base"}
      set -U tide_toolbox_color ${fishColor "pink"}
      set -U tide_vi_mode_bg_color_default ${fishColor "base"}
      set -U tide_vi_mode_bg_color_insert ${fishColor "base"}
      set -U tide_vi_mode_bg_color_replace ${fishColor "base"}
      set -U tide_vi_mode_bg_color_visual ${fishColor "base"}
      set -U tide_vi_mode_color_default ${fishColor "text"}
      set -U tide_vi_mode_color_insert ${fishColor "teal"}
      set -U tide_vi_mode_color_replace ${fishColor "green"}
      set -U tide_vi_mode_color_visual ${fishColor "peach"}
      set -U tide_zig_bg_color ${fishColor "base"}
      set -U tide_zig_color ${fishColor "peach"}

      set -U tide_jobs_number_threshold 2

      nix-your-shell fish | source
    '';
  };
}
