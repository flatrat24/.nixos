{ pkgs, lib, config, ... }: {
  options = {
    network.enable = lib.mkEnableOption "enables network";
  };

  config = lib.mkIf config.network.enable {
    networking.networkmanager.enable = true;
    
    environment.systemPackages = [
      pkgs.networkmanager
      pkgs.networkmanagerapplet
    ];
  };
}
