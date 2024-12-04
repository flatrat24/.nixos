{ pkgs, lib, inputs, config, ... }: {
  options = {
    hypr.windowRules = {
      preventAutoFullscreen = lib.mkOption {
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
