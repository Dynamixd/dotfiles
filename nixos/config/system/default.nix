{ config, pkgs, ...}:

{
  imports = [
    ./boot.nix
    ./displaymanager.nix
    ./services.nix
    ./polkit.nix
    ./packages.nix
    ./nvidia.nix
    ./steam.nix
    ./appimages.nix
  ];

}
