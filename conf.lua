function love.conf(t)
    gameVersion = "Aurora"
    gameVersionSemantic = "1.1.3"
    t.version = "11.5"
    t.window.title = "NoxTD " .. gameVersionSemantic .. " " .. gameVersion
    t.window.icon = "assets/tower_nova.png"
    t.window.fullscreen = true
    t.window.width = 1280
    t.window.height = 720
    t.window.resizable = true
    t.console = true
    t.window.vsync = 1
end