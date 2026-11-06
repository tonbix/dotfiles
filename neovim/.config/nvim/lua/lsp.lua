require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
        "svelte",
        "ts_ls",
        "html",
        "cssls",
        "lua_ls",
        "harper_ls",
    },
})

vim.lsp.config("*", {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

vim.lsp.config("lua_ls", {
    settings = { Lua = { diagnostics = { globals = { "vim" } } } },
})

vim.lsp.config("harper_ls", {
    settings = {
        ["harper-ls"] = {
            userDictPath = vim.fn.expand("$HOME/.config/harper/user_dict.txt"),
            workspaceDictPath = ".harper_dict.txt",
            linters = { SentenceCapitalization = false, IDontKnow = false },
            diagnosticSeverity = "hint",
            dialect = "American",
        },
    },
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("user.lsp", { clear = true }),
    callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    end,
})
