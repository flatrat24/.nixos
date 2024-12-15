{ pkgs, lib, inputs, config, ... }: {
  options = {
    hypr.windowRules = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.hypr.enable;
      };
    };
  };
  
  config = lib.mkMerge [
    (lib.mkIf (config.hypr.windowRules.enable) {
      wayland.windowManager.hyprland.settings.windowrulev2 = [
        "suppressevent maximize, class:.*"
      ];
    })
    (lib.mkIf (config.hypr.windowRules.enable && config.gaming.enable) {
      wayland.windowManager.hyprland.settings.windowrulev2 = [
        ##--- Minecraft ---##
        "float,class:Minecraft*,title:Minecraft*"
        "size 75% 75%,class:Minecraft*,title:Minecraft*"
        "move 12.5% 12.5%,class:Minecraft*,title:Minecraft*"

        ##--- Battle.net ---##
        # Login Popup
        "float,class:battle.net.exe,title:Battle.net Login"
        "size 50% 50%,class:battle.net.exe,title:Battle.net Login"
        "move 25% 25%,class:battle.net.exe,title:Battle.net Login"
        # Battle.net client
        "float,class:battle.net.exe,title:Battle.net"
        "size 75% 75%,class:battle.net.exe,title:Battle.net"
        "move 12.5% 12.5%,class:battle.net.exe,title:Battle.net"
        # Little weird system tray thing
        # "float,class:explorer.exe,title:Wine System Tray"
        # "size 40% 40%,class:explorer.exe,title:Wine System Tray"
        # "move 30% 30%,class:explorer.exe,title:Wine System Tray"
      ];
    })
    (lib.mkIf (config.hypr.windowRules.enable && config.firefox.enable) {
      wayland.windowManager.hyprland.settings.windowrulev2 = [
        "float,class:firefox,title:Picture-in-Picture"
        "size 50% 50%,class:firefox,title:Picture-in-Picture"
        "move 25% 25%,class:firefox,title:Picture-in-Picture"
      ];
    })
  ];
}
