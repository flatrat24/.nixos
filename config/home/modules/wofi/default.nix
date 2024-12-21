{ pkgs, lib, config, ... }:
let
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

  config = lib.mkIf config.wofi.enable (lib.mkMerge [
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
            "$mod, Space, Wofi Drun, exec, wofi --show drun"
          ];
        };
      }
    ]))
  ]);
}
