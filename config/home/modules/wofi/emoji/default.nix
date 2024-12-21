# TODO: Get wofi-emoji working with specified configs/styles

{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    wofi-emoji
  ];
in {
  options = {
    wofi = {
      emoji.enable = lib.mkOption {
        type = lib.types.bool;
        default = config.wofi.enable;
      };
    };
  };

  config = lib.mkIf config.wofi.emoji.enable (lib.mkMerge [
    { home.packages = dependencies; }
    (lib.mkIf config.hyprland.enable {
      wayland.windowManager.hyprland.settings = {
        bindd = [
          "$mod, e, Wofi Emoji, exec, wofi-emoji"
        ];
      };
    })
  ]);
}
