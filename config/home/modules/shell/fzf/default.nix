{ pkgs, lib, config, ... }:
let
  cfg = config.shell.programs.fzf;
  dependencies = with pkgs; [
    fzf
  ];
  fzfAliases = lib.mkMerge [
    {
      "fh" = "fc -ln 1 | fzf | wl-copy";
    }
    (lib.mkIf config.neovim.enable {
      "fv" = "nvim $(ff)";
    })
    (lib.mkMerge [
      (lib.mkIf (config.shell.programs.bat.enable) {
        "ff" = "fzf --preview 'bat --color=always {}'";
      })
      (lib.mkIf (!config.shell.programs.bat.enable) {
        "ff" = "echo 'bat is not enabled'";
      })
    ])
  ];
  fzf-tab = {
    name = "fzf-tab";
    src = pkgs.fetchFromGitHub {
      "owner" = "aloxaf";
      "repo"  = "fzf-tab";
      "rev"   = "6aced3f35def61c5edf9d790e945e8bb4fe7b305";
      "hash"  = "sha256-EWMeslDgs/DWVaDdI9oAS46hfZtp4LHTRY8TclKTNK8=";
    };
  };
in {
  options = {
    shell.programs.fzf = {
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
    (lib.mkIf config.theme.enable {
      stylix.targets = {
        fzf.enable = true;
      };
    })
    (lib.mkIf cfg.bash.enable {
      programs.bash.shellAliases = fzfAliases;
    })
    (lib.mkIf cfg.zsh.enable (lib.mkMerge [
      {
        programs.zsh = {
          shellAliases = fzfAliases;
          plugins = [
            fzf-tab
          ];
        };
      }
      (lib.mkMerge [
        (lib.mkIf (config.shell.programs.eza.enable) {
          programs.zsh.initExtra = ''
            zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
          '';
        })
        (lib.mkIf (!config.shell.programs.eza.enable) {
          programs.zsh.initExtra = ''
            zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls $realpath'
          '';
        })
      ])
    ]))
  ]);
}
