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
    libvirt 
    transmission-gtk
    swww 
    rofi-wayland 
    imv 
    mpv 
    gimp 
    font-awesome 
    swayidle
    swaylock-effects
    sway-audio-idle-inhibit
    android-tools
    xemu
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
  programs.gh.enable = true;
}


