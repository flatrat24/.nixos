{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    wofi
  ];
in {
  options = {
    wofi = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.hypr.enable;
      };
      emoji.enable = lib.mkOption {
        type = lib.types.bool;
        default = config.wofi.enable;
      };
    };
  };

  config = lib.mkIf config.wofi.enable (lib.mkMerge [
    { home.packages = dependencies; }
    (lib.mkIf config.wofi.emoji.enable {
      home.packages = with pkgs; [ wofi-emoji ];
    })
  ]);

}
