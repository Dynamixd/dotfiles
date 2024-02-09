{ config, pkgs, inputs, username, gtkThemeFromScheme, ...}:

let
  inherit (import ./options.nix)
  theme browser wallpaperDir wallpaperGit flakeDir
  waybarStyle;
in {
home.packages = [pkgs.dconf];
home.username = "zach";
home.homeDirectory = "/home/zach";
home.stateVersion = "23.11";

colorScheme = inputs.nix-colors.colorSchemes."${theme}";

imports = [
  inputs.nix-colors.homeManagerModules.default
  inputs.hyprland.homeManagerModules.default
  ./config/home
];

xresources.properties = {
  "Xcursor.size" = 24;
};

programs.git = {
  enable = true;
  userName = "zach";
  userEmail = "zacharydefoiwinter@gmail.com";
};

xdg = {
  userDirs = {
    enable = true;
    createDirectories = true;
  };
};

dconf.settings = {
  "org/virt-manager/virt-manager/connections" = {
    autoconnect = ["qemu:///system"];
    uris = ["qemu:///system"];
  };
};

programs.home-manager.enable = true;
}
