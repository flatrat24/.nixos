{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.rss;
  dependencies = with pkgs; [ goread ];
  aliases = {
    "rss" = "goread";
  };
in {
  options = {
    rss.enable = lib.mkEnableOption "enable rss";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = dependencies;
      home.file = {
        ".config/goread/urls.yml" = {
        source = ./sources/urls.yml;
        executable = false;
        recursive = false;
        };
      };
      programs.bash.shellAliases = aliases;
      programs.zsh.shellAliases = aliases;
    }
    (lib.mkIf config.shell.bash.enable {
      programs.bash.shellAliases = aliases;
    })
    (lib.mkIf config.shell.zsh.enable {
      programs.zsh.shellAliases = aliases;
    })
  ]);
}
