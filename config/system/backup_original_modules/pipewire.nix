{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    pavucontrol
  ];
in {
  options = {
    pipewire.enable = lib.mkEnableOption "enables pipewire";
  };
  
  config = lib.mkIf config.pipewire.enable {
    environment.systemPackages = dependencies;

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
