{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.overskride;
  dependencies = with pkgs; [
    overskride
  ];
in {
  options = {
    overskride.enable = lib.mkEnableOption "enable overskride";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = dependencies;
    }
    (lib.mkIf config.hyprland.enable {
      wayland.windowManager.hyprland.settings.windowrulev2 = [
        # For opening it from waybar
        "float,title:overskride"
        "size 30% 80%,title:overskride"
        "center 1,title:overskride"
      ];
    })
  ]);
}
