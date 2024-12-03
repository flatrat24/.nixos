{ pkgs, ... }: {

  home.file = {
    ".config/zellij" = {
      source = ./sources/zellij;
      executable = false;
      recursive = true;
    };
  };

  home.packages = with pkgs; [
    zellij
  ];

}
