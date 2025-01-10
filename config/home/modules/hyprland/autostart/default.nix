{ pkgs, lib, config, ... }:
let
  cfg = config.hyprland.autostart;
  dependencies = with pkgs; [
    wl-clip-persist
    wl-clipboard
    cliphist
  ];
in {
  options = {
    hyprland.autostart = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.hyprland.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = dependencies;

    wayland.windowManager.hyprland = {
      settings = {
        "exec-once" = [
          # "upower-notify"
          "wl-paste --type text --watch cliphist store"
          "wl-paste --type image --watch cliphist store"
          "wl-clip-persist --clipboard regular"

          "[workspace 1 silent] foot -e ncmpcpp"
          "[workspace 2 silent] firefox"
          "[workspace 10 silent] thunderbird"
        ];
      };
    };
  };
}
