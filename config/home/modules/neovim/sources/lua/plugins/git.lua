return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      vim.cmd("highlight SignColumn guibg=NONE")
      require('gitsigns').setup {
        signs = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        signcolumn = false,  -- Toggle with `:Gitsigns toggle_signs`
        numhl      = true, -- Toggle with `:Gitsigns toggle_numhl`
        linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          follow_files = true
        },
        auto_attach = true,
        attach_to_untracked = false,
        current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
          virt_text_priority = 100,
        },
        current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
        preview_config = {
          -- Options passed to nvim_open_win
          border = 'single',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
        on_attach = function(bufnr)
          local gitsigns = require('gitsigns')

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal({']h', bang = true})
            else
              gitsigns.nav_hunk('next')
            end
          end)

          map('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal({'[h', bang = true})
            else
              gitsigns.nav_hunk('prev')
            end
          end)

          -- Actions
          vim.keymap.set("n", "<leader>ghs", gitsigns.stage_hunk,                                                    { desc = "Stage Hunk"                })
          vim.keymap.set("n", "<leader>ghr", gitsigns.reset_hunk,                                                    { desc = "Reset Hunk"                })
          vim.keymap.set("v", "<leader>gha", function() gitsigns.stage_hunk{vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Stage Hunk"                })
          vim.keymap.set("v", "<leader>ghr", function() gitsigns.reset_hunk{vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Reset Hunk"                })
          vim.keymap.set("n", "<leader>ghu", gitsigns.undo_stage_hunk,                                               { desc = "Undo Stage Hunk"           })
          vim.keymap.set("n", "<leader>ghp", gitsigns.preview_hunk,                                                  { desc = "Preview Hunk"              })
          vim.keymap.set("n", "<leader>ghv", "<cmd>Gitsigns preview_hunk<CR>",                                       { desc = "Preview Hunk"              })
          vim.keymap.set("n", "<leader>ga",  gitsigns.stage_buffer,                                                  { desc = "Stage Current Buffer"      })
          vim.keymap.set("n", "<leader>gA",  "<cmd>Git restore --staged %<CR>",                                      { desc = "Unstage Current Buffer"    })
          vim.keymap.set("n", "<leader>gR",  gitsigns.reset_buffer,                                                  { desc = "Reset Current Buffer"      })
          vim.keymap.set("n", "<leader>gb",  function() gitsigns.blame_line{full=true} end,                          { desc = "Blame Preview"             })
          vim.keymap.set("n", "<leader>gB",  gitsigns.toggle_current_line_blame,                                     { desc = "Toggle Current Line Blame" })
          vim.keymap.set("n", "<leader>gd",  gitsigns.toggle_deleted,                                                { desc = "Toggle Deleted View"       })
          vim.keymap.set("n", "<leader>gD",  gitsigns.diffthis,                                                      { desc = "Preview Buffer Diff"       })
          vim.keymap.set("n", "<leader>gc",  "<cmd>Git commit<CR>",                                                  { desc = "Unstage Current Buffer"    })
          vim.keymap.set("n", "<leader>gz",  "<cmd>LazyGit<CR>",                                                     { desc = "Open LazyGit"              })

          -- Text object
          map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
      }
    end
  },
  {
    "tpope/vim-fugitive",
    cmd = {
      "Git",
      "G",
    },
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  }
}
