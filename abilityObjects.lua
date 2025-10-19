abilityObjects = {
    spikedCrystal = {},
    magmaPool = {},
    lightningOrb = {},
    lightningOrb_laser = {},
    JerelosBlessing = {}
}

--- Spawn a Spiked Crystal somewhere in the tower's range.
function abilityObjects.spikedCrystal.spawn()
    crystal = {}
    local cx = 0
    local cy = 0
    while math.dist(960, 540, cx + 11, cy + 11) >= player.tower.range - 16 do
        local cx = love.math.random(0, 1898)
        local cy = love.math.random(0, 1058)
        if math.dist(960, 540, cx + 11, cy + 11) > TOWER_SIZE + 16 and math.dist(960, 540, cx + 11, cy + 11) < player.tower.range - 16 then
            crystal.x = cx
            crystal.y = cy
            break
        end
    end
    crystal.timer_lifespan = 0
    crystal.timer_explosionDuration = 0.25
    crystal.timer_explosion = 0
    crystal.state = "alive"
    player.stats.battle.spikedCrystals.spawned = player.stats.battle.spikedCrystals.spawned + 1
    player.stats.save.spikedCrystals.spawned = player.stats.save.spikedCrystals.spawned + 1
    table.insert(spikedCrystals, crystal)
end

--- Draw all Spiked Crystals depending on their state.
function abilityObjects.spikedCrystal.draw()
    love.graphics.setColor(1, 1, 1, 1)
    for i,v in ipairs(spikedCrystals) do
        if v.state == "alive" then
            love.graphics.draw(img_crystal_multilayered_l1, v.x + 11, v.y + 11, v.timer_lifespan / 5.75, 1, 1, 11, 11)
            love.graphics.draw(img_crystal_multilayered_l2, v.x + 11, v.y + 11, v.timer_lifespan / 5.75, 1, 1, 11, 11)
            love.graphics.draw(img_crystal_multilayered_l3, v.x + 11, v.y + 11, v.timer_lifespan / 5.75, 1, 1, 11, 11)
        else
            local cs = math.min(1 + v.timer_explosion * 7.5, 2)
            love.graphics.setColor(1, 1, 1, 1 - v.timer_explosion / 0.2)
            love.graphics.draw(img_crystal_aoe, v.x + 11 - 16 * cs, v.y + 11 - 16 * cs, 0, cs / 2, cs / 2)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.setColor(1, 1, 1, 1 - v.timer_explosion / v.timer_explosionDuration)
            love.graphics.draw(img_crystal_multilayered_l1, v.x + 11, v.y + 11, v.timer_explosion * 8, cs, 1, 11, 11)
            love.graphics.draw(img_crystal_multilayered_l2, v.x + 11, v.y + 11, v.timer_explosion * 12, cs, 1, 11, 11)
            love.graphics.draw(img_crystal_multilayered_l3, v.x + 11, v.y + 11, v.timer_explosion * 18, cs, 1, 11, 11)
            love.graphics.setColor(1, 1, 1, 1)
        end
    end
end

