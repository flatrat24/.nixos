{ inputs, pkgs, ... }:
let
  dependencies = with pkgs; [ ];
in {
  imports = [
    ./framework.nix
  ];

  wayland.windowManager.hyprland.settings = {
    "monitor" = [
      ", preferred, auto-right, 1"
    ];
  };
}
