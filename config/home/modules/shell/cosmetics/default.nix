{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    typioca
    cowsay
    fortune
    figlet
    pipes
    cbonsai
  ];
  cosmeticsAliases = { };
in {
  options = {
    shell.programs.cosmetics = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.shell.enable;
      };
      bash.enable = lib.mkOption {
        type = lib.types.bool;
        default = (config.shell.programs.cosmetics.enable && config.shell.bash.enable);
      };
      zsh.enable = lib.mkOption {
        type = lib.types.bool;
        default = (config.shell.programs.cosmetics.enable && config.shell.zsh.enable);
      };
    };
  };

  config = lib.mkIf config.shell.programs.cosmetics.enable (lib.mkMerge [
    { home.packages = dependencies; }
    (lib.mkIf config.shell.programs.cosmetics.bash.enable {
      programs.bash.shellAliases = cosmeticsAliases;
    })
    (lib.mkIf config.shell.programs.cosmetics.zsh.enable {
      programs.zsh.shellAliases = cosmeticsAliases;
    })
  ]);
}
