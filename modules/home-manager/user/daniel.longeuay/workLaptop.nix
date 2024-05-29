{ pkgs, ... }:

{
  home.username = "daniel.longeuay";
  home.homeDirectory = "/Users/daniel.longeuay";
  home.stateVersion = "23.11";

  programs = {
    fish = {
      shellAbbrs = {
        hms = "home-manager switch --flake .#workUser";
        nhs = "nh home switch --ask --configuration workUser .";
        drs = "darwin-rebuild switch --flake .#workLaptop";
      };
      functions = {
        awsso = {
          body = ''
            AWS_PROFILE=(aws configure list-profiles | grep sso | fzf) aws sso login
            aprof
          '';
        };
        kconf = {
          body = ''
            set -l region (printf "us-east-1\nus-west-2" | fzf)
            set -l cluster (aws eks list-clusters --region $region --query 'clusters' | jq -r .[] | fzf)
            aws eks update-kubeconfig --name $cluster --region $region
          '';
        };
        decode-jwt = "echo $argv | jq -R 'split(\".\") | .[1] | @base64d | fromjson'";
      };
    };
    kitty.settings = {
      macos_show_window_title_in = "menubar";
      hide_window_decorations = "titlebar-only";
      window_margin_width = 5;
    };
  };

  home.packages = with pkgs;
    [
      aws-nuke
      skhd
      yabai
    ];

  imports =
    [
      ../../common
      ../../gui/terminal/kitty.nix
      ../../shell
      ../../tui
      ../../vc
    ];
}
