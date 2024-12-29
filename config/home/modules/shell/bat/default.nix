{ pkgs, lib, config, ... }:
let
  cfg = config.shell.programs.bat;
  dependencies = with pkgs; [
    bat
  ];
  aliases = {
    "cat" = "bat";
  };
in {
  options = {
    shell.programs.bat = {
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
        ".config/bat" = {
          source = ./sources;
          executable = false;
          recursive = true;
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
