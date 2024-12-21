{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    waybar
  ];
in {
  options = {
    waybar.enable = lib.mkEnableOption "enables waybar";
  };

  config = lib.mkIf config.waybar.enable (lib.mkMerge [
    {
      home.packages = dependencies;

      home.file = {
        ".config/waybar" = {
          source = ./sources;
          executable = true;
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
