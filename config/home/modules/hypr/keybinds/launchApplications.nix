{ pkgs, lib, inputs, config, ... }: {
  options = {};

  # config = lib.mkIf config.hypr.enable {
  #   wayland.windowManager.hyprland.settings = {
  #     bindd = [
  #       ##### Launch Applications #####
  #       "$mod, Escape, Lock Screen, exec, hyprlock"
  #       "$mod, A, Launch Terminal, exec, $terminal"
  #       "$mod, S, Launch Browser, exec, $browser"
  #     ];
  #   };
  # };

  config = lib.mkIf config.hypr.enable (lib.mkMerge [
    {
      wayland.windowManager.hyprland.settings = {
        bindd = [
          "$mod, Escape, Lock Screen, exec, hyprlock"
          "$mod, A, Launch Terminal, exec, $terminal"
          "$mod, S, Launch Browser, exec, $browser"
        ];
      };
    }
    (lib.mkIf config.wofi.enable (lib.mkMerge [
      {
        wayland.windowManager.hyprland.settings = {
          bindd = [
            "$mod, Space, Wofi Drun, exec, wofi -c ~/.config/wofi/configs/default --show drun"
          ];
        };
      }
      (lib.mkIf config.wofi.emoji.enable {
        wayland.windowManager.hyprland.settings = {
          bindd = [
            "$mod, e, Wofi Emoji, exec, wofi-emoji"
          ];
        };
      })
    ]))
  ]);
}
