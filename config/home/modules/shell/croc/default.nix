{ pkgs, lib, config, ... }:
let
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
        default = (config.shell.programs.croc.enable && config.shell.bash.enable);
      };
      zsh.enable = lib.mkOption {
        type = lib.types.bool;
        default = (config.shell.programs.croc.enable && config.shell.zsh.enable);
      };
    };
  };

  config = lib.mkIf config.shell.programs.croc.enable (lib.mkMerge [
    { home.packages = dependencies; }
    (lib.mkIf config.shell.programs.croc.bash.enable {
      programs.bash.shellAliases = crocAliases;
    })
    (lib.mkIf config.shell.programs.croc.zsh.enable {
      programs.zsh.shellAliases = crocAliases;
    })
  ]);
}
