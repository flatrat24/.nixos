{ pkgs, lib, config, ... }:
let
  zellijAliases = {
    "z"  = "zellij";
    "za" = "zellij attach";
    "zd" = "zellij delete-session";
    "zD" = "zellij delete-all-sessions";
    "zk" = "zellij kill-session";
    "zK" = "zellij kill-all-sessions";
    "zp" = "zellij list-aliases";
    "zl" = "zellij list-sessions";
    "zr" = "zellij run";
  };
  dependencies = with pkgs; [
    zellij
  ];
in {
  options = {
    zellij.enable = lib.mkEnableOption "enables zellij";
  };

  config = lib.mkIf config.zellij.enable (lib.mkMerge [
    {
      programs.bash.shellAliases = zellijAliases;
      programs.zsh.shellAliases = zellijAliases;

      home.packages = dependencies;

      home.file = {
        ".config/zellij" = {
          source = ./sources;
          executable = false;
          recursive = true;
        };
      };
    }
  ]);
}
