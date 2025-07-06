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

    wireguard-tools

    (pkgs.python39.withPackages (ps: with ps; [
      pygments # For latex minted package
    ]))

    starship
  ];
in {
  imports = [
    ./bat/default.nix
    ./bottom/default.nix
    ./cosmetics/default.nix
    ./croc/default.nix
    ./eza/default.nix
    ./fd/default.nix
    ./fzf/default.nix
    ./glow/default.nix
    ./gping/default.nix
    ./json/default.nix
    ./qrcp/default.nix
    ./ripgrep/default.nix
    ./utils/default.nix
    ./zoxide/default.nix
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
          name = "vi-mode";
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
        # {
        #   name = "zsh-transient-prompt";
        #   file = "transient-prompt.plugin.zsh";
        #   src = pkgs.fetchFromGitHub {
        #     owner = "olets";
        #     repo = "zsh-transient-prompt";
        #     rev = "v1.0.1";
        #     hash = "sha256-6DTWKf15mPvNGkgWyjT178MggfucKxUlJ6hr53L0QPo=";
        #   };
        # }
      ];
      dotDir = ".config/zsh";
      initExtra = builtins.readFile ./sources/extra.zsh;
    };

    home.file = {
      ".config/starship.toml" = {
        source = ./sources/starship.toml;
        executable = false;
        recursive = false;
      };
    };
  };
}
