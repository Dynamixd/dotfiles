{ pkgs, config, ... }:

{
  imports = [
  ./bash.nix
  ./hyprland.nix
  ./packages.nix
  ./files.nix
  ./gtk-qt.nix
  ./kitty.nix
  ./style2-waybar.nix
  ./rofi.nix
  ./swaylock.nix
  ./swaync.nix
  ];
}
