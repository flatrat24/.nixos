{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.beeper;
  dependencies = with pkgs; [ beeper ];
in {
  options = {
    beeper.enable = lib.mkEnableOption "enable beeper";
  };

  config = lib.mkIf cfg.enable {
    home.packages = dependencies;
  };
}
