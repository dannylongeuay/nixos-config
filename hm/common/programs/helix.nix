{ pkgs, ... }:

{
  programs.helix = {
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
}
