function createCollapseParticle()
    collapseParticle = {}
    collapseParticle.x = 960
    collapseParticle.y = 540
    collapseParticle.angle = love.math.random(0, 2 * math.pi * 10000) / 10000
    collapseParticle.speed = love.math.random(10, 50)
    collapseParticle.fadeTime = love.math.random(2, 3)
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
        ["basic"] = {5, 30},
        ["tank"] = {6, 36},
        ["swift"] = {4, 24},
        ["sentry"] = {8, 48},
        ["centurion"] = {11, 66}
        }
    local fadeTimes = {
        ["basic"] = 0.6,
        ["tank"] = 0.8,
        ["swift"] = 0.5,
        ["sentry"] = 1.5,
        ["centurion"] = 2.5
        }
    killParticle.speed = math.random(particleSpeed[origin][1], particleSpeed[origin][2])
    killParticle.fadeTime = fadeTimes[origin]
    killParticle.timer_fade = 0
    table.insert(killParticles, killParticle)
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

function createMeteorParticle(x, y)
    meteorParticle = {}
    meteorParticle.x = x
    meteorParticle.y = y
    meteorParticle.fadeTime = 0.6
    meteorParticle.timer_fade = 0
    table.insert(meteorParticles, meteorParticle)
end

function createCrystalExplosionParticle(x, y)
    crystalExplosionParticle = {}
    crystalExplosionParticle.x = x
    crystalExplosionParticle.y = y
    crystalExplosionParticle.angle = love.math.random(0, 2 * math.pi * 10000) / 10000
    crystalExplosionParticle.speed = love.math.random(9, 36)
    crystalExplosionParticle.fadeTime = 1.15
    crystalExplosionParticle.timer_fade = 0
    table.insert(crystalExplosionParticles, crystalExplosionParticle)
end

function createBurnParticle(x, y)
    burnParticle = {}
    burnParticle.x = x
    burnParticle.y = y
    burnParticle.angle = love.math.random(0, 2 * math.pi * 10000) / 10000
    burnParticle.speed = love.math.random(0, 4)
    burnParticle.fadeTime = 2
    burnParticle.timer_fade = 0
    table.insert(burnParticles, burnParticle)
end

particles = {render = {}}

function renderParticles()
    local killParticleAppearances = {
        ["basic"] = {img_particle_kill_enemy_basic, 4},
        ["tank"] = {img_particle_kill_enemy_tank, 5},
        ["swift"] = {img_particle_kill_enemy_swift, 3},
        ["sentry"] = {img_particle_kill_enemy_sentry, 6},
        ["centurion"] = {img_particle_kill_enemy_centurion, 8},
    }
    --[[ Render the particles to be different depending on their origin ]]--
    for i,v in ipairs(killParticles) do
        love.graphics.setColor(1, 1, 1, 1-v.timer_fade/v.fadeTime)
        love.graphics.draw(killParticleAppearances[v.origin][1], v.x - killParticleAppearances[v.origin][2], v.y - killParticleAppearances[v.origin][2])
    end
    for i,v in ipairs(collapseParticles) do
        local particleAlpha = player.settings.particleMultiplier == 1 and 0 or 1-v.timer_fade/v.fadeTime
        love.graphics.setColor(1, 1, 1, particleAlpha)
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
    for i,v in ipairs(meteorParticles) do
        love.graphics.setColor(1, 1, 1, 1-v.timer_fade/v.fadeTime)
        love.graphics.draw(img_particle_meteor, v.x - 4, v.y - 4)
    end
    for i,v in ipairs(crystalExplosionParticles) do
        love.graphics.setColor(1, 1, 1, 1-v.timer_fade/v.fadeTime)
        love.graphics.draw(img_particle_crystalExplosion, v.x - 3, v.y - 3)
    end
end

function particles.render.burn()
    for i,v in ipairs(burnParticles) do
        love.graphics.setColor(1, 1, 1, 0.2-(v.timer_fade/v.fadeTime)*0.2)
        love.graphics.draw(img_particle_burn, v.x - 5, v.y - 5)
    end
end

function updateParticles(dt)
    --[[ Move particles from the center of their spawn when enemy killed/tower collapsed ]]--
    for i,v in ipairs(killParticles) do
        v.timer_fade = v.timer_fade + dt * gameplay.gameSpeed
        v.x = v.x + math.cos(v.angle) * v.speed * dt * gameplay.gameSpeed
        v.y = v.y + math.sin(v.angle) * v.speed * dt * gameplay.gameSpeed
        if v.timer_fade >= v.fadeTime then
            table.remove(killParticles, i)
        end
    end
    for i,v in ipairs(collapseParticles) do
        v.timer_fade = v.timer_fade + dt * gameplay.gameSpeed
        v.x = v.x + math.cos(v.angle) * v.speed * dt * gameplay.gameSpeed
        v.y = v.y + math.sin(v.angle) * v.speed * dt * gameplay.gameSpeed
        if v.timer_fade >= v.fadeTime then
            table.remove(collapseParticles, i)
        end
    end
    for i,v in ipairs(hitTextParticles) do
        v.timer_fade = v.timer_fade + dt * gameplay.gameSpeed
        if v.timer_fade >= v.fadeTime then
            table.remove(hitTextParticles, i)
        end
    end
    for i,v in ipairs(meteorParticles) do
        v.timer_fade = v.timer_fade + dt * gameplay.gameSpeed
        if v.timer_fade >= v.fadeTime then
            table.remove(meteorParticles, i)
        end
    end
    for i,v in ipairs(crystalExplosionParticles) do
        v.timer_fade = v.timer_fade + dt * gameplay.gameSpeed
        v.x = v.x + math.cos(v.angle) * v.speed * dt * gameplay.gameSpeed
        v.y = v.y + math.sin(v.angle) * v.speed * dt * gameplay.gameSpeed
        if v.timer_fade >= v.fadeTime then
            table.remove(crystalExplosionParticles, i)
        end
    end
    for i,v in ipairs(burnParticles) do
        v.timer_fade = v.timer_fade + dt * gameplay.gameSpeed
        v.x = v.x + math.cos(v.angle) * v.speed * dt * gameplay.gameSpeed
        v.y = v.y + math.sin(v.angle) * v.speed * dt * gameplay.gameSpeed
        if v.timer_fade >= v.fadeTime then
            table.remove(burnParticles, i)
        end
    end
end