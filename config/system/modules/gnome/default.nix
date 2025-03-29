{ pkgs, lib, config, ... }: {
  options = {
    gnome.enable = lib.mkEnableOption "enables gnome";
  };

  config = lib.mkIf config.gnome.enable {
    services.xserver = {
      enable = true;
      desktopManager.gnome.enable = true;
    };
  };
}
