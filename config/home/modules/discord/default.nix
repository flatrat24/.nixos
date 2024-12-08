{ pkgs, lib, inputs, config, ... }:
let
    dependencies = with pkgs; [ vesktop ];
in {
  options = {
    discord = {
      enable = lib.mkEnableOption "enable discord";
    };
  };

  config = lib.mkIf config.discord.enable {
    home.packages = dependencies;
  };
}
