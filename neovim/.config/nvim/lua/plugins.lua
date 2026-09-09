local vim = vim

-- ==========================================
-- 1. NATIVE PLUGIN MANAGER (Neovim 0.12+)
-- ==========================================
vim.pack.add({
    -- Core
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    
    -- LSP & Autocomplete
    "https://github.com/williamboman/mason.nvim",
    "https://github.com/williamboman/mason-lspconfig.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/hrsh7th/nvim-cmp",
    "https://github.com/hrsh7th/cmp-nvim-lsp",
    "https://github.com/hrsh7th/cmp-buffer",
    "https://github.com/hrsh7th/cmp-path",
    "https://github.com/L3MON4D3/LuaSnip",
    "https://github.com/saadparwaiz1/cmp_luasnip",

    -- Editing 
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/windwp/nvim-ts-autotag",
    "https://github.com/monaqa/dial.nvim",
    "https://github.com/norcalli/nvim-colorizer.lua",

    -- Legacy & Misc
    "https://github.com/preservim/nerdtree",
    "https://github.com/junegunn/fzf",
    "https://github.com/bling/vim-bufferline",
    "https://github.com/christoomey/vim-tmux-navigator",
    "https://github.com/vyfor/cord.nvim",

    -- Theme
    "https://github.com/vague2k/vague.nvim",
})

-- ==========================================
-- 2. PLUGIN CONFIGURATIONS
-- ==========================================

-- Theme setup
pcall(vim.cmd, "colorscheme vague")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#909090", bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#080808" })
vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none", bold = true })

-- Helper function to safely load plugins without crashing
local function safe_require(module)
    local ok, result = pcall(require, module)
    if not ok then return nil end
    return result
end

-- Treesitter
local ts = safe_require('nvim-treesitter.configs')
if ts then
    ts.setup({
        auto_install = true,
        highlight = { enable = true, additional_vim_regex_highlighting = false },
        indent = { enable = true }
    })
end

-- Autopairs & Autotags
local autopairs = safe_require("nvim-autopairs")
if autopairs then autopairs.setup({ check_ts = true }) end

local autotag = safe_require("nvim-ts-autotag")
if autotag then 
    autotag.setup({ opts = { enable_close = true, enable_rename = true, enable_close_on_slash = true } }) 
end

-- Colorizer
local colorizer = safe_require("colorizer")
if colorizer then
    colorizer.setup({"*"}, {
        RGB = true, RRGGBB = true, names = true, RRGGBBAA = true,
        rgb_fn = false, hsl_fn = false, css = false, css_fn = false, mode = 'background'
    })
end

-- Dial.nvim
local dial_augend = safe_require("dial.augend")
local dial_config = safe_require("dial.config")
if dial_augend and dial_config then
    dial_config.augends:register_group{
        default = {
            dial_augend.integer.alias.decimal,
            dial_augend.integer.alias.hex,
            dial_augend.date.alias["%Y/%m/%d"],
            dial_augend.constant.alias.bool,
            dial_augend.date.alias["%m/%d/%Y"],
        }
    }
end

-- Mason & LSP
local mason = safe_require("mason")
if mason then mason.setup() end

local mason_lspconfig = safe_require("mason-lspconfig")
local cmp_nvim_lsp = safe_require("cmp_nvim_lsp")

if mason_lspconfig and cmp_nvim_lsp then
    local capabilities = cmp_nvim_lsp.default_capabilities()

    mason_lspconfig.setup({
        automatic_installation = true,
        ensure_installed = { "harper_ls" }, -- Forces Mason to actually install Harper!
        handlers = {
            -- Default handler for all servers (Using the new Neovim 0.11+ API)
            function(server_name)
                vim.lsp.config(server_name, { capabilities = capabilities })
                vim.lsp.enable(server_name)
            end,

            -- Dedicated custom handler just for Harper LS
            ["harper_ls"] = function()
                vim.lsp.config("harper_ls", {
                    capabilities = capabilities,
                    settings = {
                        ["harper-ls"] = {
                            userDictPath = vim.fn.expand("$HOME/.config/harper/user_dict.txt"),
                            workspaceDictPath = ".harper_dict.txt",
                            linters = { SentenceCapitalization = false, IDontKnow = false },
                            codeActions = { ForceStable = false },
                            markdown = { IgnoreLinkTitle = false },
                            diagnosticSeverity = "hint",
                            isolateEnglish = false, dialect = "American", maxFileLength = 1000000,
                            ignoredLintsPath = "", excludePatterns = {}
                        }
                    }
                })
                vim.lsp.enable("harper_ls")
            end
        }
    })
end

-- LSP Keybinds
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
    callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    end,
})

-- Autocompletion (CMP)
local cmp = safe_require('cmp')
local luasnip = safe_require('luasnip')

if cmp and luasnip then
    cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm({ select = true })
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' }, { name = 'luasnip' }, { name = 'path' }
        }, {
            { name = 'buffer' }
        })
    })
end
