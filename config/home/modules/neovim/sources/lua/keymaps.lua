--%%% KEYMAP SETTINGS %%%--
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--%%% NORMAL MODE %%%--
-- vim.keymap.del({"n", "x"}, "gcc")
-- vim.keymap.del({"n", "x"}, "gbc")
-- vim.keymap.del({"n", "x"}, "gc")
-- vim.keymap.del({"n", "x"}, "gb")
-- vim.keymap.del({"n", "x"}, "gcO")
-- vim.keymap.del({"n", "x"}, "gco")
-- vim.keymap.del({"n", "x"}, "gcA")

-- Miscellaneous
vim.keymap.set("n", "U",            "<C-r>",                                        { noremap = true, silent = true,            desc = "Redo"                                })
vim.keymap.set("n", "L",            "$",                                            { noremap = true, silent = true,            desc = "Go to End of Line"                   })
vim.keymap.set("n", "H",            "0",                                            { noremap = true, silent = true,            desc = "Go to Front of Line"                 })
vim.keymap.set("n", "<C-;>",        "<C-y>",                                        { noremap = true, silent = true,            desc = "Move Screen Up"                      })
vim.keymap.set("n", "<C-'>",        "<C-e>",                                        { noremap = true, silent = true,            desc = "Move Screen Down"                    })

vim.keymap.set("n", "<leader>`",    "<cmd>Alpha<CR>",                               { noremap = true, silent = true,            desc = "Return to Homepage"                  })
vim.keymap.set("n", "<leader>?",    "<cmd>WhichKey<CR>",                            { noremap = true, silent = true,            desc = "Display Keymaps"                     })
vim.keymap.set("n", "<leader>h",    "<cmd>Telescope help_tags hidden=true<CR>",     { noremap = true, silent = true,            desc = "Search Help Tags"                    })
vim.keymap.set("n", ",",            ";",                                            { noremap = true, silent = true,            desc = "Repeat Find in Line"                 })

-- View Management                  
vim.keymap.set("n", "<leader>vh",   "<cmd>nohl<CR>",                                { noremap = true, silent = true,            desc = "Clear Highlighting"                  })
vim.keymap.set("n", "<leader>vu",   "<cmd>UndotreeToggle<CR><cmd>UndotreeFocus<CR>",{ noremap = true, silent = true,            desc = "Toggle UndoTree"                     })

-- Window Management                
vim.keymap.set("n", "<C-h>",        "<C-w>h",                                       { noremap = true, silent = true,            desc = "Move Window Focus Left"              })
vim.keymap.set("n", "<C-j>",        "<C-w>j",                                       { noremap = true, silent = true,            desc = "Move Window Focus Down"              })
vim.keymap.set("n", "<C-k>",        "<C-w>k",                                       { noremap = true, silent = true,            desc = "Move Window Focus Up"                })
vim.keymap.set("n", "<C-l>",        "<C-w>l",                                       { noremap = true, silent = true,            desc = "Move Window Focus Right"             })
vim.keymap.set("n", "<C-m>",        "<C-w>v",                                       { noremap = true, silent = true,            desc = "Open Window Horizontally Split"      })
vim.keymap.set("n", "<C-n>",        "<C-w>s",                                       { noremap = true, silent = true,            desc = "Open Window Vertically Split"        })
vim.keymap.set("n", "<C-q>",        "<C-w>q",                                       { noremap = true, silent = true,            desc = "Close Focused Window"                })
vim.keymap.set("n", "<C-S-k>",      "<cmd>resize +2<CR>",                           { noremap = true, silent = true,            desc = "Horizontally Shrink Focused Window"  })
vim.keymap.set("n", "<C-S-j>",      "<cmd>resize -2<CR>",                           { noremap = true, silent = true,            desc = "Vertically Shrink Focused Window"    })
vim.keymap.set("n", "<C-S-h>",      "<cmd>vertical resize -2<CR>",                  { noremap = true, silent = true,            desc = "Horizontally Grow Focused Window"    })
vim.keymap.set("n", "<C-S-l>",      "<cmd>vertical resize +2<CR>",                  { noremap = true, silent = true,            desc = "Vertically Grow Focused Window"      })

-- Buffer Management                        
vim.keymap.set("n", "<leader>ff",   "<cmd>Telescope find_files hidden=true<CR>",    { noremap = true, silent = true,            desc = "Find Files"                          })
vim.keymap.set("n", "<leader>fg",   "<cmd>Telescope live_grep hidden=true<CR>",     { noremap = true, silent = true,            desc = "Live Grep"                           })
vim.keymap.set("n", "<leader>fr",   "<cmd>Telescope oldfiles hidden=true<CR>",      { noremap = true, silent = true,            desc = "Recent Files"                        })
vim.keymap.set("n", "<leader>fb",   "<cmd>Telescope buffers hidden=true<CR>",       { noremap = true, silent = true,            desc = "Buffers"                             })
vim.keymap.set("n", "<leader>fo",   "<cmd>Yazi<CR>",                                { noremap = true, silent = true,            desc = "Open Yazi"                           })
vim.keymap.set("n", "<leader>fO",   "<cmd>Oil<CR>",                                 { noremap = true, silent = true,            desc = "Open Oil"                            })
vim.keymap.set("n", "<leader>fd!",  "<cmd>Delete!<CR>",                             { noremap = true, silent = true,            desc = "Delete File"                         })
vim.keymap.set("n", "<leader>fw",   "<cmd>w<CR>",                                   { noremap = true, silent = true,            desc = "Write Current Buffer"                })
vim.keymap.set("n", "<leader>fW",   "<cmd>wa<CR>",                                  { noremap = true, silent = true,            desc = "Write All Buffers"                   })
vim.keymap.set("n", "<leader>fq",   "<cmd>wq<CR>",                                  { noremap = true, silent = true,            desc = "Write Current Buffer and Quit"       })
vim.keymap.set("n", "<leader>fQ",   "<cmd>wa<CR><cmd>q<CR>",                        { noremap = true, silent = true,            desc = "Write All Buffers and Quit"          })

