{ pkgs, lib, inputs, config, ... }: {
  options = {
    monitors.microstepMSI.enable = lib.mkEnableOption "enables Microstep MSI G27C5";
  };

  config = lib.mkIf config.monitors.microstepMSI.enable {
    wayland.windowManager.hyprland.settings = {
      "monitor" = [
        "DP-1, 1920x1080@165.00Hz, 0x0, 1"
      ];
    };
  };
}
