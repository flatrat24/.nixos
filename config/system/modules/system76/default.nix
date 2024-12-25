{ pkgs, lib, config, ... }: {
  options = {
    system76.enable = lib.mkEnableOption "enables system76 drivers";
  };

  config = lib.mkIf config.system76.enable {
    hardware.system76.enableAll = true;

    environment.systemPackages = with pkgs; [
      linuxKernel.packages.linux_zen.system76-power
      linuxKernel.packages.linux_zen.system76
      linuxKernel.packages.linux_zen.system76-scheduler
    ];
  };
}
