{ pkgs, config, inputs, username, ...}:

let
  inherit (import ../../options.nix)
    browser wallpaperDir wallpaperGit flakeDir;
in {
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    git 
    lsof
    neofetch 
    btop 
    polkit_gnome 
    lm_sensors 
    zip
    unzip
    unrar
    libnotify
    eza
    v4l-utils
    ydotool
    wl-clipboard
    lsd
    lshw
    pkg-config
    pavucontrol
    symbola
    noto-fonts-color-emoji
    material-icons
    brightnessctl
    appimage-run
    spotify
    neovim
    swaynotificationcenter
    auto-cpufreq
    discord
    networkmanagerapplet
    # Import Scripts
    (import ./../scripts/squirtle.nix { inherit pkgs; })
    (import ./../scripts/wallsetter.nix { inherit pkgs; inherit wallpaperDir;
      inherit username; inherit wallpaperGit; })
    (import ./../scripts/themechange.nix { inherit pkgs; inherit flakeDir; })
    (import ./../scripts/theme-selector.nix { inherit pkgs; })
    (import ./../scripts/web-search.nix { inherit pkgs; })
    (import ./../scripts/rofi-launcher.nix { inherit pkgs; })
    (import ./../scripts/task-waybar.nix { inherit pkgs; })
    (import ./../scripts/dontkillsteam.nix { inherit pkgs; })
  ];

  programs.steam.gamescopeSession.enable = true;
  programs.dconf.enable = true;
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
  };
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
#    enableSShSupport = true;
  };
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
}
