{ pkgs, lib, config, ... }:
let
  cfg = config.shell.programs.croc;
  dependencies = with pkgs; [
    croc
  ];
  crocAliases = { };
in {
  options = {
    shell.programs.croc = {
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
      programs.bash.shellAliases = crocAliases;
    })
    (lib.mkIf cfg.zsh.enable {
      programs.zsh.shellAliases = crocAliases;
    })
  ]);
}
