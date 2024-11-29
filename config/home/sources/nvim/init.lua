local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

function reqs()
  require("options")
  require("keymaps")
  require("lazy").setup("plugins")
end

reqs()

require("luasnip.loaders.from_lua").load({
  paths = "~/.config/nvim/snippets/",
  enable_autosnippets = true,
  store_selection_keys = "<c-k>",
})

-- vim.keymap.del("i", "]]")
vim.keymap.del("n", "<CR>")

vim.filetype.add({
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})
