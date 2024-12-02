{ pkgs, ... }:
let
  dependencies = with pkgs; [
    pavucontrol
  ];
{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;
  };

  environment.systemPackages = dependencies;
}
