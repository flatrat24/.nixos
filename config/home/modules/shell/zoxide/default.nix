{ pkgs, lib, config, ... }:
let
  cfg = config.shell.programs.zoxide;
  dependencies = with pkgs; [
    zoxide
  ];
  zoxideAliases = { };
in {
  options = {
    shell.programs.zoxide = {
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
    { home.packages = dependencies; }
    (lib.mkIf cfg.bash.enable {
      programs.bash.shellAliases = zoxideAliases;
    })
    (lib.mkIf cfg.zsh.enable {
      programs.zsh.shellAliases = zoxideAliases;
      programs.zsh = {
        initExtra = ''
          eval "$(zoxide init --cmd cd zsh)"
        '';
      };
    })
  ]);
}
