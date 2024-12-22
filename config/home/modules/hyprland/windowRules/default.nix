{ pkgs, lib, inputs, config, ... }: {
  options = {
    hyprland.windowRules = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.hyprland.enable;
      };
    };
  };

  config = lib.mkIf (config.hyprland.windowRules.enable == true) (lib.mkMerge [
    {
      wayland.windowManager.hyprland.settings.windowrulev2 = [
        "suppressevent maximize, class:.*"
      ];
    }    
  ]);
}
