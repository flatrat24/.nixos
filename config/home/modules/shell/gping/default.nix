{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    gping
  ];
  gpingAliases = { };
in {
  options = {
    shell.programs.gping = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.shell.enable;
      };
      bash.enable = lib.mkOption {
        type = lib.types.bool;
        default = (config.shell.programs.gping.enable && config.shell.bash.enable);
      };
      zsh.enable = lib.mkOption {
        type = lib.types.bool;
        default = (config.shell.programs.gping.enable && config.shell.zsh.enable);
      };
    };
  };

  config = lib.mkIf config.shell.programs.gping.enable (lib.mkMerge [
    { home.packages = dependencies; }
    (lib.mkIf config.shell.programs.gping.bash.enable {
      programs.bash.shellAliases = gpingAliases;
    })
    (lib.mkIf config.shell.programs.gping.zsh.enable {
      programs.zsh.shellAliases = gpingAliases;
    })
  ]);
}
