{ pkgs, lib, config, ... }:
let
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
        default = (config.shell.programs.zoxide.enable && config.shell.bash.enable);
      };
      zsh.enable = lib.mkOption {
        type = lib.types.bool;
        default = (config.shell.programs.zoxide.enable && config.shell.zsh.enable);
      };
    };
  };

  config = lib.mkIf config.shell.programs.zoxide.enable (lib.mkMerge [
    { home.packages = dependencies; }
    (lib.mkIf config.shell.programs.zoxide.bash.enable {
      programs.bash.shellAliases = zoxideAliases;
    })
    (lib.mkIf config.shell.programs.zoxide.zsh.enable {
      programs.zsh.shellAliases = zoxideAliases;
      programs.zsh = {
        initExtra = ''
          eval "$(zoxide init --cmd cd zsh)"
        '';
      };
    })
  ]);
}