-- LSP Usage
vim.keymap.set("n", "<leader>ck",   vim.lsp.buf.hover,                              { noremap = true, silent = true,            desc = "Get LSP Hover Message"               })
vim.keymap.set("n", "<leader>cd",   vim.lsp.buf.definition,                         { noremap = true, silent = true,            desc = "Get LSP Definition"                  })
vim.keymap.set("n", "<leader>ca",   vim.lsp.buf.code_action,                        { noremap = true, silent = true,            desc = "LSP Code Action"                     })
vim.keymap.set('n', '<leader>ch', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end,                                                                                { silent = true, noremap = true,            desc = "Hide LSP Diagnostics"                })

-- Snippets
vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if require("luasnip").expand_or_jumpable() then
    require("luasnip").expand_or_jump()
  end
end,                                                                                { noremap = true, silent = true,            desc = "Expand or Jump Within Snippet"       })
vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if require("luasnip").jumpable(-1) then
    require("luasnip").jump(-1)
  end
end,                                                                                { noremap = true, silent = true,            desc = "Jump Back Within Snippet"            })
vim.keymap.set({ "i", "s" }, "<c-s-k>", function()
  if require("luasnip").choice_active() then
    require("luasnip").change_choice(1)
  end
end,                                                                                { noremap = true, silent = true,            desc = "Change Choice Within Snippet"        })
vim.keymap.set({ "i", "s" }, "<c-s-j>", function()
  if require("luasnip").choice_active() then
    require("luasnip").change_choice(-1)
  end
end,                                                                                { noremap = true, silent = true,            desc = "Change Choice Within Snippet"        })
vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/plugins/luasnip.lua<CR>", { desc = "Source luasnip snippets"                                      })

-- Align
vim.keymap.set('x', 'aa',function()
  require'align'.align_to_char({length = 1,                                                                                                                                })
end,                                                                                { noremap = true, silent = true,            desc = "Align to Single Character"           })

vim.keymap.set('x', 'ad', function()
  require'align'.align_to_char({preview = true, length = 2,                                                                                                                  })
end,                                                                                { noremap = true, silent = true,            desc = "Align to Two Characters"             })

-- Aligns to a string with previews
vim.keymap.set('x', 'aw', function()
    require'align'.align_to_string({preview = true, regex = false,                                                                                                           })
end,                                                                                { noremap = true, silent = true,            desc = "Align to a String"                   })

-- Aligns to a Vim regex with previews
vim.keymap.set('x', 'ar', function()
    require'align'.align_to_string({preview = true, regex = true,                                                                                                            })
end,                                                                                { noremap = true, silent = true,            desc = "Align to a Regex Pattern"            })

-- Example gawip to align a paragraph to a string with previews
vim.keymap.set('n', 'gaw', function()
    local a = require'align'
    a.operator(a.align_to_string, {regex = false, preview = true,                                                                                                            })
end,                                                                                { noremap = true, silent = true,            desc = "Align Paragraph to a String"         })

-- Example gaaip to align a paragraph to 1 character
vim.keymap.set('n', 'gaa', function()
    local a = require'align'
    a.operator(a.align_to_char)
end,                                                                                { noremap = true, silent = true,            desc = "Align Paragraph to Single Character" })

--%%% INSERT MODE %%%--

--%%% VISUAL MODE %%%--
-- Miscellaneous
vim.keymap.set("x", ">",            ">gv",                                          { noremap = true, silent = true,            desc = "Increase line indent"                })
vim.keymap.set("x", "<",            "<gv",                                          { noremap = true, silent = true,            desc = "Decrease line indent"                })

-- Movement
vim.keymap.set("x", "L",            "$",                                            { noremap = true, silent = true,            desc = "Go to End of Line"                   })
vim.keymap.set("x", "H",            "0",                                            { noremap = true, silent = true,            desc = "Go to Front of Line"                 })

-- Multi  Mode --
vim.keymap.set({'n', 'x', 'o'}, 's',     '<Plug>(leap-forward)',                    { noremap = true, silent = true,            desc = "Leap Forward"                        })
vim.keymap.set({'n', 'x', 'o'}, 'S',     '<Plug>(leap-backward)',                   { noremap = true, silent = true,            desc = "Leap Backward"                       })
vim.keymap.set({'n', 'x', 'o'}, 'gs',    '<Plug>(leap-from-window)',                { noremap = true, silent = true,            desc = "Leap From Window"                    })
vim.keymap.set({'n', 'x', 'o'}, "<tab>", "%",                                       { noremap = true, silent = true,            desc = "Move to other bracket"               })
