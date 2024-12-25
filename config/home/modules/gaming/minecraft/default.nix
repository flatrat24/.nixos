{ pkgs, lib, config, ... }:
let
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

  config = lib.mkIf config.gaming.minecraft.enable (lib.mkMerge [
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
