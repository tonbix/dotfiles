-- Оверрайды цветов живут в автокоманде: иначе colorscheme перетирает их при каждой смене темы.
vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("user.ui", { clear = true }),
    callback = function()
        local set = function(name, val) vim.api.nvim_set_hl(0, name, val) end
        set("Normal", { bg = "none" })
        set("NormalFloat", { bg = "none" })
        set("FloatBorder", { fg = "#909090", bg = "none" })
        set("SignColumn", { bg = "none" })
        set("LineNr", { bg = "none" })
        set("CursorLine", { bg = "#080808" })
        set("CursorLineNr", { bg = "none", bold = true })
    end,
})

vim.cmd.colorscheme("vague")
