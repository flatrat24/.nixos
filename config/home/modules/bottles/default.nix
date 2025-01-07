{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.bottles;
  dependencies = with pkgs; [ bottles ];
in {
  options = {
    bottles.enable = lib.mkEnableOption "enable bottles";
  };

  config = lib.mkIf cfg.enable {
    home.packages = dependencies;
  };
}
