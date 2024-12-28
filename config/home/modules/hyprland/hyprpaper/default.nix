{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.hyprland.hyprpaper;
  dependencies = with pkgs; [
    hyprpaper
  ];
in {
  options = {
    hyprland.hyprpaper = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.hyprland.enable;
      };
      wallpaper = lib.mkOption {
        type = lib.types.path;
        default = ../../../../assets/mountains.png;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = dependencies;

    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [
          "${cfg.wallpaper}"
        ];
        wallpaper = [
          ",${cfg.wallpaper}"
        ];
      };
    };
  };
}
