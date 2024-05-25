{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      editor = {
        mouse = false;
        cursor-shape = {
          insert = "bar";
          select = "underline";
        };
      };
    };
    extraPackages = with pkgs;
      [
        ltex-ls
        lua-language-server
        marksman
        nil
        nixpkgs-fmt
        vscode-langservers-extracted
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
