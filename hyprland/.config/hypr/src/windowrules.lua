hl.window_rule({
    match = { class = "xdg-desktop-portal-gtk" },
    float = true,
    center = true,
})

hl.window_rule({
    match = { class = "mpv" },
    float = true,
    center = true,
})

hl.window_rule({
    match = { class = "feh" },
    float = true,
    center = true,
})

hl.window_rule({
    match = { class = "mpv-audio" },
    float = true,
    center = true,
    size = "360 80",
})

hl.window_rule({
    match = { class = "^(steam_app_*)$" },
    immediate = true,
})
