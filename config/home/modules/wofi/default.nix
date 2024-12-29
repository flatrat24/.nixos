{ pkgs, lib, config, ... }:
let
  cfg = config.wofi;
  dependencies = with pkgs; [
    wofi
  ];
in {
  imports = [
    ./clipboard/default.nix
    ./emoji/default.nix
  ];

  options = {
    wofi = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.hyprland.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home = {
        packages = dependencies;
        file = {
          ".config/wofi" = {
            source = ./sources;
            executable = false;
            recursive = true;
          };
        };
      };
    }
    (lib.mkIf config.hyprland.enable (lib.mkMerge [
      {
        wayland.windowManager.hyprland.settings = {
          bindd = [
            "$mod, Space, Wofi Drun, exec, wofi --define=sort_order=alphabetical --show drun"
          ];
        };
      }
    ]))
  ]);
}
