{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    cliphist
  ];
in {
  options = {
    wofi.clipboard.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.wofi.enable;
    };
  };

  config = lib.mkIf config.wofi.clipboard.enable (lib.mkMerge [
    { home.packages = dependencies; }
    (lib.mkIf config.hypr.enable {
      wayland.windowManager.hyprland.settings = {
        bindd = [
          "$mod, v, Wofi Clipboard Select, exec, cliphist list | wofi --show dmenu -c ~/.config/wofi/configs/clipboard | cliphist decode | wl-copy"
          "$mod SHIFT, v, Wofi Clipboard Remove, exec, cliphist list | wofi --show dmenu -c ~/.config/wofi/configs/clipboard | cliphist delete"
        ];
      };
    })
  ]);
}
