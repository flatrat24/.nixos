{ pkgs, lib, inputs, config, ... }:
let
  dependencies = with pkgs; [
    hyprpaper
  ];
in {
  options = {
    hypr.hyprpaper = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.hypr.enable;
      };
      wallpaper = lib.mkOption {
        type = lib.types.path;
        default = ../../../../assets/mountains.png; # TODO: Fix error where grove.png is always used no matter what
      };
    };
  };

  config = lib.mkIf config.hypr.hyprpaper.enable {
    home.packages = dependencies;

    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [
          "${config.hypr.hyprpaper.wallpaper}"
        ];
        wallpaper = [
          ",${config.hypr.hyprpaper.wallpaper}"
        ];
      };
    };
  };
}
