{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.beeper;
  # beeper = import ../../../../derivations/beeper.nix { inherit pkgs; };
  dependencies = [
    pkgs.beeper
  ];
in {
  options = {
    beeper.enable = lib.mkEnableOption "enable beeper";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = dependencies;
    }
    (lib.mkIf config.hyprland.enable {
      wayland.windowManager.hyprland = {
        settings = {
          "exec-once" = [
            "[workspace 9 silent] beepertexts"
          ];
          windowrulev2 = [
            "group set,title:Beeper,class:Beeper"
          ];
        };
      };
    })
  ]);
}
