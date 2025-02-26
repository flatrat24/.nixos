{ pkgs, lib, config, ... }: {
  options = {
    bluetooth.enable = lib.mkEnableOption "enables bluetooth";
  };

  config = lib.mkIf config.bluetooth.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
        };
      };
    };

    services.blueman.enable = true;

    environment.systemPackages = with pkgs; [
      bluez
      bluetui
    ];
  };
}
