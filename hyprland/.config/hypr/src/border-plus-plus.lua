hl.plugin.load("/usr/lib/libhyprbordersplusplus.so")

local function configure_borders_plus_plus()
    hl.config({
        plugin = {
            borders_plus_plus = {
                add_borders = 2,
                border_size_1 = 3,
                border_size_2 = 1,
                col = {
                    border_1 = color_border_1,
                    border_2 = color_border_2,
                },
            },
        },
    })
end

hl.on("hyprland.start", configure_borders_plus_plus)
hl.on("config.reloaded", function()
    if #hl.get_loaded_plugins() > 0 then
        configure_borders_plus_plus()
    end
end)
