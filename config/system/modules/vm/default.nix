{ lib, config, ... }: {
  options = {
    vm.enable = lib.mkEnableOption "enables vm";
  };

  config = lib.mkIf config.vm.enable {
    programs.virt-manager.enable = true;
    users.groups.libvirtd.members = [ "ea" ];
    virtualisation = {
      libvirtd.enable = true;
      spiceUSBRedirection.enable = true;
    };
    users.users."ea".extraGroups = [ "libvirtd" ];
  };
}
