{ pkgs, config, lib, inputs, wallpaperDir, ...}:

let
  theme = config.colorScheme.palette;
  hyprplugins = inputs.hyprland-plugins.packages.${pkgs.system};
  inherit (import ../../options.nix)
    browser wallpaperDir borderAnim scrDir;
  in with lib; {
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      systemd.enable = true;
      plugins = [
#       hyprplugins.hyprtrails
      ];
      extraConfig = let
       modifier = "SUPER";
       modifier2 = "ALT";
      in concatStrings [ ''
      monitor=HDMI-A-1,1920x1080@60,0x0,1
      monitor=eDP-1,1920x1080@60,1920x512,1x
      # windowrule = float, ^(steam)$
      # windowrule = center, ^(steam)$
      # windowrule = size 1280 900, ^(steam)$
      # windowrule = float, ^(discord)$
      # windowrule = center, ^(discord)$
      # windowrule = size 1280 900, ^(discord)$
      
      misc {
        force_default_wallpaper = 0 # Set to 0 to disable the anime mascot wallpapers
        vrr = 0 
        disable_hyprland_logo = true
        disable_splash_rendering = true
        background_color = rgba(2A2A4Dff)
      }

      }
      general {
        gaps_in = 6
        gaps_out = 8
        border_size = 2
        col.active_border = rgba(${theme.base0C}ff) rgba(${theme.base0D}ff) rgba(${theme.base0B}ff) rgba(${theme.base0E}ff) 45deg
        col.inactive_border = rgba(${theme.base00}cc) rgba(${theme.base01}cc) 45deg
        layout = dwindle
        resize_on_border = true
        allow_tearing = false
      }

      }
      input {
        kb_layout = us
#	      kb_options = grp:alt_shift_toggle
        kb_options=caps:super
        follow_mouse = 1
        touchpad {
          natural_scroll = false
        }
        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
        accel_profile = flat
      }

      env = NIXOS_OZONE_WL, 1
      env = NIXPKGS_ALLOW_UNFREE, 1
      env = XDG_CURRENT_DESKTOP, Hyprland
      env = XDG_SESSION_TYPE, wayland
      env = XDG_SESSION_DESKTOP, Hyprland
      env = GDK_BACKEND, wayland
      env = CLUTTER_BACKEND, wayland
      env = SDL_VIDEODRIVER, wayland
      # env = XCURSOR_SIZE, 24
      # env = XCURSOR_THEME, graphite-cursors
      env = QT_QPA_PLATFORM, wayland
      env = QT_WAYLAND_DISABLE_WINDOWDECORATION, 1
      env = QT_AUTO_SCREEN_SCALE_FACTOR, 1
      env = MOZ_ENABLE_WAYLAND, 1
      env = WLR_NO_HARDWARE_CURSORS,1

      
      misc {
        mouse_move_enables_dpms = true
        key_press_enables_dpms = true
        focus_on_activate = true

      }

      animations {
        enabled = yes
        bezier = wind, 0.05, 0.9, 0.1, 1.05
        bezier = winIn, 0.1, 1.1, 0.1, 1.1
        bezier = winOut, 0.3, -0.3, 0, 1
        bezier = liner, 1, 1, 1, 1
        animation = windows, 1, 6, wind, slide
        animation = windowsIn, 1, 6, winIn, slide
        animation = windowsOut, 1, 5, winOut, slide
        animation = windowsMove, 1, 5, wind, slide
        animation = border, 1, 1, liner
        animation = fade, 1, 10, default
        animation = workspaces, 1, 5, wind
      }

      decoration {
        rounding = 10
        drop_shadow = false
        blur {
            enabled = true
            size = 5
            passes = 3
            new_optimizations = on
            ignore_opacity = on
        }
      }

      plugin {
        hyprtrails {
          color = rgba(${theme.base0A}ff)
        }
      }

      exec-once = $POLKIT_BIN
      exec-once = systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec-once = dbus-update-activation-environment --systemd --all
      exec-once = hyprctl setcursor graphite-dark 24
      exec-once = waybar
      exec-once = swaync
