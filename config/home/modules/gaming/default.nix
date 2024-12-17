# TODO: Make this modular, I don't want to do this right now

{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    mangohud
    protonup
  ];
in {
  options = {
    gaming.enable = lib.mkEnableOption "enables gaming";
  };

  config = lib.mkIf config.gaming.enable (lib.mkMerge [
    {
      home.packages = with pkgs; [
        # Minecraft
        prismlauncher

        # Mindustry
        mindustry-wayland

        # Launchers
        lutris
        heroic
        bottles
      ] ++ dependencies;

      home.sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = 
          "\${HOME}/.steam/room/compatibilitytools.d";
      };
    }
    (lib.mkIf (config.hypr.windowRules.enable == true) {
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
  ]);
}
