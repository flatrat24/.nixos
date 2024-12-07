{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    bat
  ];
  batAliases = {
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
        default = (config.shell.programs.bat.enable && config.shell.bash.enable);
      };
      zsh.enable = lib.mkOption {
        type = lib.types.bool;
        default = (config.shell.programs.bat.enable && config.shell.zsh.enable);
      };
    };
  };

  config = lib.mkIf config.shell.programs.bat.enable (lib.mkMerge [
    {
      home.packages = dependencies;

      home.file = {
        ".config/bat" = {
          source = ./sources/;
          executable = false;
          recursive = true;
        };
      };
    }
    (lib.mkIf config.shell.programs.bat.bash.enable {
      programs.bash.shellAliases = batAliases;
    })
    (lib.mkIf config.shell.programs.bat.zsh.enable {
      programs.zsh.shellAliases = batAliases;
    })
  ]);
}
