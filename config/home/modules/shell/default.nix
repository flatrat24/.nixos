{ pkgs, lib, config, ... }:
let
  aliases = {
    "sudo" = "sudo "                                        ;

    ".."   = "cd .."                                        ;
                                                          
    "z"    = "zellij"                                       ;
    "za"   = "zellij attach"                                ;
    "zd"   = "zellij delete-session"                        ;
    "zD"   = "zellij delete-all-sessions"                   ;
    "zk"   = "zellij kill-session"                          ;
    "zK"   = "zellij kill-all-sessions"                     ;
    "zp"   = "zellij list-aliases"                          ;
    "zl"   = "zellij list-sessions"                         ;
    "zr"   = "zellij run"                                   ;
                                                          
    "p"    = "python3"                                      ;
    "h"    = "fc -ln 1 | fzf | wl-copy"                     ;
    "v"    = "nvim"                                         ;
    "c"    = "clear"                                        ;
    "q"    = "exit"                                         ;
    "d"    = "yazi"                                         ;
    "n"    = "ncmpcpp"                                      ;
    "y"    = "hyprland"                                     ;
    "f"    = "fzf --preview 'bat --color=always {}'"        ;
                                                          
    "tt"   = "sh ~/.config/hypr/scripts/toggleTouchpad.sh"  ;

    "nr"   = "nixos-rebuild switch --flake /home/ea/.nixos" ;
  };
  dependencies = with pkgs; [
    fd
    gping
    delta
    ripgrep
    zoxide
    fzf
    delta
    jq
    bottom
    wget
    croc

    python3
  ];
in {
  imports = [
    ./eza/default.nix
    ./bat/default.nix
    ./utils/default.nix
    ./cosmetics/default.nix
  ];

  options = {
    shell = {
      enable = lib.mkEnableOption "enables shell";
      bash.enable = lib.mkOption {
        type = lib.types.bool;
        default = config.shell.enable;
      };
      zsh.enable = lib.mkOption {
        type = lib.types.bool;
        default = config.shell.enable;
      };
    };
  };

  config = lib.mkIf config.shell.enable {
    home.packages = dependencies;

    programs.bash = {
      enable = true;
      shellAliases = aliases;
      historySize = 5000;
      historyFile = "$HOME/.bash_history";
    };

    programs.zsh = {
      enable = true;
      shellAliases = aliases;
      history = {
        save = 5000;
        size = 5000;
        path = "$HOME/.zsh_history";
        share = true;
        ignoreDups = true;
        ignoreSpace = true;
        ignoreAllDups = true;
      };
      enableCompletion = true;
      autosuggestion = {
        enable = true;
      };
      syntaxHighlighting = {
        enable = true;
      };
      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "powerlevel10k-config";
          src = ./sources;
          file = "p10k.zsh";
        }
      ];
      dotDir = ".config/zsh";
      initExtra = ''
        source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh

        bindkey '^f' autosuggest-accept
        bindkey '^k' history-search-backward
        bindkey '^j' history-search-forward
        bindkey '^[w' kill-region

        eval "$(fzf --zsh)"
        eval "$(zoxide init --cmd cd zsh)"
      '';
    };
  };
}