#      exec-once = wallsetter
      exec-once = swayidle -w timeout 920 'swaylock -f' timeout 1000 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' before-sleep 'swaylock -f -c 000000'
      # exec-once = sway-audio-idle-inhibit
      exec-once = sleep .5 && swww init && swww img ${wallpaperDir}/Rainnight.jpg
      exec-once = alsactl init

      dwindle {
        pseudotile = true
        preserve_split = true
      }

      master {
        new_is_master = true
      }

      bindl = ${modifier},T,exec,kitty
      bindr = ${modifier},W,exec,pkill rofi || rofi -show drun
      bind = ${modifier},B,exec,${browser}
      bind = ${modifier}SHIFT,F,exec,thunar
      bind = ${modifier},D,exec,discord --use-angle=vulkan
      bind = ${modifier},Q,exec,dontkillsteam # killactive, kill the window on focus
      bind = ${modifier2}, F4, exec,dontkillsteam # killactive, kill the window on focus
      bind = ${modifier},P,pseudo,
      bind = ${modifier}SHIFT,I,togglesplit,
      bind = ${modifier}, F11,fullscreen,
      bind = ${modifier}, F,fullscreen,
      bind = ${modifier}SHIFT,F11,togglefloating,
      bind = ${modifier}SHIFT,C,exit,
      bindl = ${modifier2},Tab,cyclenext,          # change focus to another window
      bindl = ${modifier2},Tab,bringactivetotop,   # bring it to the top
      bind = ${modifier}SHIFT,left,movewindow,l
      bind = ${modifier}SHIFT,right,movewindow,r
      bind = ${modifier}SHIFT,up,movewindow,u
      bind = ${modifier}SHIFT,down,movewindow,d
      bind = ${modifier}SHIFT,h,movewindow,l
      bind = ${modifier}SHIFT,l,movewindow,r
      bind = ${modifier}SHIFT,k,movewindow,u
      bind = ${modifier}SHIFT,j,movewindow,d
      bind = ${modifier},left,movefocus,l
      bind = ${modifier},right,movefocus,r
      bind = ${modifier},up,movefocus,u
      bind = ${modifier},down,movefocus,d
      bind = ${modifier},h,movefocus,l
      bind = ${modifier},l,movefocus,r
      bind = ${modifier},k,movefocus,u
      bind = ${modifier},j,movefocus,d
      bind = ${modifier},1,workspace,1
      bind = ${modifier},2,workspace,2
      bind = ${modifier},3,workspace,3
      bind = ${modifier},4,workspace,4
      bind = ${modifier},5,workspace,5
      bind = ${modifier},6,workspace,6
      bind = ${modifier},7,workspace,7
      bind = ${modifier},8,workspace,8
      bind = ${modifier},9,workspace,9
      bind = ${modifier},0,workspace,10
      bind = ${modifier}SHIFT,1,movetoworkspace,1
      bind = ${modifier}SHIFT,2,movetoworkspace,2
      bind = ${modifier}SHIFT,3,movetoworkspace,3
      bind = ${modifier}SHIFT,4,movetoworkspace,4
      bind = ${modifier}SHIFT,5,movetoworkspace,5
      bind = ${modifier}SHIFT,6,movetoworkspace,6
      bind = ${modifier}SHIFT,7,movetoworkspace,7
      bind = ${modifier}SHIFT,8,movetoworkspace,8
      bind = ${modifier}SHIFT,9,movetoworkspace,9
      bind = ${modifier}SHIFT,0,movetoworkspace,10
      bind = ${modifier},mouse_down,workspace, e+1
      bind = ${modifier},mouse_up,workspace, e-1
      bindm = ${modifier},mouse:272,movewindow
      bindm = ${modifier},mouse:273,resizewindow
      binde = ,XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
      binde = ,XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      binde = ,XF86MonBrightnessDown,exec,brightnessctl set 5%-
      binde = ,XF86MonBrightnessUp,exec,brightnessctl set +5%
      
     
      # █░█░█ █ █▄░█ █▀▄ █▀█ █░█░█   █▀█ █░█ █░░ █▀▀ █▀
      # ▀▄▀▄▀ █ █░▀█ █▄▀ █▄█ ▀▄▀▄▀   █▀▄ █▄█ █▄▄ ██▄ ▄█


      # Example windowrule v1
      # windowrule = float, ^(kitty)$
      # Example windowrule v2
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more

      windowrulev2 = opacity 0.95 0.95,class:^(firefox)$
      windowrulev2 = opacity 0.90 0.90,class:^(Brave-browser)$
      windowrulev2 = opacity 0.80 0.80,class:^(Steam)$
