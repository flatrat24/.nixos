{ lib, config, ... }: {
  options = {
    systemd-boot.enable = lib.mkEnableOption "enables systemd-boot";
  };
  
  config = lib.mkIf config.systemd-boot.enable {
    boot.loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
    };
  };
}
