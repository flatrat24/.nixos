{ pkgs, lib, inputs, config, ... }: {
  options = {
    monitors.framework.enable = lib.mkEnableOption "enables framework built in monitor";
  };

  config = lib.mkIf config.monitors.framework.enable {
    # wayland.windowManager.hyprland.settings = {
    #   "monitor" = [
    #     "eDP-1, 2880x1920@120.00Hz, 0x0, 2"
    #   ];
    # };
  };
}
