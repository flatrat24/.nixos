{ pkgs, lib, config, ... }:
let
  cfg = config.waybar;
  dependencies = with pkgs; [
    waybar
  ];
in {
  options = {
    waybar.enable = lib.mkEnableOption "enables waybar";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = dependencies;

      home.file = {
        ".config/waybar" = {
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
            "waybar"
          ];
        };
      };
    })
  ]);
}
