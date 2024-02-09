{ pkgs, config, inputs, username, ... }:

let 
  inherit (import ../../options.nix) 
    browser wallpaperDir wallpaperGit flakeDir;
in {
  # Install Packages For The User
  home.packages = with pkgs; [
    firefox-wayland
    zip
    kitty
    unzip
    alsa-utils
    blueman
    element-desktop
    dunst
    libvirt 
    transmission-gtk
    swww 
    rofi-wayland 
    imv 
    mpv 
    gimp 
    font-awesome 
    pavucontrol
    swayidle
    swaylock-effects
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
  programs.gh.enable = true;
}


