{ pkgs, lib, config, ... }: {
  options = {
    gaming.enable = lib.mkEnableOption "enables gaming";
  };

  config = lib.mkIf config.gaming.enable {
    home.packages = with pkgs; [
      # Minecraft
      prismlauncher

      # Mindustry
      mindustry-wayland
    ];
  };
}
