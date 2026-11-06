-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- Persistent undo
local undo_path = vim.fn.stdpath("data") .. "/undo"
vim.fn.mkdir(undo_path, "p")
vim.opt.undofile = true
vim.opt.undodir = undo_path

-- UI & behaviour
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = ""

-- 4 space indents
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.diagnostic.config({
    float = { border = "single" },
})

vim.filetype.add({
    extension = { qss = "css" },
})
