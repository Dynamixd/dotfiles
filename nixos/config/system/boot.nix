{ pkgs, config, ... }:

{
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

boot.extraModprobeConfig = ''
  options snd slots=snd-hda-intel
  option snd_hda_intel enable =0,1
'';

  # Kernel Settings
  
}

