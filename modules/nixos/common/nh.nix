{ user_info, ... }:

{
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 10";
    };
    flake = "${user_info.home_dir}/nixos-config";
  };
}
