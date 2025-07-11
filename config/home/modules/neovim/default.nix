{ lib, config, inputs, ... }:
let
  cfg = config.neovim;
  aliases = {
    "v" = "nvim";
    "vt" = "v $(mktemp)";
  };
in {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./keymaps
    ./plugins
    ./lsp
    ./cmp
  ];

  options = {
    neovim = {
      enable = lib.mkEnableOption "enables neovim";
      nixvim.enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home = {
        sessionVariables = {
          EDITOR = lib.mkDefault "nvim";
          VISUAL = lib.mkDefault "nvim";
        };
      };

      programs.neovim = {
        defaultEditor = true;
      };

      programs.bash.shellAliases = aliases;
      programs.zsh.shellAliases = aliases;

      xdg = {
        enable = lib.mkDefault true;
        mimeApps.enable = lib.mkDefault true;
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
    (lib.mkIf cfg.nixvim.enable {
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
          spell = lib.mkDefault true;
          spelllang = lib.mkDefault [ "en_us" ];

          ##--- Folding ---##
          foldmethod = "expr";
          foldexpr = "nvim_treesitter#foldexpr()";
          foldenable = true;
          foldcolumn = "0";
          foldtext = "";
          foldlevelstart = 2;
          foldnestmax = 99;
          foldlevel = 99;
        };
        # colorschemes = {
        #   catppuccin.enable = true;
        # };
      };
    })
    (lib.mkIf config.yazi.enable {
      programs.yazi.settings.opener = {
        edit = [
          { run = ''nvim "$@"''; block = true; desc = " neovim"; }
        ];
        directory = [
          { run = ''nvim "$@"''; block = true; desc = " neovim"; }
        ];
      };
    })
  ]);
}
