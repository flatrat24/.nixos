{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.hyprland.theme;
in {
  options = {
    hyprland.theme = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.hyprland.enable;
      };
      animations.enable = lib.mkOption {
        type = lib.types.bool;
        default = config.hyprland.theme.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    stylix.targets = {
      hyprland.enable = true;
    };

    wayland.windowManager.hyprland.settings = (lib.mkMerge [
      {
        cursor = {
          "no_hardware_cursors" = "true";
        };

        general = {
          "gaps_in" = "5";
          "gaps_out" = "10";
          "border_size" = "3";
          "resize_on_border" = "true" ;
          "allow_tearing" = "false";
          "layout" = "master";
        };

        dwindle = {
          "pseudotile" = "true";
          "preserve_split" = "true";
        };

        master = {
          "new_status" = "slave";
          mfact = "0.5";
        };

        misc = {
          "force_default_wallpaper" = "-1";
          "disable_hyprland_logo" = lib.mkDefault "true";
        };

        decoration = {
          active_opacity = "1.0";
          inactive_opacity = "1.0";
          fullscreen_opacity = "1.0";

          blur = {
            enabled = "true";
            size = "8";
            passes = "2";
            new_optimizations = "true";
            ignore_opacity = "true";
          };
        };

        group = {
          groupbar = {
            "enabled" = "true";
            "font_size" = "10";
            "font_family" = "IBM Plex Sans";
            "height" = "14";
            "render_titles" = "true";
          };
        };
      }
      (lib.mkIf cfg.animations.enable {
        animations = {
          "bezier" = "myBezier, 0.05, 0.9, 0.1, 1.05";
          "animation" = [
            "windows, 1, 2, myBezier, popin"
            "border, 1, 2, default"
            "fade, 1, 2, default"
            "workspaces, 1, 2, default, slide"
          ];
        };
      })
    ]);
  };
}
