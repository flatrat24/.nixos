{ pkgs, lib, config, ... }:
let
  cfg = config.waycorner;
  dependencies = with pkgs; [
    waycorner
  ];
in {
  options = {
    waycorner.enable = lib.mkEnableOption "enables waycorner";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
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
