{ pkgs, lib, inputs, config, ... }:
let
    dependencies = with pkgs; [ ${config.discord.client} ];
in {
  options = {
    discord = {
      enable = lib.mkEnableOption "enable discord";
      client = lib.mkOption {
        type = lib.types.str;
        default = "vesktop";
      };
    };
  };

  config = lib.mkIf config.discord.enable {
    home.packages = dependencies;
  };
}
