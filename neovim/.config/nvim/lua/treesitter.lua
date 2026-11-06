local parsers = {
    "svelte", "html", "css", "javascript", "typescript", "tsx", "json",
    "lua", "vim", "vimdoc", "query", "bash", "markdown", "markdown_inline", "yaml", "toml",
}

local function install_parsers()
    require("nvim-treesitter").install(parsers)
end

local registry = require("mason-registry")

local function ensure_cli_then_install()
    local ok, pkg = pcall(registry.get_package, "tree-sitter-cli")
    if not ok or pkg:is_installed() then
        return install_parsers()
    end
    vim.notify("Mason: ставлю tree-sitter-cli, потом соберу парсеры...")
    pkg:install():once("closed", vim.schedule_wrap(install_parsers))
end

registry.refresh(vim.schedule_wrap(ensure_cli_then_install))

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("user.treesitter", { clear = true }),
    callback = function(ev)
        if pcall(vim.treesitter.start, ev.buf) then
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
    end,
})
