{ pkgs, lib, config, ... }:
let
  cfg = config.shell;
  aliases = {
    "sudo" = "sudo "                                                                       ;
    ".."   = "cd .."                                                                       ;
    "c"    = "clear"                                                                       ;
    "q"    = "exit"                                                                        ;
    "open" = "xdg-open"                                                                    ;

    "nr"   = "nixos-rebuild switch --flake /home/ea/.nixos"                                ;
    "ns"   = "nix-shell -p --command $SHELL "                                              ;
    # "nd"   = "nix-collect-garbage -d && nix-store --gc && nix-env --delete-old-generations" ;

    "p"    = "python3"                                                                     ;
  };
  dependencies = with pkgs; [
    delta # TODO: Get this working as a submodule
    gnumake

    (pkgs.python39.withPackages (ps: with ps; [
      pygments # For latex minted package
    ]))
  ];
in {
  imports = [
    ./eza/default.nix
    ./bat/default.nix
    ./json/default.nix
    ./fd/default.nix
    ./fzf/default.nix
    ./gping/default.nix
    ./ripgrep/default.nix
    ./bottom/default.nix
    ./zoxide/default.nix
    ./utils/default.nix
    ./cosmetics/default.nix
    ./croc/default.nix
    ./qrcp/default.nix
  ];

  options = {
    shell = {
      enable = lib.mkEnableOption "enables shell";
      bash.enable = lib.mkOption {
        type = lib.types.bool;
        default = cfg.enable;
      };
      zsh.enable = lib.mkOption {
        type = lib.types.bool;
        default = cfg.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable {
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
        # {
        #   name = "vi-mode";
        #   src = pkgs.zsh-vi-mode;
        #   file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        # }
      ];
      dotDir = ".config/zsh";
      initExtra = ''
        bindkey '^f' autosuggest-accept
        bindkey '^k' history-search-backward
        bindkey '^j' history-search-forward
        bindkey '^[w' kill-region
        bindkey -v
      '';
    };
  };
}
