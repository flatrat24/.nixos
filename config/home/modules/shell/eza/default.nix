{ pkgs, lib, config, ... }:
let
  cfg = config.shell.programs.eza;
  dependencies = with pkgs; [
    eza
  ];
  aliases = {
    "ls" = "eza --group-directories-first --hyperlink";
    "la" = "ls --all --long --header --git";
    "lt" = "ls --tree --level=3";
  };
in {
  options = {
    shell.programs.eza = {
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
    {
      home.packages = dependencies;

      home.file = {
        ".config/eza/theme.yml" = {
          source = ./sources/eldritch.yml;
          executable = false;
          recursive = false;
        };
      };
    }
    (lib.mkIf cfg.bash.enable {
      programs.bash.shellAliases = aliases;
    })
    (lib.mkIf cfg.zsh.enable {
      programs.zsh.shellAliases = aliases;
    })
  ]);
}
