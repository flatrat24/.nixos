{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.digital;
  dependencies = with pkgs; [ digital ];
in {
  options = {
    digital = {
      enable = lib.mkEnableOption "enable digital";
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = dependencies;
    };
  };
}
