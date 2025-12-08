function love.conf(t)
    gameVersion = "Aurora"
    gameVersionSemantic = "1.1.3"
    t.version = "11.5"
    t.window.title = "NoxTD " .. gameVersionSemantic .. " " .. gameVersion
    t.window.fullscreen = false
    t.window.width = 960
    t.window.height = 700
    t.window.resizable = true
    t.console = true
    t.window.vsync = 1
end