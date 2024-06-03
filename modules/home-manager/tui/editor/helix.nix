{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      editor = {
        mouse = false;
        line-number = "relative";
        cursor-shape = {
          insert = "bar";
          select = "underline";
        };
      };
    };
    extraPackages = with pkgs;
      [
        cuelsp
        dockerfile-language-server-nodejs
        ltex-ls
        lua-language-server
        marksman
        mdformat
        nil
        nixpkgs-fmt
        nodePackages.bash-language-server
        taplo
        terraform-ls
        vscode-langservers-extracted
        yaml-language-server
      ];
    languages = {
      language = [
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
          formatter = {
            command = "mdformat";
            args = [ "-" ];
          };
          auto-format = true;
        }
        {
          name = "python";
          language-servers = [ "pyright" "ruff" ];
          auto-format = true;
        }
      ];
      language-server = {
        pyright.config.python.analysis = {
          typeCheckingMode = "basic";
        };
        ruff = {
          command = "ruff-lsp";
          config.settings = {
            args = [ "--ignore" "E501" ];
          };
        };
      };
    };
  };
}
