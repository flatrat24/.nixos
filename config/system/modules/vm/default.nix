{ lib, config, ... }: {
  options = {
    vm.enable = lib.mkEnableOption "enables vm";
  };

  config = lib.mkIf config.vm.enable {
    users.groups.libvirtd.members = [ "ea" ];
    virtualisation = {
      libvirtd.enable = true;
      spiceUSBRedirection.enable = true;
    };
  };
}
