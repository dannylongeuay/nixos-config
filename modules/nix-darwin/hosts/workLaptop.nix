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

  environment.systemPackges = with pkgs;
    [
      helix
      vim
    ];
}
