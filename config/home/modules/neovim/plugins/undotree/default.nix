{ lib, config, ... }: {
  options = {
    neovim.plugins.undotree = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.enable;
      };
    };
  };

  config = lib.mkIf config.neovim.plugins.undotree.enable (lib.mkMerge [
    {
      programs.nixvim = {
        plugins.undotree = {
          enable = true;
          settings = {
            CursorLine = true;
            DiffAutoOpen = true;
            DiffCommand = "diff";
            DiffpanelHeight = 10;
            HelpLine = true;
            HighlightChangedText = true;
            HighlightChangedWithSign = true;
            HighlightSyntaxAdd = "DiffAdd";
            HighlightSyntaxChange = "DiffChange";
            HighlightSyntaxDel = "DiffDelete";
            RelativeTimestamp = true;
            SetFocusWhenToggle = true;
            ShortIndicators = false;
            SplitWidth = 40;
            TreeNodeShape = "*";
            TreeReturnShape = "\\";
            TreeSplitShape = "/";
            TreeVertShape = "|";
            WindowLayout = 3;
          };
        };
        keymaps = [
          { mode = [ "n" ]; key = "<leader>vu"; action = "<cmd>UndotreeToggle<CR><cmd>UndotreeFocus<CR>"; options = { noremap = true; silent = true; desc = "Toggle Undotree View"; }; }
        ];
      };
    }
  ]);
}
