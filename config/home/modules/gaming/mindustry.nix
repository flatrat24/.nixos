{ pkgs, lib, config, ... }: {
  options = {
    gaming.mindustry.enable = lib.mkEnableOption "enables mindustry";
  };

  config = lib.mkIf config.mindustry.enable {
    home.packages = with pkgs; [
      mindustry-wayland
    ];
  };
}
