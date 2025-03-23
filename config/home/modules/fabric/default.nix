{ config, pkgs, inputs, ... }:
let
  ax-shell = builtins.fetchGit {
    url = "https://github.com/HeyImKyu/Ax-Shell.git";
    ref = "main";
    rev = "64f55eb4ac4d73bb8b9756dc5154afbe41c69ebc";
  };
in
{
  home.file."${config.xdg.configHome}/Ax-Shell" = {
    source = ax-shell;
  };

  home.file.".local/share/fonts/tabler-icons.ttf" = {
    source = "${ax-shell}/assets/fonts/tabler-icons/tabler-icons.ttf";
  };

  home.file."${config.xdg.configHome}/matugen/config.toml" = {
    source = ./matugen.toml;
  };

  home.packages = with pkgs; [
    matugen
    cava
    fabric
    fabric-cli
    (fabric-run-widget.override {
      extraPythonPackages = with python3Packages; [
        ijson
        pillow
        psutil
        requests
        setproctitle
        toml
        watchdog
      ];
      extraBuildInputs = [
        fabric-gray
        networkmanager
        networkmanager.dev
        playerctl
      ];
    })
    fabric-cli
  ];
}
