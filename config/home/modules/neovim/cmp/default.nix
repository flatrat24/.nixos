{ lib, config, helpers, ... }: {
  options = {
    neovim.plugins.cmp = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.enable;
      };
    };
  };

  config = lib.mkIf config.neovim.plugins.cmp.enable (lib.mkMerge [
    {
      programs.nixvim = {
        plugins.cmp = {
          enable = true;
          autoEnableSources = true;
          settings = {
            sources = [
              { name = "nvim_lsp"; }
              { name = "path"; }
              { name = "buffer"; keyword_length = 5; }
              { name = "calc"; }
            ];
            view = {
              entries = "custom";
              selection_order = "near_cursor";
            };
            window = {
              completion = {
                border = "rounded";
              };
              documentation = {
                border = "rounded";
              };
            };
            mapping = {
              "<C-Space>" = "cmp.mapping.complete()";
              "<C-d>" = "cmp.mapping.scroll_docs(4)";
              "<C-u>" = "cmp.mapping.scroll_docs(-4)";
              "<C-f>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
              "<C-j>" =
                ''
                function(fallback)
                  if cmp.visible() then
                    cmp.select_next_item()
                  elseif require("luasnip").expand_or_jumpable() then
                    require("luasnip").expand_or_jump()
                  else
                    fallback()
                  end
                end
                '';
                "<C-k>" =
                ''
                function(fallback)
                  if cmp.visible() then
                    cmp.select_prev_item()
                  elseif require("luasnip").expand_or_jumpable() then
                    require("luasnip").expand_or_jump()
                  else
                    fallback()
                  end
                end
                '';
            };
          };
        };
      };
    }
  ]);
}
