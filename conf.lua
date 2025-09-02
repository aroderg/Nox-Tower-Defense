function love.conf(t)
    gameVersion = "Nova"
    gameVersionSemantic = "1.0.3"
    t.version = "11.5"
    t.window.title = "NoxTD " .. gameVersionSemantic .. " " .. gameVersion
    t.window.fullscreen = false
    t.window.width = 0
    t.window.height = 0
    t.console = true
    t.window.vsync = 1
end