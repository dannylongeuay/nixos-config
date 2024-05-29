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

  system = {
    defaults = {
      NSGlobalDomain = {
        ApplePressAndHoldEnabled = false;
        KeyRepeat = 2;
        InitialKeyRepeat = 15;
      };
      dock = {
        autohide = true;
        orientation = "left";
        show-recents = false;
        static-only = true;
      };
      finder = {
        AppleShowAllExtensions = true;
        ShowPathbar = true;
        FXEnableExtensionChangeWarning = false;
      };
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
  };

  imports =
    [
      ../../nixos/common/environment.nix
      ../../nixos/common/nix.nix
      ../../nixos/common/programs.nix
    ];
}
