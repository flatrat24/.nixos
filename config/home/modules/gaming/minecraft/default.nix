{ pkgs, lib, config, ... }:
let
  cfg = config.gaming.minecraft;
  dependencies = with pkgs; [ ];
in {
  options = {
    gaming = {
      minecraft.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = with pkgs; [
        prismlauncher
      ];
    }
    (lib.mkIf (config.hyprland.windowRules.enable) {
      wayland.windowManager.hyprland.settings.windowrulev2 = [
        "float,class:Minecraft*,title:Minecraft*"
        "size 75% 75%,class:Minecraft*,title:Minecraft*"
        "move 12.5% 12.5%,class:Minecraft*,title:Minecraft*"
      ];
    })
  ]);
}
