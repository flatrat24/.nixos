{ pkgs, lib, config, ... }: {
  options = {
    grub.enable = lib.mkEnableOption "enables GRUB";
  };
  
  config = lib.mkIf config.grub.enable {
    boot.loader = {
      grub = {
        enable = true;
        useOSProber = true;
        efiSupport = true;
        device = "nodev";
      };
      efi.canTouchEfiVariables = true;
    };
  };
}
