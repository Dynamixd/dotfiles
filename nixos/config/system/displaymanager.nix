{ pkgs, config, ... }:

{
  services.xserver = {
    enable = true;
    xkb = {
      variant = "";
      layout = "us";
    };
    libinput.enable = true;
    displayManager.sddm = {
      enable = true;
      autoNumlock = true;
      wayland.enable = true;
      theme = "sugar-dark";
    };
  };

  environment.systemPackages =
    let
      sugar = pkgs.callPackage ../pkgs/sddm-sugar-dark.nix {};
      tokyo-night = pkgs.libsForQt5.callPackage ../pkgs/sddm-tokyo-night.nix {};
    in [ 
      sugar.sddm-sugar-dark # Name: sugar-dark
      tokyo-night # Name: tokyo-night-sddm
      pkgs.libsForQt5.qt5.qtgraphicaleffects
    ];
}

