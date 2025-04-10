{ pkgs, lib, config, ... }:
let
  cfg = config.shell.programs.utils;
  dependencies = with pkgs; [
    wget
    moreutils
    xdg-utils
    imagemagick
    poppler_utils
    pdftk
    killall
    nix-prefetch-github
    nix-index
    unzip
    gcc
  ];
  aliases = { };
in {
  options = {
    shell.programs.utils = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.shell.enable;
      };
      bash.enable = lib.mkOption {
        type = lib.types.bool;
        default = (cfg.enable && config.shell.bash.enable);
      };
      zsh.enable = lib.mkOption {
        type = lib.types.bool;
        default = (cfg.enable && config.shell.zsh.enable);
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    { home.packages = dependencies; }
    (lib.mkIf cfg.bash.enable {
      programs.bash.shellAliases = aliases;
    })
    (lib.mkIf cfg.zsh.enable {
      programs.zsh.shellAliases = aliases;
    })
  ]);
}
