return {
  'numToStr/Comment.nvim',
  opts = {
    padding = true,
    sticky = true,
    ignore = nil,
    toggler = {
      line = '<leader>cc',
      block = '<leader>bc',
    },
    opleader = {
      line = '<leader>c',
      block = '<leader>b',
    },
    extra = {
      above = '<leader>cO',
      below = '<leader>co',
      eol = '<leader>cA',
    },
    mappings = {
      basic = true,
      extra = true,
    },
    pre_hook = nil,
    post_hook = nil,
  }
}
