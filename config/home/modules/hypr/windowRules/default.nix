{ pkgs, lib, inputs, config, ... }: {
  options = {
    hypr.windowRules = {
      preventAutoFullscreen = lib.mkOption {
        type = lib.types.bool;
        default = config.hypr.enable;
      };
      battlenet = lib.mkOption { # Make dependent on gaming (is this too much modularity)
        type = lib.types.bool;
        default = config.hypr.enable;
      };
    };
  };
  
  config = lib.mkMerge [
    (lib.mkIf (config.hypr.windowRules.preventAutoFullscreen == true) {
      wayland.windowManager.hyprland.settings.windowrulev2 = [
        "suppressevent maximize, class:.*"
      ];
    })
    (lib.mkIf (config.hypr.windowRules.battlenet == true) {
      wayland.windowManager.hyprland.settings.windowrulev2 = [
        # Login Popup
        "float,class:battle.net.exe,title:Battle.net Login"
        # "noborder,class:battle.net.exe,title:Battle.net Login"
        "size 50% 50%,class:battle.net.exe,title:Battle.net Login"
        "move 25% 25%,class:battle.net.exe,title:Battle.net Login"

        "float,class:battle.net.exe,title:Battle.net"
        # "noborder,class:battle.net.exe,title:Battle.net"
        "size 75% 75%,class:battle.net.exe,title:Battle.net"
        "move 12.5% 12.5%,class:battle.net.exe,title:Battle.net"

        # Little weird system tray thing
        # "float,class:explorer.exe,title:Wine System Tray"
        # "size 40% 40%,class:explorer.exe,title:Wine System Tray"
        # "move 30% 30%,class:explorer.exe,title:Wine System Tray"
      ];
    })
    # wayland.windowManager.hyprland.settings = {
    #   windowrulev2 = [
    #     ##### Prevent auto-maximized applications #####
    #     "suppressevent maximize, class:.*"
    #
    #     # ##### Calculator #####
    #     # "size 20% 20%,title:Calculator"
    #     # "float,title:Calculator"
    #     # "move 40% 40%,title:Calculator"
    #
    #     # ##### System Monitor #####
    #     # "size 75% 75%,title:SystemMonitor"
    #     # "float,title:SystemMonitor"
    #     # "move 12.5% 12.5%,title:SystemMonitor"
    #
    #     # ##### KeePassXC Browswer Extension Popup #####
    #     # "float,class:org.keepassxc.KeePassXC,title:Unlock Database - KeePassXC"
    #     # "size 40% 40%,class:org.keepassxc.KeePassXC,title:Unlock Database - KeePassXC"
    #     # "move 30% 30%,class:org.keepassxc.KeePassXC,title:Unlock Database - KeePassXC"
    #
    #     # ##### Thunderbird Popups #####
    #     # "float,class:thunderbird,title:Edit Item"
    #     # "size 50% 50%,class:thunderbird,title:Edit Item"
    #     # "move 25% 25%,class:thunderbird,title:Edit Item"
    #   ];
    # };
  ];
}
