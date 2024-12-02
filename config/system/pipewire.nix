{ pkgs, ... }:
let
  dependencies = with pkgs; [
    pavucontrol
  ];
{
  environment.systemPackages = dependencies;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