--- Process all Spiked Crystals and their collisions with any enemy.
function abilityObjects.spikedCrystal.process(logicStep)
    if player.abilities.spikedCrystals.unlocked and player.abilities.spikedCrystals.equipped then
        if timers.crystal < levelingInfo[1].frequency[player.abilities.spikedCrystals.level + 1] then
            timers.crystal = timers.crystal + logicStep * gameplay.gameSpeed
        else
            timers.crystal = 0
            for i=1,math.max(levelingInfo[1].quantity[player.abilities.spikedCrystals.level + 1] - #spikedCrystals, 0) do
                abilityObjects.spikedCrystal.spawn()
            end
        end
    end
    for i=#spikedCrystals,1,-1 do
        local v = spikedCrystals[i]
        local size = {
            basic = 20,
            tank = 32,
            swift = 16,
            sentry = 44,
            centurion = 60,
            exploder = 24,
        }
        v.timer_lifespan = v.timer_lifespan + logicStep * gameplay.gameSpeed
        if v.state == "exploding" then
            audio_crystal_explosion:setVolume(1 * player.settings.volume^2)
            audio_crystal_explosion:play()
            if v.timer_explosion < v.timer_explosionDuration then
                v.timer_explosion = v.timer_explosion + logicStep * gameplay.gameSpeed
            else
                for i=1,8*settings_particleMultipliers[player.settings.particleMultiplier] do
                    createCrystalExplosionParticle(v.x + 11, v.y + 11)
                end
                table.remove(spikedCrystals, i)
            end
        end
        for j,w in ipairs(enemiesOnField) do
            if v.x + 20 > w.x and v.x < w.x + size[w.type] and v.y + 20 > w.y and v.y < w.y + size[w.type] and player.tower.currentHealth > 0 and v.state == "alive" and math.dist(v.x + 11, v.y + 11, w.x + enemyOffsets[w.type], w.y + enemyOffsets[w.type]) < 64 then
                local damage = player.tower.attackDamage * (levelingInfo[1].damage[player.abilities.spikedCrystals.level + 1] / 100)
                damageEnemy(j, damage, false, false, "spikedCrystal")
                v.state = "exploding"
            end
        end
    end
end

--- Spawn a Magma Pool somewhere on the screen.
function abilityObjects.magmaPool.spawn()
    magmaPool = {}
    local mx = love.math.random(0, 1884)
    local my = love.math.random(0, 1044)
    magmaPool.x = mx
    magmaPool.y = my
    while math.dist(960, 540, mx + 18, my + 18) <= TOWER_SIZE + 18 do
        local mx = love.math.random(0, 1884)
        local my = love.math.random(0, 1044)
        if math.dist(960, 540, mx + 18, my + 18) > TOWER_SIZE + 18 then
            magmaPool.x = mx
            magmaPool.y = my
            break
        end
    end
    player.stats.battle.magmaTouch.spawned = player.stats.battle.magmaTouch.spawned + 1
    player.stats.save.magmaTouch.spawned = player.stats.save.magmaTouch.spawned + 1
    table.insert(magmaPools, magmaPool)
end

--- Draw all Magma Pools spawned from the Magma Touch ability.
function abilityObjects.magmaPool.draw()
    for i,v in ipairs(magmaPools) do
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(img_magmaTouch_pool, v.x, v.y)
    end
end

--- Process all Magma Pools and their collisions with enemies, apply the burning effects to the enemy it collides with.
function abilityObjects.magmaPool.process(logicStep)
    for i=#magmaPools,1,-1 do
        local v = magmaPools[i]
        local size = {
            basic = 20,
            tank = 32,
            swift = 16,
            sentry = 44,
            centurion = 60,
            exploder = 24,
        }
        for j=#enemiesOnField,1,-1 do
            local w = enemiesOnField[j]
            if math.dist(v.x + 18, v.y + 18, w.x + size[w.type] / 2, w.y + size[w.type] / 2) < 16 + size[w.type] / 2 then
                table.remove(magmaPools, i)
                damageEnemy(j, player.tower.attackDamage * (levelingInfo[5].damage[player.abilities.magmaTouch.level + 1] / 100), false, false, "magmaPool")
                w.burningTime = 4.025
            end
        end
    end
end

--- Spawn a Lightning Orb at the center of the screen.
function abilityObjects.lightningOrb.spawn()
    lightningOrb = {}
    lightningOrb.x = 960
    lightningOrb.y = 540
    lightningOrb.speed = 60
    lightningOrb.angle = love.math.random() * 2 * math.pi
    lightningOrb.range = levelingInfo[6].range[player.abilities.lightningOrb.level + 1]
    local lo = audio_lightningOrb_launch:clone()
    lo:setVolume(1 * player.settings.volume^2)
    lo:play()
    player.stats.battle.lightningOrb.spawned = player.stats.battle.lightningOrb.spawned + 1
    player.stats.save.lightningOrb.spawned = player.stats.save.lightningOrb.spawned + 1
    table.insert(lightningOrbs, lightningOrb)
end

--- Draw all Lightning Orbs, their shadows and their ranges.
function abilityObjects.lightningOrb.draw()
    for i,v in ipairs(lightningOrbs) do
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(img_lightningOrb_shadow, v.x - 24 - 9 * math.cos(v.angle), v.y - 24 - 9 * math.sin(v.angle))
        love.graphics.draw(img_lightningOrb, v.x - 16, v.y - 16)
        love.graphics.setColor(0, 0.7, 0.45, 0.6)
        love.graphics.setLineStyle("smooth")
        love.graphics.setLineWidth(1)
        love.graphics.ellipse("line", v.x, v.y, v.range * 20, v.range * 20)
        love.graphics.setColor(1, 1, 1, 1)
    end
end

--- Process all Lightning Orbs and move them depending on their angle.
function abilityObjects.lightningOrb.process(logicStep)
    for i,v in pairs(lightningOrbs) do
        local v = lightningOrbs[i]
        v.x = v.x + math.cos(v.angle) * v.speed * logicStep * gameplay.gameSpeed
        v.y = v.y + math.sin(v.angle) * v.speed * logicStep * gameplay.gameSpeed
        local farthestEnemy = findClosestEnemyInRange(v.x, v.y, v.range * 20)[#findClosestEnemyInRange(v.x, v.y, v.range * 20)]
        if farthestEnemy and #lightningOrb_lasers < #lightningOrbs then
            abilityObjects.lightningOrb_laser.spawn(v.x, v.y, math.dist(v.x, v.y, farthestEnemy.x + enemyOffsets[farthestEnemy.type], farthestEnemy.y + enemyOffsets[farthestEnemy.type]), math.atan2(farthestEnemy.y + enemyOffsets[farthestEnemy.type] / 2 - v.y, farthestEnemy.x + enemyOffsets[farthestEnemy.type] / 2 - v.x))
        elseif not farthestEnemy then
            table.remove(lightningOrb_lasers, i)
        end
        if (v.x <= -200 or v.x >= 2120) and (v.y <= -200 or v.y >= 1280) then
            table.remove(lightningOrbs, i)
        end
    end
end

--- Spawn a Lightning Orb Laser at the Lightning Orb's position, aiming at the farthest enemy in range.
function abilityObjects.lightningOrb_laser.spawn(x, y, dist, angle)
    lightningOrb_laser = {}
    lightningOrb_laser.x = x
    lightningOrb_laser.y = y
    lightningOrb_laser.dist = dist
    lightningOrb_laser.var = love.math.random(1, 3)
    lightningOrb_laser.angle = angle
    table.insert(lightningOrb_lasers, lightningOrb_laser)
end

--- Draw all Lightning Orb Lasers and their variations.
function abilityObjects.lightningOrb_laser.draw()
    local lightningOrb_laser_variations = {
        img_lightningOrb_laser_var1,
        img_lightningOrb_laser_var2,
        img_lightningOrb_laser_var3
    }
    for i,v in ipairs(lightningOrb_lasers) do
        love.graphics.draw(lightningOrb_laser_variations[v.var], v.x, v.y, v.angle, v.dist / 300, 1, 0, 8)
        table.remove(lightningOrb_lasers, i)
    end
end

--- Process all Lightning Orb Lasers and damage to the farthest enemy in range.
function abilityObjects.lightningOrb_laser.process(logicStep)
    local damagedEnemyIndex = 1
    for i,v in ipairs(lightningOrbs) do
        local farthestEnemy = findClosestEnemyInRange(v.x, v.y, v.range * 20)[#findClosestEnemyInRange(v.x, v.y, v.range * 20)]
        if farthestEnemy then
            for j,w in ipairs(enemiesOnField) do
                if w == farthestEnemy then
                    damagedEnemyIndex = j
                    break
                end
            end
            if player.tower.currentHealth > 0 and gameplay.gameSpeed > 0 then
                damageEnemy(damagedEnemyIndex, (levelingInfo[6].damage[player.abilities.lightningOrb.level + 1] / 100) * player.tower.attackDamage * logicStep * gameplay.gameSpeed, false, false, "lightningOrb")--damageEnemy(farthestEnemy, levelingInfo[6].damage[player.abilities.lightningOrb.level + 1] * 100 * logicStep * player.tower.attackDamage, false)
            end
        end
    end
end

--- Draw the visuals of the Jerelo's Blessing ability.
function abilityObjects.JerelosBlessing.draw()
    love.graphics.setColor(1, 1, 1, 1)
    local waves = {
        img_JerelosBlessing_waves_var1,
        img_JerelosBlessing_waves_var2,
        img_JerelosBlessing_waves_var3,
        img_JerelosBlessing_waves_var4
    }
    local vines = {
        img_JerelosBlessing_vines_var1,
        img_JerelosBlessing_vines_var2,
        img_JerelosBlessing_vines_var3,
        img_JerelosBlessing_vines_var4
    }
    love.graphics.draw(img_JerelosBlessing_water, 928, 508)
    love.graphics.draw(waves[misc.JerelosBlessingVisuals.waves], 928, 508)
    love.graphics.draw(vines[misc.JerelosBlessingVisuals.vines], 924, 504)
end