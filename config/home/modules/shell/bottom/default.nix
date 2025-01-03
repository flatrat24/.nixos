{ pkgs, lib, config, ... }:
let
  cfg = config.shell.programs.bottom;
  dependencies = with pkgs; [
    bottom
  ];
  aliases = {
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
      programs.bash.shellAliases = aliases;
    })
    (lib.mkIf cfg.zsh.enable {
      programs.zsh.shellAliases = aliases;
    })
    (lib.mkIf config.hyprland.enable {
      wayland.windowManager.hyprland.settings = {
        bindd = [
          "$mod, b, Open System Monitor, exec, foot --title=SYSMONITOR -e btm"
        ];
        windowrulev2 = [
          "float,title:SYSMONITOR"
          "size 75% 75%,title:SYSMONITOR"
          "center 1,title:SYSMONITOR"
        ];
      };
    })
  ]);
}
