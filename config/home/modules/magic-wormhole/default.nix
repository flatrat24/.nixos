{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.magic-wormhole;
  dependencies = with pkgs; [
    warp
    magic-wormhole
  ];
in {
  options = {
    magic-wormhole = {
      enable = lib.mkEnableOption "enable magic-wormhole";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home = {
        packages = dependencies;
      };
    }
    (lib.mkIf config.hyprland.enable {
      wayland.windowManager.hyprland.settings.windowrulev2 = [
        "float,title:Warp"
        "size 30% 80%,title:Warp"
        "center 1,title:Warp"

        # For file choosing
        "float,title:Select File to Send"
        "size 25% 70%,title:Select File to Send"
        "center 1,title:Select File to Send"
      ];
    })
  ]);
}
