local vim = vim

-- FZF
vim.keymap.set("n", "<C-f>", ":FZF<CR>")

-- NERDTree
vim.keymap.set("n", "<C-t>", ":NERDTreeToggle<CR>")

-- Diagnostics
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

-- Dial.nvim (Advanced Increment/Decrement)
local dial = require("dial.map")
vim.keymap.set("n", "<C-a>", function() dial.manipulate("increment", "normal") end)
vim.keymap.set("n", "<C-x>", function() dial.manipulate("decrement", "normal") end)
vim.keymap.set("n", "g<C-a>", function() dial.manipulate("increment", "gnormal") end)
vim.keymap.set("n", "g<C-x>", function() dial.manipulate("decrement", "gnormal") end)
vim.keymap.set("x", "<C-a>", function() dial.manipulate("increment", "visual") end)
vim.keymap.set("x", "<C-x>", function() dial.manipulate("decrement", "visual") end)
vim.keymap.set("x", "g<C-a>", function() dial.manipulate("increment", "gvisual") end)
vim.keymap.set("x", "g<C-x>", function() dial.manipulate("decrement", "gvisual") end)

