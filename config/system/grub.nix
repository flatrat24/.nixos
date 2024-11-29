{ config, pkgs, ... }:

{
  # Enable GRUB as bootloader
  boot.loader = {
    grub = {
      enable = true;
      useOSProber = true;
      efiSupport = true;
      device = "nodev";
    };
    efi.canTouchEfiVariables = true;
  };
}
