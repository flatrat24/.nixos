{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    jq
  ];
  jsonAliases = { };
in {
  options = {
    shell.programs.json = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.shell.enable;
      };
      bash.enable = lib.mkOption {
        type = lib.types.bool;
        default = (config.shell.programs.json.enable && config.shell.bash.enable);
      };
      zsh.enable = lib.mkOption {
        type = lib.types.bool;
        default = (config.shell.programs.json.enable && config.shell.zsh.enable);
      };
    };
  };

  config = lib.mkIf config.shell.programs.json.enable (lib.mkMerge [
    { home.packages = dependencies; }
    (lib.mkIf config.shell.programs.json.bash.enable {
      programs.bash.shellAliases = jsonAliases;
    })
    (lib.mkIf config.shell.programs.json.zsh.enable {
      programs.zsh.shellAliases = jsonAliases;
    })
  ]);
}
