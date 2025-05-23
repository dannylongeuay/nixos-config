{ pkgs, ... }:

{
  system.stateVersion = 4;

  nixpkgs.hostPlatform = "aarch64-darwin";

  nix.gc.interval = {
    Hour = 3;
    Minute = 0;
  };

  environment.systemPackages = with pkgs;
    [
      nh
    ];

  homebrew = {
    enable = true;
    casks =
      [
        "nikitabobko/tap/aerospace"
        "doll"
        "raycast"
        "stats"
      ];
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
  };

  system = {
    primaryUser = "daniel.longeuay";
    defaults = {
      NSGlobalDomain = {
        _HIHideMenuBar = false;
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
      ../../nixos/common/fonts.nix
      ../../nixos/common/nix.nix
      ../../nixos/common/programs.nix
    ];
}
