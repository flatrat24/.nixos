{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.pinta;
  dependencies = with pkgs; [ pinta ];
in {
  options = {
    pinta.enable = lib.mkEnableOption "enable pinta";
  };

  config = lib.mkIf cfg.enable {
    home.packages = dependencies;
  };
}
