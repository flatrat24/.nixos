{ pkgs, lib, inputs, config, ... }: {
  imports = [
    ./framework.nix
    ./microstepMSI.nix
  ];

  options = {
    monitors.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.hypr.enable;
    };
  };

  config = lib.mkIf config.monitors.enable {
    wayland.windowManager.hyprland.settings = {
      "monitor" = [
        ", preferred, auto-right, 1"
        "Unknown-1, disable"
      ];
    };
  };
}
