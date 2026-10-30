hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@74.97",
    position = "0x0",
    scale = 1.0,
})

hl.monitor({
    output = "DVI-I-1",
    mode = "1920x1080@60.00",
    position = "-1080x-420",
    scale = 1.0,
    transform = 1,
})

hl.monitor({
    output = "DP-1",
    mode = "1024x768@85.00",
    position = "auto-left",
    scale = 1.0,
})

hl.monitor({
    output = "HEADLESS-1",
    mode = "1280x800@60",
    position = "auto",
    scale = 1,
})

hl.workspace_rule({
    workspace = "11",
    monitor = "HEADLESS-1",
    default = true,
})
