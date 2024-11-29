{ pkgs, ... }: {
  services.printing = {
    enable = true;
    drivers = [
      pkgs.cnijfilter2
      pkgs.hplip
    ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # hardware.printers = {
  #   ensurePrinters = [
  #     {
  #       name = "HP Color LaserJet M652";
  #       location = "ECS";
  #       deviceUri = "http://192.168.178.2:631/printers/Dell_1250c";
  #       model = "drv:///sample.drv/generic.ppd";
  #       ppdOptions = {
  #         PageSize = "A4";
  #       };
  #     }
  #   ];
  #   ensureDefaultPrinter = "Dell_1250c";
  # };
  #
  environment.systemPackages = with pkgs; [
    system-config-printer
  ];
}
