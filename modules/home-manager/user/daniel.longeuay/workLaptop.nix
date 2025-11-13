{ pkgs, ... }:

{
  home.username = "daniel.longeuay";
  home.homeDirectory = "/Users/daniel.longeuay";
  home.stateVersion = "23.11";

  home.file.".config/aerospace/aerospace.toml".source = ./aerospace.toml;
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  programs = {
    fish = {
      shellAbbrs = {
        hms = "home-manager switch --flake .#workUser";
        nhs = "nh home switch --ask --configuration workUser .";
        drs = "sudo darwin-rebuild switch --flake .#workLaptop";
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
            set -l region (printf "eu-west-1\nus-east-1\nus-west-2" | fzf)
            set -l cluster (aws eks list-clusters --region $region --query 'clusters' | jq -r .[] | fzf)
            aws eks update-kubeconfig --name $cluster --region $region
          '';
        };
        decode-jwt = "echo $argv | jq -R 'split(\".\") | .[1] | @base64d | fromjson'";
      };
    };
    kitty.settings = {
      copy_on_select = "clipboard";
      hide_window_decorations = "titlebar-only";
      macos_option_as_alt = "yes";
      macos_show_window_title_in = "menubar";
      window_margin_width = 5;
    };
  };

  home.packages = with pkgs;
    [
      aws-nuke
      glab
      sops
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
