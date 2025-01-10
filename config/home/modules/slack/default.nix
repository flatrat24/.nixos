{ pkgs, lib, config, ... }:
let
  cfg = config.slack;
  dependencies = with pkgs; [
    slack
    slack-term
  ];
in {
  imports = [ ];

  options = {
    slack = {
      enable = lib.mkEnableOption "enables slack";
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
            "[workspace 9 silent] slack"
          ];
          windowrulev2 = [
            "group set,title:Slack,class:Slack"
          ];
        };
      };
    })
  ]);
}
