hl.config({
    general = {
        gaps_in = 3,
        gaps_out = 6,

        border_size = 0,

        allow_tearing = true,

        layout = "dwindle",
    },

    decoration = {
        rounding = 0,
        rounding_power = 2,

        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = false,
            range = 4,
            render_power = 3,
            color = color_shadow,
        },

        blur = {
            enabled = false,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
})
