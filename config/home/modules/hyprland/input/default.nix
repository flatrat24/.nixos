{ pkgs, lib, inputs, config, ... }:
let
  dependencies = with pkgs; [ ];
in {
  options = {
    input = {
      touchpad.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };
  };

  config = lib.mkIf config.hyprland.enable {
    wayland.windowManager.hyprland.settings = {
      input = {
        "kb_layout" = "us";
        "kb_variant" = "";
        "kb_model" = "";
        "kb_options" = "caps:escape";
        "kb_rules" = "";
        "repeat_rate" = "30";
        "repeat_delay" = "200";

        "follow_mouse" = "2";
        "sensitivity" = "0";
        "mouse_refocus" = "1";
        "float_switch_override_focus" = "0";
      };
      binds = {
        "allow_workspace_cycles" = "true";
      };
    };
  };
}
