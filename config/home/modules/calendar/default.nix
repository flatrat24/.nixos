{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.calendar;
  dependencies = with pkgs; [ gnome-calendar ];
in {
  options = {
    calendar.enable = lib.mkEnableOption "enable calendar";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = dependencies;
    }
    (lib.mkIf config.hyprland.enable {
      wayland.windowManager.hyprland = {
        settings = {
          "exec-once" = [
            "[workspace 10 silent] gnome-calendar"
          ];
        };
      };
    })
  ]);
}
