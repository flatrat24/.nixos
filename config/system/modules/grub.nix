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
        minegrub-theme = {
          enable = true;
          splash = "100% Flakes!";
          background = "background_options/1.8  - [Classic Minecraft].png";
          boot-options-count = 4;
        };
      };
      efi.canTouchEfiVariables = true;
    };
  };
}
