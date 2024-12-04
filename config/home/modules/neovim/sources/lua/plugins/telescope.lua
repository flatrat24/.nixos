return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    tag = "0.1.6",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      -- local builtin = require("telescope.builtin")
      require('telescope').setup{
        defaults = {
          mappings = {
            i = {
              ["<C-k>"] = "move_selection_previous",
              ["<C-j>"] = "move_selection_next",
              ["<C-q>"] = "close",
              ["<CR>"]  = "select_default",
              ["<C-m>"] = "select_vertical",
              ["<C-n>"] = "select_horizontal",
              ["<C-t>"] = "select_tab",
            }
          }
        }
      }
    end
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {}
          }
        }
      })
      require("telescope").load_extension("ui-select")
    end
  },
  -- {
  --   "nvim-telescope/telescope-file-browser.nvim",
  --   dependencies = {
  --     "nvim-telescope/telescope.nvim",
  --     "nvim-lua/plenary.nvim"
  --   },
  --   config = function()
  --     local fb_actions = require "telescope._extensions.file_browser.actions"
  --     require.("telescope").setup {
  --       mappings = {
  --         ["i"] = {
  --           ["<C-a>"]  = fb_actions.create,
  --           ["<S-CR>"] = fb_actions.create_from_prompt,
  --           ["<C-r>"]  = fb_actions.rename,
  --           ["<C-x>"]  = fb_actions.move,
  --           ["<C-y>"]  = fb_actions.copy,
  --           ["<C-d>"]  = fb_actions.remove,
  --           ["<C-o>"]  = fb_actions.open,
  --           ["<C-h>"]  = fb_actions.goto_parent_dir,
  --           ["<C-H>"]  = fb_actions.goto_home_dir,
  --           ["<C-L>"]  = fb_actions.goto_cwd,
  --           ["<C-CR>"] = fb_actions.change_cwd,
  --           ["<C-f>"]  = fb_actions.toggle_browser,
  --           ["<C-.>"]  = fb_actions.toggle_hidden,
  --           ["<C-s>"]  = fb_actions.toggle_all,
  --           ["<bs>"]   = fb_actions.backspace,
  --         },
  --         ["n"] = {
  --           ["a"]  = fb_actions.create,
  --           ["r"]  = fb_actions.rename,
  --           ["x"]  = fb_actions.move,
  --           ["y"]  = fb_actions.copy,
  --           ["d"]  = fb_actions.remove,
  --           ["o"]  = fb_actions.open,
  --           ["h"]  = fb_actions.goto_parent_dir,
  --           ["H"]  = fb_actions.goto_home_dir,
  --           ["L"]  = fb_actions.goto_cwd,
  --           ["CR"] = fb_actions.change_cwd,
  --           ["f"]  = fb_actions.toggle_browser,
  --           ["."]  = fb_actions.toggle_hidden,
  --           ["s"]  = fb_actions.toggle_all,
  --         },
  --       },
  --     require("telescope").load_extension("file_browser")
  --     }
  --   end
  -- },
}
