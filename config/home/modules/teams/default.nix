{ pkgs, lib, config, ... }:
let
  cfg = config.teams;
  dependencies = with pkgs; [
    teams-for-linux
  ];
in {
  imports = [ ];

  options = {
    teams = {
      enable = lib.mkEnableOption "enables teams";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = dependencies;
    }
    (lib.mkIf config.hyprland.enable {
      wayland.windowManager.hyprland = {
        settings = {
          "exec-once" = [
            "[workspace 9 silent] teams-for-linux"
          ];
          windowrulev2 = [
            "group set,class:teams-for-linux"
          ];
        };
      };
    })
  ]);
}
