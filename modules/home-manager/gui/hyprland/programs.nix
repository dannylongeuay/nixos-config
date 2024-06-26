{ lib, ... }:

{
  programs.tofi = {
    enable = true;
    settings = {
      font = "JetBrainsMono Nerd Font Mono";
      border-width = 0;
      outline-width = 0;
      width = "100%";
      height = "100%";
      padding-left = "35%";
      padding-top = "35%";
      num-results = 5;
      result-spacing = 25;
      background-color = lib.mkForce "#000A";
    };
  };
}
