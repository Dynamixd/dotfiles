{ pkgs, config, inputs, username, ...}:

let
  inherit (import ../../options.nix)
    browser wallpaperDir wallpaperGit flakeDir;
in {
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    wget
    curl
    git 
    neofetch 
    htop 
    btop 
    libvirt 
    polkit_gnome 
    lm_sensors 
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
    sof-firmware
    alsa-lib
    apulse
    pavucontrol
    hugo
    symbola
    noto-fonts-color-emoji
    material-icons
    brightnessctl
    toybox
    virt-viewer
    swappy
    ripgrep
    appimage-run
    spotify
    lsd
    neovim
    swaynotificationcenter
    auto-cpufreq
    grim
    slurp
    mako
    discord
    networkmanagerapplet
    # Import Scripts
    (import ./../scripts/emopicker9000.nix { inherit pkgs; })
    (import ./../scripts/squirtle.nix { inherit pkgs; })
    (import ./../scripts/wallsetter.nix { inherit pkgs; inherit wallpaperDir;
      inherit username; inherit wallpaperGit; })
    (import ./../scripts/themechange.nix { inherit pkgs; inherit flakeDir; })
    (import ./../scripts/theme-selector.nix { inherit pkgs; })
    (import ./../scripts/web-search.nix { inherit pkgs; })
    (import ./../scripts/rofi-launcher.nix { inherit pkgs; })
    (import ./../scripts/task-waybar.nix { inherit pkgs; })
    (import ./../scripts/dontkillsteam.nix { inherit pkgs; })
    (import ./../scripts/screenshootin.nix { inherit pkgs; })
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
