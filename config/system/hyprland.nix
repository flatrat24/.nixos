{ pkgs, lib, config, ... }: { # TODO: remake module completely
  options = {
    hyprland.enable = lib.mkEnableOption "enables hyprland";
  };

  config = lib.mkIf config.hyprland.enable { };
}
