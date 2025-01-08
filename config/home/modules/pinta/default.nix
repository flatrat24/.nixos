{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.pinta;
  dependencies = with pkgs; [ pinta ];
in {
  options = {
    pinta.enable = lib.mkEnableOption "enable pinta";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = dependencies;
    }
    (lib.mkIf config.yazi.enable {
      programs.yazi.settings.opener = {
        image = [
          { run = ''pinta "$@"''; orphan = true; desc = " pinta"; }
        ];
      };
    })
  ]);
}
