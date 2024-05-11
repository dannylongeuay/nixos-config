{ config, pkgs, ... }:

{
  home.username = "cyberdan";
  home.homeDirectory = "/home/cyberdan";

  home.stateVersion = "23.11";

  home.packages = with pkgs;
    [
      cargo
      go
      neofetch
      (pkgs.nerdfonts.override {
        fonts =
          [
            "CascadiaCode"
            "DroidSansMono"
            "Hack"
            "JetBrainsMono"
            "SourceCodePro"
          ];
      })
      rustc
      spotify
      tldr
      xclip
    ];

  home.file = {
    # ".config/wezterm/conf.lua".source = ./wezterm.lua;
  };

  home.sessionVariables = {
    # EDITOR = "hx";
  };

  programs = {
    home-manager.enable = true;
    fzf.enable = true;
    zoxide.enable = true;
    gh = {
      enable = true;
      settings.git_protocol = "ssh";
    };
    git = {
      enable = true;
      userName = "dannylongeuay";
      userEmail = "dannylongeuay@yahoo.com";
      delta = {
        enable = true;
        options = {
          navigate = true;
          line-numbers = true;
          side-by-side = true;
        };
      };
      extraConfig = {
        advice.statusHints = false;
        color.ui = true;
        init.defaultBranch = "main";
        merge.conflictstyle = "diff3";
      };
    };
    fish = {
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
      interactiveShellInit = builtins.readFile ./fish_interactiveShellInit.fish;
      shellInit = builtins.readFile ./fish_shellInit.fish;
    };
    helix = {
      enable = true;
      defaultEditor = true;
      settings = {
        theme = "catppuccin_mocha";
        editor = {
          mouse = false;
          true-color = true;
          color-modes = true;
          cursor-shape = {
            insert = "bar";
            select = "underline";
          };
        };
      };
      extraPackages = with pkgs;
        [
          gopls
          gotools
          ltex-ls
          lua-language-server
          marksman
          nil
          nixpkgs-fmt
          rust-analyzer-unwrapped
          vscode-langservers-extracted
          xclip
        ];
      languages.language = [
        {
          name = "nix";
          formatter.command = "nixpkgs-fmt";
          auto-format = true;
        }
        {
          name = "go";
          formatter.command = "goimports";
          auto-format = true;
        }
        {
          name = "markdown";
          language-servers = [ "marksman" "ltex-ls" ];
        }
      ];
    };
    nnn = {
      enable = true;
    };
    wezterm = {
      enable = true;
      extraConfig = builtins.readFile ./wezterm_extraConfig.lua;
    };
  };
}
