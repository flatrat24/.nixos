{ pkgs, lib, config, ... }:
let
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
        default = (config.shell.programs.bottom.enable && config.shell.bash.enable);
      };
      zsh.enable = lib.mkOption {
        type = lib.types.bool;
        default = (config.shell.programs.bottom.enable && config.shell.zsh.enable);
      };
    };
  };

  config = lib.mkIf config.shell.programs.bottom.enable (lib.mkMerge [
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
    (lib.mkIf config.shell.programs.bottom.bash.enable {
      programs.bash.shellAliases = bottomAliases;
    })
    (lib.mkIf config.shell.programs.bottom.zsh.enable {
      programs.zsh.shellAliases = bottomAliases;
    })
  ]);
}
