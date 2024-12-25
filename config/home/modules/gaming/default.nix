# TODO: Make this modular, I don't want to do this right now

{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    mangohud
    protonup
  ];
in {
  imports = [
    ./launchers
    ./mindustry
    ./minecraft
  ];

  options = {
    gaming = {
      enable = lib.mkEnableOption "enables gaming";
    };
  };

  config = lib.mkIf config.gaming.enable (lib.mkMerge [
    {
      home = {
        packages = dependencies;

        sessionVariables = {
          STEAM_EXTRA_COMPAT_TOOLS_PATHS = 
            "\${HOME}/.steam/room/compatibilitytools.d";
        };
      };
    }
  ]);
}
