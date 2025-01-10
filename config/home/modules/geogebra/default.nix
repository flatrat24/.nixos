{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.geogebra;
  dependencies = with pkgs; [ geogebra6 ];
in {
  options = {
    geogebra.enable = lib.mkEnableOption "enable geogebra";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = dependencies;
    }
  ]);
}
