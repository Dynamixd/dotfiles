{ pkgs, config, ... }:

let
  palette = config.colorScheme.palette;
in {
  home.file.".config/swaylock/config".text = ''
    daemonize
    show-failed-attempts
    clock
    effect-blur=15x15
    effect-vignette=1:1
    font="Ubuntu"
    indicator
    indicator-radius=100
    indicator-thickness=20
    image=/home/zach/config/home/files/wallpapers/Nordic KDE Wallpaper.jpg
    color=${palette.base00}
    line-color=${palette.base07}
    ring-color=${palette.base00}
    inside-color=${palette.base01}
    key-hl-color=${palette.base0E}
    separator-color=${palette.base07}
    text-color=${palette.base07}
    text-caps-lock-color=""
    line-ver-color=${palette.base0A}
    ring-ver-color=${palette.base0A}
    inside-ver-color=${palette.base01}
    text-ver-color=${palette.base0A}
    ring-wrong-color=${palette.base08}
    text-wrong-color=${palette.base08}
    inside-wrong-color=${palette.base01}
    inside-clear-color=${palette.base01}
    text-clear-color=${palette.base0C}
    ring-clear-color=${palette.base0B}
    line-clear-color=${palette.base08}
    line-wrong-color=${palette.base08}
    bs-hl-color=${palette.base0D}
    grace=10
    # grace-no-mouse
    # grace-no-touch
    datestr=%a, %B %e
    timestr=%I:%M %p
    fade-in=10
    ignore-empty-password
  '';
}

