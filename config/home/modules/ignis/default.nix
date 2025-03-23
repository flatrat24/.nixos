{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.ignis;
  dependencies = with pkgs; [ inputs.ignis.packages."${system}".ignis ];
in {
  options = {
    ignis.enable = lib.mkEnableOption "enable ignis";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = dependencies;
      # home.packages = [
      #   inputs.ignis.packages."x86_64-linux".ignis
      # ];
    }
  ]);
}
