{ pkgs, ... }: {

  home.file = {
    ".config/zellij" = {
      source = ./sources;
      executable = false;
      recursive = true;
    };
  };

  home.packages = with pkgs; [
    zellij
  ];

}
