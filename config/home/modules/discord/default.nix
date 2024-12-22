{ pkgs, lib, inputs, config, ... }:
let
  dependencies = with pkgs; [ legcord ];
in {
  options = {
    discord = {
      enable = lib.mkEnableOption "enable discord";
    };
  };

  config = lib.mkIf config.discord.enable {
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
