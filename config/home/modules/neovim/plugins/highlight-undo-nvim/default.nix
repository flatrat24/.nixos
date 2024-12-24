{ pkgs, lib, config, ... }: {
  options = {
    neovim.plugins.highlight-undo = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.enable;
      };
    };
  };

  config = lib.mkIf config.neovim.plugins.highlight-undo.enable (lib.mkMerge [
    {
      programs.nixvim = {
        extraPlugins = with pkgs.vimPlugins; [
          highlight-undo-nvim
        ];
        extraConfigLua = ''
          require('highlight-undo').setup({
            duration = 2000,
            keymaps = {
              Paste = {
                disabled = true,
              },
              paste = {
                disabled = true,
              },
              redo = {
                desc = "redo",
                hlgroup = 'HighlightRedo',
                mode = 'n',
                lhs = 'U',
                rhs = 'U',
                opts = {},
              },
            },
          })
        '';
      };
    }
    (lib.mkIf config.neovim.plugins.transparent.enable {
      programs.nixvim.extraConfigLua = ''
        vim.api.nvim_set_hl(0, "HighlightUndo", { fg = "#ACE1AD", bg = "#4D6256" })
        vim.api.nvim_set_hl(0, "HighlightRedo", { fg = "#ED96B3", bg = "#674458" })
      '';
    })
  ]);
}
