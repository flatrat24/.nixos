# NOTE: This is intended only as the basic options that CANNOT be managed through
#       homemanager. This is not intended to set up a full gaming experience. Most
#       of that is done through homemanager.

{ pkgs, lib, config, ... }: {
  options = {
    gaming.enable = lib.mkEnableOption "enables gaming";
  };

  config = lib.mkIf config.gaming.enable {
    programs = {
      steam.enable = true;
      gamescopeSession.enable = true;
    };
  };
}
