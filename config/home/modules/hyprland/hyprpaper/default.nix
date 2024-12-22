{ pkgs, lib, inputs, config, ... }:
let
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
        default = ../../../../assets/mountains.png; # TODO: Fix error where grove.png is always used no matter what
      };
    };
  };

  config = lib.mkIf config.hyprland.hyprpaper.enable {
    home.packages = dependencies;

    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [
          "${config.hyprland.hyprpaper.wallpaper}"
        ];
        wallpaper = [
          ",${config.hyprland.hyprpaper.wallpaper}"
        ];
      };
    };
  };
}
