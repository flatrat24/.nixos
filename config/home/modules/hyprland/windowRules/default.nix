{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.hyprland.windowRules;
in {
  options = {
    hyprland.windowRules = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.hyprland.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings.windowrulev2 = [
      "suppressevent maximize, class:.*"
    ];
  };
}
