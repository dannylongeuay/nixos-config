{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
    nerd-fonts.droid-sans-mono
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
    nerd-fonts.sauce-code-pro
  ];
}
