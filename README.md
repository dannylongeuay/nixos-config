# NixOS Configuration

Modular home and work profiles

## Bootstrap

```
  nix-channel --list
  nix-channel --add https://nixos.org/channels/nixos-unstable nixos
  nix-channel --update
  nix-shell -p git home-manager
  git clone https://github.com/dannylongeuay/nixos-config
  cd nixos-config
  cp /etc/nixos/hardware-configuration.nix modules/nixos/hosts/<hostname>/
  git add -A
  sudo nixos-rebuild switch --flake .#<hostname>
  home-manager switch --flake .#<username>@<hostname>
  systemctl reboot
```
