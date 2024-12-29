{ pkgs, lib, config, ... }:
let
  cfg = config.shell.programs.bottom;
  dependencies = with pkgs; [
    bottom
  ];
  bottomAliases = {
    "b" = "btm";
  };
in {
  options = {
    shell.programs.bottom = {
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
        ".config/bottom/bottom.toml" = {
          source = ./sources/bottom.toml;
          executable = false;
          recursive = false;
        };
      };
    }
    (lib.mkIf cfg.bash.enable {
      programs.bash.shellAliases = bottomAliases;
    })
    (lib.mkIf cfg.zsh.enable {
      programs.zsh.shellAliases = bottomAliases;
    })
  ]);
}
