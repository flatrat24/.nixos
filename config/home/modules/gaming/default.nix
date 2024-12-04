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

  config = lib.mkIf config.gaming.enable {
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
  };
}
