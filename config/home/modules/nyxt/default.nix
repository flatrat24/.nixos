{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.nyxt;
  dependencies = with pkgs; [ nyxt ];
in {
  options = {
    nyxt.enable = lib.mkEnableOption "enable nyxt";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = dependencies;
    }
  ]);
}
