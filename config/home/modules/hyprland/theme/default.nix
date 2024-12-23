{ pkgs, lib, inputs, config, ... }: {
  options = {
    hyprland.animations.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkMerge [
    (lib.mkIf (config.hyprland.enable == true) {
      wayland.windowManager.hyprland.settings = {
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

        master = {
          mfact = "0.5";
        };

        decoration = {
          "rounding" = "0";
          "active_opacity" = "1.0";
          "inactive_opacity" = "1.0";
          # "drop_shadow" = "true";
          # "shadow_range" = "4";
          # "shadow_render_power" = "3";
          "blur" = {
            "enabled" = "true";
            "size" = "3";
            "passes" = "1";
            "vibrancy" = "0.1696";
          };
        };

        animations = lib.mkMerge [
          (lib.mkIf (config.hyprland.animations.enable == true) { "enabled" = "true"; })
          (lib.mkIf (config.hyprland.animations.enable == false) { "enabled" = "false"; })
          { # Unconditional
            "bezier" = "myBezier, 0.05, 0.9, 0.1, 1.05";
            "animation" = [
              "windows, 1, 2, myBezier, slidein"
              "border, 1, 2, default"
              "fade, 1, 2, default"
              "workspaces, 1, 2, default, slide"
            ];
          }
        ];

        dwindle = {
          "pseudotile" = "true";
          "preserve_split" = "true";
        };

        master = {
          "new_status" = "slave";
        };

        misc = {
          "force_default_wallpaper" = "-1";
          "disable_hyprland_logo" = "true";
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
      };
    })
  ];
}
