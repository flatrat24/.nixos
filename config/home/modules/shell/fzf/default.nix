{ pkgs, lib, config, ... }:
let
  dependencies = with pkgs; [
    fzf
  ];
  fzfAliases = lib.mkMerge [
    {
      "fh" = "fc -ln 1 | fzf | wl-copy"; # TODO: make the copy util universal, not just wl-copy
    }
    (lib.mkIf config.neovim.enable {
      "fv" = "nvim $(ff)"
    })
    (lib.mkMerge [
      (lib.mkIf config.shell.programs.bat.enable {
        "ff" = "fzf --preview 'bat --color=always {}'";
      })
      (lib.mkIf !config.shell.programs.bat.enable {
        "ff" = "echo 'bat is not enabled'";
      })
    ])
  ];
in {
  options = {
    shell.programs.fzf = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.shell.enable;
      };
      bash.enable = lib.mkOption {
        type = lib.types.bool;
        default = (config.shell.programs.fzf.enable && config.shell.bash.enable);
      };
      zsh.enable = lib.mkOption {
        type = lib.types.bool;
        default = (config.shell.programs.fzf.enable && config.shell.zsh.enable);
      };
    };
  };

  config = lib.mkIf config.shell.programs.fzf.enable (lib.mkMerge [
    { home.packages = dependencies; }
    (lib.mkIf config.shell.programs.fzf.bash.enable {
      programs.bash.shellAliases = fzfAliases;
    })
    (lib.mkIf config.shell.programs.fzf.zsh.enable {
      programs.zsh.shellAliases = fzfAliases;
      programs.zsh = {
        initExtra = ''
          eval "$(fzf --zsh)"
        '';
      };
    })
  ]);
}
