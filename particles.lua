function createKillParticle(x, y, origin)
    killParticle = {}
    killParticle.x = x
    killParticle.y = y
    killParticle.angle = love.math.random(0, 2 * math.pi * 10000) / 10000
    killParticle.origin = origin
    local particleSpeed = {
        ["basic"] = {15, 30},
        ["tank"] = {18, 36},
        ["swift"] = {12, 24},
        ["sentry"] = {25, 50},
        ["centurion"] = {30, 60}
        }
    local fadeTimes = {
        ["basic"] = 0.5,
        ["tank"] = 0.7,
        ["swift"] = 0.7,
        ["sentry"] = 1.5,
        ["centurion"] = 2.5
        }
    killParticle.speed = math.random(particleSpeed[origin][1], particleSpeed[origin][2])
    killParticle.fadeTime = fadeTimes[origin]
    killParticle.timer_fade = 0
    table.insert(particles, killParticle)
end

function createCollapseParticle()
    collapseParticle = {}
    collapseParticle.x = 960
    collapseParticle.y = 540
    collapseParticle.angle = love.math.random(0, 2 * math.pi * 10000) / 10000
    collapseParticle.speed = love.math.random(10, 50)
    collapseParticle.fadeTime = 2.5
    collapseParticle.timer_fade = 0
    table.insert(collapseParticles, collapseParticle)
end

function renderParticles()
    --[[ Render the particles to be different depending on their origin ]]--
    for i,v in ipairs(particles) do
        love.graphics.setColor(1, 1, 1, 1-v.timer_fade/v.fadeTime)
        if v.origin == "basic" then
            love.graphics.draw(img_particle_kill_enemy_basic, v.x - 4, v.y - 4)
        elseif v.origin == "tank" then
            love.graphics.draw(img_particle_kill_enemy_tank, v.x - 5, v.y - 5)
        elseif v.origin == "swift" then
            love.graphics.draw(img_particle_kill_enemy_swift, v.x - 3, v.y - 3)
        elseif v.origin == "sentry" then
            love.graphics.draw(img_particle_kill_enemy_sentry, v.x - 6, v.y - 6)
        elseif v.origin == "centurion" then
            love.graphics.draw(img_particle_kill_enemy_centurion, v.x - 8, v.y - 8)
        end
    end
    for i,v in ipairs(collapseParticles) do
        love.graphics.setColor(1, 1, 1, 1-v.timer_fade/v.fadeTime)
        love.graphics.draw(img_particle_collapse, v.x - 6, v.y - 6)
    end
end

function updateParticles(dt)
    --[[ Move particles from the center of their spawn when enemy killed/tower collapsed ]]--
    for i,v in ipairs(particles) do
        v.timer_fade = v.timer_fade + dt * gameSpeed
        v.x = v.x + math.cos(v.angle) * v.speed * dt * gameSpeed
        v.y = v.y + math.sin(v.angle) * v.speed * dt * gameSpeed
        if v.timer_fade >= v.fadeTime then
            table.remove(particles, i)
        end
    end
    for i,v in ipairs(collapseParticles) do
        v.timer_fade = v.timer_fade + dt * gameSpeed
        v.x = v.x + math.cos(v.angle) * v.speed * dt * gameSpeed
        v.y = v.y + math.sin(v.angle) * v.speed * dt * gameSpeed
        if v.timer_fade >= v.fadeTime then
            table.remove(collapseParticles, i)
        end
    end
end