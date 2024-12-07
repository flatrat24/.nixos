{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    eza
  ];
  ezaAliases = {
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
        default = (config.shell.programs.eza.enable && config.shell.bash.enable);
      };
      zsh.enable = lib.mkOption {
        type = lib.types.bool;
        default = (config.shell.programs.eza.enable && config.shell.zsh.enable);
      };
    };
  };

  config = lib.mkIf config.shell.programs.eza.enable (lib.mkMerge [
    {
      home.packages = dependencies;

      home.file = {
        ".config/eza/theme.yml" = {
          source = ./sources/catppuccin.yml;
          executable = false;
          recursive = false;
        };
      };
    }
    (lib.mkIf config.shell.programs.eza.bash.enable {
      programs.bash.shellAliases = ezaAliases;
    })
    (lib.mkIf config.shell.programs.eza.zsh.enable {
      programs.zsh.shellAliases = ezaAliases;
    })
  ]);
}
