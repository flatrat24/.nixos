{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.rtorrent;
  dependencies = with pkgs; [ rtorrent ];
in {
  options = {
    rtorrent = {
      enable = lib.mkEnableOption "enable rtorrent";
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = dependencies;
    };
  };
}
