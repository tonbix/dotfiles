local mainMod = "SUPER"

hl.bind("ALT + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu -display-columns 2 | cliphist decode | wl-copy"), { release = true })
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("rofi -modi emoji -show emoji"), { release = true })

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("kitty"))

hl.bind(mainMod .. " + Super_L", hl.dsp.exec_cmd("pkill rofi || rofi -show drun"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("pkill rofi || rofi -show run"))

hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))

hl.bind("Print", hl.dsp.exec_cmd("~/.config/scripts/screenshots/screenshot.sh selection"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("~/.config/scripts/screenshots/screenshot.sh output"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd("~/.config/scripts/screenshots/screenshot.sh activewindow"))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("~/.config/scripts/volume-control/volume.sh increase"), { repeating = true, locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("~/.config/scripts/volume-control/volume.sh decrease"), { repeating = true, locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("~/.config/scripts/volume-control/volume.sh mute"), { repeating = true, locked = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + S", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen_state({ internal = 2, client = -1 }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen_state({ internal = 0, client = 2 }))

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.swap({ direction = "down" }))
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.swap({ direction = "right" }))

hl.bind(mainMod .. " + ALT + H", hl.dsp.window.resize({ x = -50, y = 0 }), { repeating = true })
hl.bind(mainMod .. " + ALT + J", hl.dsp.window.resize({ x = 0, y = 50 }), { repeating = true })
hl.bind(mainMod .. " + ALT + K", hl.dsp.window.resize({ x = 0, y = -50 }), { repeating = true })
hl.bind(mainMod .. " + ALT + L", hl.dsp.window.resize({ x = 50, y = 0 }), { repeating = true })

for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + Left", hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mainMod .. " + Right", hl.dsp.focus({ workspace = "m+1" }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("SHIFT + F8", hl.dsp.exec_cmd('echo "toggle_record" | nc -U -u -w0 /tmp/macro_bot.sock'))
hl.bind("SHIFT + F9", hl.dsp.exec_cmd('echo "toggle_play" | nc -U -u -w0 /tmp/macro_bot.sock'))
hl.bind("SHIFT + Escape", hl.dsp.exec_cmd('echo "exit" | nc -U -u -w0 /tmp/macro_bot.sock'))

hl.bind("F9", hl.dsp.pass({ window = "class:^(com\\.obsproject\\.Studio)$" }))
