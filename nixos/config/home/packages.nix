{ pkgs, config, inputs, username, ... }:

let 
  inherit (import ../../options.nix) 
    browser wallpaperDir wallpaperGit flakeDir;
in {
  # Install Packages For The User
  home.packages = with pkgs; [
    firefox-wayland
    kitty
    blueman
    swww 
    rofi-wayland 
    font-awesome 
    swayidle
    swaylock-effects
    sway-audio-idle-inhibit
    ntfs3g
    remmina
    transmission_4-qt
    mullvad
    wineWowPackages.waylandFull
    winetricks
    ferium
    prismlauncher
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
  programs.gh.enable = true;
}


