{ pkgs, ... }: {
  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = ["org.pwmt.zathura.desktop"];
        "inode/directory" = ["yazi.desktop"];
      };
    };
  };
}
