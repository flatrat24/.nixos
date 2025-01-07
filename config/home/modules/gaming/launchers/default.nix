{ pkgs, lib, config, ... }:
let
  cfg = config.gaming.launchers;
in {
  options = {
    gaming = {
      launchers = {
        heroic.enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
        };
        lutris.enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
        };
      };
    };
  };

  config = (lib.mkMerge [
    (lib.mkIf cfg.heroic.enable {
      home.packages = with pkgs; [ heroic ];
    })
    (lib.mkIf cfg.lutris.enable {
      home.packages = with pkgs; [ lutris ];
    })
    (lib.mkIf (config.hyprland.enable) {
      wayland.windowManager.hyprland.settings.windowrulev2 = [
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
  ]);
}
