local vim = vim

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Persistent Undo
local undo_path = vim.fn.stdpath("data") .. "/undo"
if vim.fn.isdirectory(undo_path) == 0 then
    vim.fn.mkdir(undo_path, "p")
end
vim.opt.undofile = true
vim.opt.undodir = undo_path

-- DO NOT USE `vim.cmd("syntax off")`. Treesitter handles this safely now!

-- UI & Behaviors
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"

-- Destroy the mouse
vim.opt.mouse = ""

-- 4 Space Indents
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true -- Converts tabs to 4 literal spaces

-- Diagnostics styling
vim.diagnostic.config({
    float = { border = "single" },
})

-- Custom filetypes
vim.filetype.add({
    extension = { qss = "css" },
})

