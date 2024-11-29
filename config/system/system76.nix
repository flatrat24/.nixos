{ pkgs, ... }: {
  hardware.system76.enableAll = true;

  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_zen.system76-power
    linuxKernel.packages.linux_zen.system76
    linuxKernel.packages.linux_zen.system76-scheduler
  ];
}
