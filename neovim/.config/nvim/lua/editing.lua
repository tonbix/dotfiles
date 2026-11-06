-- Autopairs & autotag
require("nvim-autopairs").setup({ check_ts = true })

require("nvim-ts-autotag").setup({
    opts = { enable_close = true, enable_rename = true, enable_close_on_slash = true },
})

-- Colorizer
require("colorizer").setup({ "*" }, {
    RGB = true, RRGGBB = true, names = true, RRGGBBAA = true,
    rgb_fn = false, hsl_fn = false, css = false, css_fn = false,
    mode = "background",
})

-- Dial.nvim
local augend = require("dial.augend")

require("dial.config").augends:register_group({
    default = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"],
        augend.date.alias["%m/%d/%Y"],
        augend.constant.alias.bool,
    },
})

local dial = require("dial.map")
local dial_keys = {
    -- { mode, key, direction, look }
    { "n", "<C-a>",  "increment", "normal" },
    { "n", "<C-x>",  "decrement", "normal" },
    { "n", "g<C-a>", "increment", "gnormal" },
    { "n", "g<C-x>", "decrement", "gnormal" },
    { "x", "<C-a>",  "increment", "visual" },
    { "x", "<C-x>",  "decrement", "visual" },
    { "x", "g<C-a>", "increment", "gvisual" },
    { "x", "g<C-x>", "decrement", "gvisual" },
}

for _, k in ipairs(dial_keys) do
    vim.keymap.set(k[1], k[2], function() dial.manipulate(k[3], k[4]) end)
end
