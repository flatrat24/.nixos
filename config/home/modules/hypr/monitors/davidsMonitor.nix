{ inputs, pkgs, ... }:
let
  dependencies = with pkgs; [ ];
in {
  wayland.windowManager.hyprland.settings = {
    "monitor" = [
      "DP-1, 1920x1080@60.00Hz, 0x0, 1"
    ];
  };
}
