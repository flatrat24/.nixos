{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    waycorner
  ];
in {
  options = {
    waycorner.enable = lib.mkEnableOption "enables waycorner";
  };

  config = lib.mkIf config.waycorner.enable (lib.mkMerge [
    {
      home.packages = dependencies;

      home.file = {
        ".config/waycorner" = {
          source = ./sources;
          executable = false;
          recursive = true;
        };
      };
    }
    (lib.mkIf config.hyprland.enable {
      wayland.windowManager.hyprland = {
        settings = {
          "exec-once" = [
            "waycorner"
          ];
        };
      };
    })
  ]);
}
