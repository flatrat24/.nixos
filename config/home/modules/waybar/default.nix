{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [ waybar ];
in {
  options = {
    waybar.enable = lib.mkEnableOption "enables waybar";
  };

  config = lib.mkIf config.waybar.enable {
    home.packages = dependencies;

    home.file = {
      ".config/waybar" = {
        source = ./sources;
        executable = false;
        recursive = true;
      };
    };
  };
}
