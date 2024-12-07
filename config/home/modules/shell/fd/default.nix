{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    fd
  ];
  fdAliases = { };
in {
  options = {
    shell.programs.fd = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.shell.enable;
      };
      bash.enable = lib.mkOption {
        type = lib.types.bool;
        default = (config.shell.programs.fd.enable && config.shell.bash.enable);
      };
      zsh.enable = lib.mkOption {
        type = lib.types.bool;
        default = (config.shell.programs.fd.enable && config.shell.zsh.enable);
      };
    };
  };

  config = lib.mkIf config.shell.programs.fd.enable (lib.mkMerge [
    { home.packages = dependencies; }
    (lib.mkIf config.shell.programs.fd.bash.enable {
      programs.bash.shellAliases = fdAliases;
    })
    (lib.mkIf config.shell.programs.fd.zsh.enable {
      programs.zsh.shellAliases = fdAliases;
    })
  ]);
}
