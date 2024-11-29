return {
  "goolord/alpha-nvim",
  config = function ()
    local alpha = require'alpha'
    local dashboard = require'alpha.themes.dashboard'
    dashboard.section.header.val = {
      [[                                                    ]],
      [[                                                    ]],
      [[                                                    ]],
      [[                                                    ]],
      [[                                                    ]],
      [[                                                    ]],
      [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
      [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
      [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
      [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
      [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
      [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
      [[                                                    ]],
    }
    dashboard.section.buttons.val = {
      dashboard.button("n", "  New file", "<cmd>ene<CR>"),
      dashboard.button("d", "  File Manager", "<cmd>cd ~/ | Yazi<CR>"),
      dashboard.button("f", "󰈞  Find file", "<cmd>cd ~/ | Telescope find_files<CR>"),
      dashboard.button("g", "󰊄  Live grep", "<cmd>cd ~/Documents | Telescope live_grep<CR>"),
      dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
      dashboard.button("s", "  School", "<cmd>cd ~/Documents/School/ | Yazi<CR>"),
      dashboard.button("p", "  Personal", "<cmd>cd ~/Documents/Personal/ | Yazi<CR>"),
      dashboard.button("c", "  Configuration", "<cmd>cd ~/.dotfiles/ | Yazi<CR>"),
      dashboard.button("u", "  Update plugins", "<cmd>Lazy sync<CR>"),
      dashboard.button("q", "󰅚  Quit", "<cmd>qa<CR>"),
    }
    local handle = io.popen('fortune')
    local fortune = handle:read("*a")
    handle:close()
    dashboard.section.footer.val = fortune

    dashboard.config.opts.noautocmd = true

    vim.cmd[[autocmd User AlphaReady echo 'ready']]

    alpha.setup(dashboard.config)
  end
}
