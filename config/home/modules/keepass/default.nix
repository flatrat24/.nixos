{ pkgs, lib, config, ... }: {
  options = {
    keepass.enable = lib.mkEnableOption "enables keepass";
  };

  config = lib.mkIf config.keepass.enable {
    home.packages = with pkgs; [
      keepassxc
      keepassxc-go
      keepass-diff
    ];
  };
}
