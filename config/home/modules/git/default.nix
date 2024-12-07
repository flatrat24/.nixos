{ pkgs, lib, config, ... }:
let
  gitAliases = {
    g    = "git"                                      ;
    ga   = "git add"                                  ;
    gs   = "git status"                               ;
    gd   = "git diff"                                 ;
    gc   = "git commit -m"                            ;
    gb   = "git branch"                               ;
    go   = "git checkout"                             ;
    gp   = "git push"                                 ;
    gm   = "git merge"                                ;
    gf   = "git fetch"                                ;
    gz   = "lazygit"                                  ;
  };
in {
  # TODO: add nested option for lazygit
  options = {
    git.enable = lib.mkEnableOption "enables git";
  };

  config = lib.mkIf config.git.enable (lib.mkMerge [
    {
      programs.bash.shellAliases = gitAliases;
      programs.zsh.shellAliases = gitAliases;

      programs.lazygit.enable = true;

      programs.git = {
        enable = true;
        userName = "Ethan Anthony";
        userEmail = "ethan.anthony@du.edu";
        delta.enable = true;
        extraConfig = {
          init.defaultBranch = "main";
        };
      };

      home.packages = with pkgs; [
        git
        lazygit
        delta
      ];
    }
    (lib.mkIf config.theme.enable {
      stylix.targets = {
        lazygit.enable = false;
      };
    })
  ]);
}
