{ pkgs, lib, config, ... }:
let
  cfg = config.git;
  aliases = {
    g    = "git"                                      ;
    gz   = "lazygit"                                  ;
    # ga   = "git add"                                  ;
    # gs   = "git status"                               ;
    # gd   = "git diff"                                 ;
    # gc   = "git commit -m"                            ;
    # gb   = "git branch"                               ;
    # go   = "git checkout"                             ;
    # gP   = "git push"                                 ;
    # gp   = "git pull"                                 ;
    # gm   = "git merge"                                ;
    # gf   = "git fetch"                                ;
  };
in {
  options = {
    git = {
      enable = lib.mkEnableOption "enables git";
      lazygit.enable = lib.mkOption {
        type = lib.types.bool;
        default = config.git.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      programs.bash.shellAliases = aliases;
      programs.zsh.shellAliases = aliases;

      programs.git = {
        enable = true;
        userName = "Ethan Anthony";
        userEmail = "ethananthony@worldofmail.com";
        delta.enable = true;
        extraConfig = {
          init.defaultBranch = "main";
        };
      };

      home.packages = with pkgs; [
        git
        delta
      ];
    }
    (lib.mkIf cfg.lazygit.enable {
      programs.lazygit.enable = true;
    })
    (lib.mkIf config.theme.enable {
      stylix.targets = {
        lazygit.enable = false;
      };
    })
  ]);
}
