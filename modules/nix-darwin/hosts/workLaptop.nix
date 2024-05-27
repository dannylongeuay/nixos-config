{ pkgs, ... }:

{
  services.nix-daemon.enable = true;

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };
  };

  system.stateVersion = 4;

  nixpkgs.hostPlatform = "aarch64-darwin";

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs;
    [
      helix
      vim
    ];
}
