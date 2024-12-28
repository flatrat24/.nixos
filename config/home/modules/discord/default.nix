{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.discord;
  dependencies = with pkgs; [ legcord ];
in {
  options = {
    discord = {
      enable = lib.mkEnableOption "enable discord";
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = dependencies;

      file = {
        ".config/legcord" = {
          source = ./sources;
          executable = false;
          recursive = true;
        };
      };
    };
  };
}
