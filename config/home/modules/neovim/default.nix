{ pkgs, lib, config, inputs, ... }:
let
  neovimAliases = {
    "v" = "nvim";
  };
  dependencies = with pkgs; [
    neovim
    python3
    luajitPackages.luarocks
    luajitPackages.jsregexp
    clang
    tree-sitter
    nodejs_22
    python312Packages.python-lsp-server
    nodePackages_latest.bash-language-server
  ];
in {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    # ./git.nix
    # ./yazi.nix
    # ./fonts.nix
    ./keymaps/default.nix
    ./plugins/default.nix
  ];

  options = {
    neovim = {
      enable = lib.mkEnableOption "enables neovim";
      nixvim.enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.enable;
      };
      lua.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };
  };

  config = lib.mkIf config.neovim.enable (lib.mkMerge [
    {
      programs.bash.shellAliases = neovimAliases;
      programs.zsh.shellAliases = neovimAliases;
    }
    (lib.mkIf config.neovim.lua.enable {
      home.packages = dependencies;

      home.file = {
        ".config/nvim" = {
          source = ./sources;
          executable = false;
          recursive = true;
        };
      };
    })
    (lib.mkIf config.neovim.nixvim.enable {
      programs.nixvim = {
        enable = true;
        opts = {
          expandtab = true;
          number = true;
          numberwidth = 1;
          tabstop = 2;
          softtabstop = 2;
          shiftwidth = 2;
          wrap = false;
          scrolloff = 10;
          sidescrolloff = 5;
          ignorecase = true;
          smartcase = true;
          cursorline = true;
          formatoptions = "jql";
        };
        colorschemes = {
          catppuccin.enable = true;
        };
        plugins.lualine.enable = true;
      };
    })
    {
      xdg = { # TODO: Fix desktop entry, doesn't work
        enable = true;
        mimeApps.enable = true;
        mimeApps.defaultApplications = {
          "text/*" = ["nvim.desktop"];
        };
        desktopEntries = {
          nvim = {
            name = "Neovim";
            genericName = "Text Editor";
            exec = ''foot -e nvim %f''; # remove hardcoded foot
            # exec = "nvim %F";
            terminal = false;
            categories = [ "Utility" "TextEditor" ];
            mimeType = [ "text/english" "text/plain" "text/x-makefile" "text/x-c++hdr" "text/x-c++src" "text/x-chdr" "text/x-csrc" "text/x-java" "text/x-moc" "text/x-pascal" "text/x-tcl" "text/x-tex" "application/x-shellscript" "text/x-c" "text/x-c++" "text/x-python" ];
          };
        };
      };
    }
  ]);
}
