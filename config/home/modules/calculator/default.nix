{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.calculator;
  dependencies = with pkgs; [ gnome-calculator ];
in {
  options = {
    calculator.enable = lib.mkEnableOption "enable calculator";
  };

  config = lib.mkIf cfg.enable {
    home.packages = dependencies;
  };
}
