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

function createHitTextParticle(x, y, damage, origin, isCrit)
    hitTextParticle = {}
    hitTextParticle.x = x
    hitTextParticle.y = y
    hitTextParticle.damage = damage
    hitTextParticle.fadeTime = 0.25
    hitTextParticle.origin = origin
    hitTextParticle.isCrit = isCrit
    hitTextParticle.timer_fade = 0
    table.insert(hitTextParticles, hitTextParticle)
end

function renderParticles()
    local particleAppearances = {
        ["basic"] = {img_particle_kill_enemy_basic, 4},
        ["tank"] = {img_particle_kill_enemy_tank, 5},
        ["swift"] = {img_particle_kill_enemy_swift, 3},
        ["sentry"] = {img_particle_kill_enemy_sentry, 6},
        ["centurion"] = {img_particle_kill_enemy_centurion, 8},
    }
    --[[ Render the particles to be different depending on their origin ]]--
    for i,v in ipairs(particles) do
        love.graphics.setColor(1, 1, 1, 1-v.timer_fade/v.fadeTime)
        love.graphics.draw(particleAppearances[v.origin][1], v.x - particleAppearances[v.origin][2], v.y - particleAppearances[v.origin][2])
    end
    for i,v in ipairs(collapseParticles) do
        love.graphics.setColor(1, 1, 1, 1-v.timer_fade/v.fadeTime)
        love.graphics.draw(img_particle_collapse, v.x - 6, v.y - 6)
    end
    love.graphics.setFont(font_Afacad16)
    local offsets = {
        ["basic"] = 10,
        ["tank"] = 16,
        ["swift"] = 8,
        ["sentry"] = 22,
        ["centurion"] = 30,
        }
    for i,v in ipairs(hitTextParticles) do
        love.graphics.setColor(1, v.isCrit and 0.2 or 1, v.isCrit and 0.4 or 1, 1-v.timer_fade/v.fadeTime)
        love.graphics.printf(v.damage, math.floor(v.x - 50 + offsets[v.origin]), math.floor(v.y - 15), 100, "center")
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
    for i,v in ipairs(hitTextParticles) do
        v.timer_fade = v.timer_fade + dt * gameSpeed
        if v.timer_fade >= v.fadeTime then
            table.remove(hitTextParticles, i)
        end
    end
end