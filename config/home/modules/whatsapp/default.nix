{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.whatsapp;
  dependencies = with pkgs; [ zapzap ];
in {
  options = {
    whatsapp = {
      enable = lib.mkEnableOption "enable whatsapp";
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = dependencies;
    };
  };
}
