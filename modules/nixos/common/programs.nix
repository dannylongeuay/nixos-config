{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" ]]
      then
        exec ${pkgs.fish}/bin/fish
      fi
    '';
  };
  programs.fish.enable = true;
}
