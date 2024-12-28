{ pkgs, lib, config, ... }:
let
  cfg = config.gaming;
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

  config = lib.mkIf cfg.enable (lib.mkMerge [
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
