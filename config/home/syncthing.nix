{ pkgs, ... }: {
  services.syncthing = {
    enable = true;
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      devices = {
        "Andy" = { id = "3E42ZYP-3G6CCEP-SLAQBO7-Q3T5NRQ-3RMXHAG-TPXA2NT-7RPBXOK-VM7ZUQI"; };
      };
      folders = {
        "Documents" = {
          id = "4xjn5-5eppj";
          path = "/home/ea/Documents";
          devices = [ "Andy" ];
        };
        "Music" = {
          id = "9jdk1-Pk0ak";
          path = "/home/ea/Music";
          devices = [ "Andy" ];
        };
      };
    };
  };
}
