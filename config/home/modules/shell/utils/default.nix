{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    moreutils
    xdg-utils
    imagemagick
    poppler_utils
    killall
  ];
  utilsAliases = { };
in {
  options = {
    shell.programs.utils = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.shell.enable;
      };
      bash.enable = lib.mkOption {
        type = lib.types.bool;
        default = (config.shell.programs.utils.enable && config.shell.bash.enable);
      };
      zsh.enable = lib.mkOption {
        type = lib.types.bool;
        default = (config.shell.programs.utils.enable && config.shell.zsh.enable);
      };
    };
  };

  config = lib.mkIf config.shell.programs.utils.enable (lib.mkMerge [
    { home.packages = dependencies; }
    (lib.mkIf config.shell.programs.utils.bash.enable {
      programs.bash.shellAliases = utilsAliases;
    })
    (lib.mkIf config.shell.programs.utils.zsh.enable {
      programs.zsh.shellAliases = utilsAliases;
    })
  ]);
}
