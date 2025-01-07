{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.octave;
  dependencies = with pkgs; [ octaveFull ];
in {
  options = {
    octave.enable = lib.mkEnableOption "enable octave";
  };

  config = lib.mkIf cfg.enable {
    home.packages = dependencies;
  };
}
