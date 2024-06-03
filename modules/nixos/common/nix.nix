{
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
      trusted-users = [ "root" "@wheel" ];
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
  };
}
