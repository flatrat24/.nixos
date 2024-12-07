{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    ripgrep
  ];
  ripgrepAliases = { };
in {
  options = {
    shell.programs.ripgrep = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.shell.enable;
      };
      bash.enable = lib.mkOption {
        type = lib.types.bool;
        default = (config.shell.programs.ripgrep.enable && config.shell.bash.enable);
      };
      zsh.enable = lib.mkOption {
        type = lib.types.bool;
        default = (config.shell.programs.ripgrep.enable && config.shell.zsh.enable);
      };
    };
  };

  config = lib.mkIf config.shell.programs.ripgrep.enable (lib.mkMerge [
    { home.packages = dependencies; }
    (lib.mkIf config.shell.programs.ripgrep.bash.enable {
      programs.bash.shellAliases = ripgrepAliases;
    })
    (lib.mkIf config.shell.programs.ripgrep.zsh.enable {
      programs.zsh.shellAliases = ripgrepAliases;
    })
  ]);
}