#      windowrulev2 = opacity 0.80 0.80,class:^(steam)$
#      windowrulev2 = opacity 0.80 0.80,class:^(steamwebhelper)$
      windowrulev2 = opacity 0.80 0.80,class:^(Spotify)$
      windowrulev2 = opacity 0.80 0.80,class:^(Code)$
      windowrulev2 = opacity 0.80 0.80,class:^(code-url-handler)$
      windowrulev2 = opacity 0.80 0.80,class:^(kitty)$
      windowrulev2 = opacity 0.80 0.80,class:^(org.kde.dolphin)$
      windowrulev2 = opacity 0.80 0.80,class:^(org.kde.ark)$
      windowrulev2 = opacity 0.80 0.80,class:^(nwg-look)$
      windowrulev2 = opacity 0.80 0.80,class:^(qt5ct)$

      windowrulev2 = opacity 0.90 0.90,class:^(com.github.rafostar.Clapper)$ #Clapper-Gtk
      windowrulev2 = opacity 0.80 0.80,class:^(com.github.tchx84.Flatseal)$ #Flatseal-Gtk
      windowrulev2 = opacity 0.80 0.80,class:^(hu.kramo.Cartridges)$ #Cartridges-Gtk
      windowrulev2 = opacity 0.80 0.80,class:^(com.obsproject.Studio)$ #Obs-Qt
      windowrulev2 = opacity 0.80 0.80,class:^(gnome-boxes)$ #Boxes-Gtk
#      windowrulev2 = opacity 0.80 0.80,class:^(discord)$ #Discord-Electron
      windowrulev2 = opacity 0.80 0.80,class:^(WebCord)$ #WebCord-Electron
      windowrulev2 = opacity 0.80 0.80,class:^(app.drey.Warp)$ #Warp-Gtk
      windowrulev2 = opacity 0.80 0.80,class:^(net.davidotek.pupgui2)$ #ProtonUp-Qt
      windowrulev2 = opacity 0.80 0.80,class:^(yad)$ #Protontricks-Gtk
      windowrulev2 = opacity 0.80 0.80,class:^(Signal)$ #Signal-Gtk
      windowrulev2 = opacity 0.80 0.80,class:^(io.gitlab.theevilskeleton.Upscaler)$ #Upscaler-Gtk

      windowrulev2 = opacity 0.80 0.70,class:^(pavucontrol)$
      windowrulev2 = opacity 0.80 0.70,class:^(blueman-manager)$
      windowrulev2 = opacity 0.80 0.70,class:^(nm-applet)$
      windowrulev2 = opacity 0.80 0.70,class:^(nm-connection-editor)$
      windowrulev2 = opacity 0.80 0.70,class:^(org.kde.polkit-kde-authentication-agent-1)$

      windowrulev2 = float,class:^(qt5ct)$
      windowrulev2 = float,class:^(nwg-look)$
      windowrulev2 = float,class:^(org.kde.ark)$
      windowrulev2 = float,class:^(Signal)$ #Signal-Gtk
      windowrulev2 = float,class:^(com.github.rafostar.Clapper)$ #Clapper-Gtk
      windowrulev2 = float,class:^(app.drey.Warp)$ #Warp-Gtk
      windowrulev2 = float,class:^(net.davidotek.pupgui2)$ #ProtonUp-Qt
      windowrulev2 = float,class:^(yad)$ #Protontricks-Gtk
      windowrulev2 = float,class:^(eog)$ #Imageviewer-Gtk<BS>
      windowrulev2 = float,class:^(io.gitlab.theevilskeleton.Upscaler)$ #Upscaler-Gtk
      windowrulev2 = float,class:^(pavucontrol)$
      windowrulev2 = float,class:^(blueman-manager)$
      windowrulev2 = float,class:^(nm-applet)$
      windowrulev2 = float,class:^(nm-connection-editor)$
      windowrulev2 = float,class:^(org.kde.polkit-kde-authentication-agent-1)$

    '' ];
    
  };
}


