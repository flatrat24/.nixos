{ pkgs, lib, inputs, config, ... }: {
  options = {
    hypr.windowRules = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.hypr.enable;
      };
    };
  };

  config = lib.mkIf (config.hypr.windowRules.enable == true) (lib.mkMerge [
    {
      wayland.windowManager.hyprland.settings.windowrulev2 = [
        "suppressevent maximize, class:.*"
      ];
    }    
  ]);
}
