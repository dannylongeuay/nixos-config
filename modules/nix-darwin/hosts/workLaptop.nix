{ pkgs, ... }:

{
  services.nix-daemon.enable = true;

  system.stateVersion = 4;

  nixpkgs.hostPlatform = "aarch64-darwin";

  environment.systemPackages = with pkgs;
    [
      nh
    ];

  homebrew = {
    enable = true;
    casks =
      [
        "doll"
        "raycast"
        "stats"
        "wezterm"
      ];
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
  };

  system.defaults = {
    dock = {
      autohide = true;
      orientation = "left";
      # show-process-indicators = false;
      show-recents = false;
      static-only = true;
    };
    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      FXEnableExtensionChangeWarning = false;
    };
  };

  imports =
    [
      ../../nixos/common/environment.nix
      ../../nixos/common/nix.nix
      ../../nixos/common/programs.nix
    ];
}
