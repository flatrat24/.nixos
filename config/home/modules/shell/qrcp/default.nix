{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    qrcp
  ];
  qrcpAliases = { };
in {
  options = {
    shell.programs.qrcp = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.shell.enable;
      };
      bash.enable = lib.mkOption {
        type = lib.types.bool;
        default = (config.shell.programs.qrcp.enable && config.shell.bash.enable);
      };
      zsh.enable = lib.mkOption {
        type = lib.types.bool;
        default = (config.shell.programs.qrcp.enable && config.shell.zsh.enable);
      };
    };
  };

  config = lib.mkIf config.shell.programs.qrcp.enable (lib.mkMerge [
    { home.packages = dependencies; }
    (lib.mkIf config.shell.programs.qrcp.bash.enable {
      programs.bash.shellAliases = qrcpAliases;
    })
    (lib.mkIf config.shell.programs.qrcp.zsh.enable {
      programs.zsh.shellAliases = qrcpAliases;
    })
  ]);
}
