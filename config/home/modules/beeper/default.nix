{ pkgs, lib, inputs, config, ... }:
let
    dependencies = with pkgs; [ beeper ];
in {
  options = {
    beeper.enable = lib.mkEnableOption "enable beeper";
  };

  config = lib.mkIf config.beeper.enable {
    home.packages = dependencies;
  };
}
