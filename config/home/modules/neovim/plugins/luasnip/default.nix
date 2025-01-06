{ lib, config, ... }:
let
  cfg = config.neovim.plugins.luasnip;
in {
  options = {
    neovim.plugins.luasnip = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.neovim.nixvim.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.file = {
        ".config/nvim/snippets" = {
          source = ./sources/snippets;
          executable = false;
          recursive = true;
        };
      };

      programs.nixvim = {
        plugins.luasnip = {
          enable = true;
          fromLua = [
            { paths = "${config.xdg.configHome}/nvim/snippets"; }
          ];
          settings = {
            enable_autosnippets = true;
            update_events = [
              "TextChanged"
              "TextChangedI"
            ];
          };
        };
        extraConfigLua = ''
          vim.keymap.set({ "i", "s" }, "<c-l>", function()
            if require("luasnip").jumpable(1) then
              require("luasnip").jump(1)
            end
          end,                                                                                { noremap = true, silent = true,            desc = "expand or jump within snippet"       })
          vim.keymap.set({ "i", "s" }, "<c-h>", function()
            if require("luasnip").jumpable(-1) then
              require("luasnip").jump(-1)
            end
          end,                                                                                { noremap = true, silent = true,            desc = "Jump Back Within Snippet"            })
          vim.keymap.set({ "i", "s" }, "<c-s-l>", function()
            if require("luasnip").choice_active() then
              require("luasnip").change_choice(1)
            end
          end,                                                                                { noremap = true, silent = true,            desc = "Change Choice Within Snippet"        })
          vim.keymap.set({ "i", "s" }, "<c-s-h>", function()
            if require("luasnip").choice_active() then
              require("luasnip").change_choice(-1)
            end
          end,                                                                                { noremap = true, silent = true,            desc = "Change Choice Within Snippet"        })
        '';
      };
    }
    (lib.mkIf config.neovim.plugins.cmp.enable {
      programs.nixvim = {
        plugins.cmp.settings.sources = [
          {
            name = "luasnip";
            option = { show_autosnippets = false; };
          }
        ];
      };
    })
  ]);
}
