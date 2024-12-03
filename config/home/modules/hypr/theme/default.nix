{ inputs, pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    general = {
      "gaps_in" = "5";
      "gaps_out" = "5";
      "border_size" = "3";
      "resize_on_border" = "true" ;
      "allow_tearing" = "false";
      "layout" = "master";
    };

    decoration = {
      "rounding" = "0";
      "active_opacity" = "1.0";
      "inactive_opacity" = "1.0";
      "drop_shadow" = "true";
      "shadow_range" = "4";
      "shadow_render_power" = "3";
      "blur" = {
        "enabled" = "true";
        "size" = "3";
        "passes" = "1";
        "vibrancy" = "0.1696";
      };
    };

    animations = {
      "enabled" = "true";
      "bezier" = "myBezier, 0.05, 0.9, 0.1, 1.05";
      "animation" = [
        "windows, 1, 2, myBezier, slidein"
        "border, 1, 2, default"
        "fade, 1, 2, default"
        "workspaces, 1, 2, default, slide"
      ];
    };

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
}
