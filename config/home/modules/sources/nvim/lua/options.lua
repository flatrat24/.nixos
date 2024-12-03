-- BASIC VIM OPTIONS
vim.cmd("set expandtab")
vim.cmd("set nu")
vim.cmd("set numberwidth=1")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set nowrap")
vim.cmd("set scrolloff=10")
vim.cmd("set sidescrolloff=5")
vim.cmd("set colorcolumn=90")
vim.cmd("set ignorecase")
vim.cmd("set smartcase")
vim.cmd("set cursorline")
vim.cmd("set formatoptions=jql")

-- CODE FOLDING SETTINGS
vim.cmd("set foldcolumn=1")
vim.cmd("set foldlevel=20")
vim.cmd("set foldmethod=expr")
vim.cmd("set foldexpr=nvim_treesitter#foldexpr()")
vim.cmd("set foldcolumn=0")
vim.cmd("set foldtext")

-- CLIPBOARD INTEGRATION
-- vim.cmd("set clipboard=unnamedplus")
