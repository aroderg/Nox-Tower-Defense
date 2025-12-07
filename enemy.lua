enemyFuncs = {}

function enemyFuncs.load()
    exploderAnimation = {}
    exploderExplodeTime = 1.8
    for i=0,20 do
        table.insert(exploderAnimation, love.graphics.newQuad(i * 24, 0, 24, 24, 480, 24))
    end
    exploderAnimationFrame = 0
    img_enemy_exploder = exploderAnimation[1]
    enemyOffsets = {
        basic = 10,
        tank = 16,
        swift = 8,
        sentry = 22,
        centurion = 30,
        exploder = 12
    }
    exploderAoEs = {}
end

--- Create an enemy and place it on the game field.
---@param hp number The amount of health points the enemy has.
---@param speed number The speed at which the enemy moves on the game field.
---@param attackSpeed number How fast the enemy attacks (times per second).
---@param attackDamage number The damage the enemy deals when attacking.
function enemyFuncs.createEnemy(hp, speed, attackSpeed, attackDamage)
    enemy = {}
    --[[ Make the enemy of basic, Sentry or Centurion type depending on wave and whether the enemy is last in the wave ]]--
    local typeChoose = love.math.random() * 100
    if enemyAttributes.pendingEnemies ~= 0 then
        if typeChoose <= enemyAttributes.spawn.tank then
            enemy.type = "tank"
        elseif typeChoose > enemyAttributes.spawn.tank and typeChoose <= (enemyAttributes.spawn.tank + enemyAttributes.spawn.swift) then
            enemy.type = "swift"
        elseif typeChoose > (enemyAttributes.spawn.tank + enemyAttributes.spawn.swift) and typeChoose <= (enemyAttributes.spawn.tank + enemyAttributes.spawn.swift + enemyAttributes.spawn.exploder) then
            enemy.type = "exploder"
            enemy.state = "alive"
            enemy.explodeTimer = 0
        elseif typeChoose > (enemyAttributes.spawn.tank + enemyAttributes.spawn.swift + enemyAttributes.spawn.exploder) then
            enemy.type = "basic"
        end
    end

    enemy.animationFrame = 1
    enemy.burningTime = 0
    enemy.burningUntilDamage = 1
    enemy.hitByExploderIDs = {}

    if gameplay.wave % 10 == 0 and gameplay.wave % 100 ~= 0 and enemyAttributes.pendingEnemies == 1 then
        enemy.type = "sentry"
    end

    if gameplay.wave % 100 == 0 and enemyAttributes.pendingEnemies == 1 then
        enemy.type = "centurion"
    end

    if enemy.type == "basic" then
        enemy.maxHP = hp
        enemy.currentHP = enemy.maxHP
        enemy.attackSpeed = attackSpeed
        enemy.attackDamage = attackDamage
        enemy.speed = speed
        enemy.resistanceIgnore = false
        enemy.shieldIgnore = false

    elseif enemy.type == "tank" then
        enemy.maxHP = hp * 5
        enemy.currentHP = enemy.maxHP
        enemy.attackSpeed = attackSpeed * 0.9
        enemy.attackDamage = attackDamage * 1.2
        enemy.speed = speed * 0.8
        enemy.resistanceIgnore = false
        enemy.shieldIgnore = false

    elseif enemy.type == "swift" then
        enemy.maxHP = hp * 0.75
        enemy.currentHP = enemy.maxHP
        enemy.attackSpeed = attackSpeed * 1.5
        enemy.attackDamage = attackDamage
        enemy.speed = speed * 2
        enemy.resistanceIgnore = false
        enemy.shieldIgnore = false
        
    elseif enemy.type == "sentry" then
        enemy.maxHP = hp * (10 + math.floor((gameplay.wave - 10) / 10) * 2.5)
        enemy.currentHP = enemy.maxHP
        enemy.attackSpeed = attackSpeed * 0.75
        enemy.attackDamage = attackDamage * 4
        sentryAlive = true
        sentryMaxHP = enemy.maxHP
        sentryCurrentHP = enemy.maxHP
        enemy.speed = speed * 0.6
        enemy.resistanceIgnore = false
        enemy.shieldIgnore = false

    elseif enemy.type == "centurion" then
        enemy.maxHP = hp * 256
        enemy.currentHP = enemy.maxHP
        enemy.attackSpeed = attackSpeed * 0.5
        enemy.attackDamage = attackDamage * 10
        centurionAlive = true
        centurionMaxHP = enemy.maxHP
        centurionCurrentHP = enemy.maxHP
        enemy.speed = speed * 0.5
        enemy.resistanceIgnore = false
        enemy.shieldIgnore = true

    elseif enemy.type == "exploder" then
        enemy.maxHP = hp
        enemy.currentHP = enemy.maxHP
        enemy.attackSpeed = attackSpeed
        enemy.attackDamage = attackDamage * 2.5
        enemy.speed = speed
        enemy.resistanceIgnore = false
        enemy.shieldIgnore = false
    end

    local attempts = 0
    enemy.x = love.math.random(-202 - enemyOffsets[enemy.type] * 2, 2118 + enemyOffsets[enemy.type] * 2)
    enemy.y = love.math.random(-202 - enemyOffsets[enemy.type] * 2, 1278 + enemyOffsets[enemy.type] * 2)
    while enemy.x - enemyOffsets[enemy.type] * 2 > 0 or enemy.x + enemyOffsets[enemy.type] * 2 < 1920 and enemy.y - enemyOffsets[enemy.type] * 2 > 0 or enemy.y + enemyOffsets[enemy.type] * 2 < 1080 do
        attempts = attempts + 1
        enemy.x = love.math.random(-202 - enemyOffsets[enemy.type] * 2, 2118 + enemyOffsets[enemy.type] * 2)
        enemy.y = love.math.random(-202 - enemyOffsets[enemy.type] * 2, 1278 + enemyOffsets[enemy.type] * 2)
        if enemy.x + enemyOffsets[enemy.type] * 2 < 0 or enemy.x - enemyOffsets[enemy.type] * 2 > 1920 or enemy.y + enemyOffsets[enemy.type] * 2 < 0 or enemy.y - enemyOffsets[enemy.type] * 2 > 1080 then
            break
        end
    end
    enemy.timer_untilAttack = 0
    table.insert(enemiesOnField, enemy)
end

--- Find the closest enemy within the specified range, returns nil if no enemies are within.
function enemyFuncs.findClosestEnemyInRange(x, y, range)

    table.sort(enemiesOnField, function(a, b)
        return math.dist(x, y, a.x + enemyOffsets[a.type], a.y + enemyOffsets[a.type]) < math.dist(x, y, b.x + enemyOffsets[b.type], b.y + enemyOffsets[b.type])
    end)
    local enemiesSorted = {}
    for i,v in ipairs(enemiesOnField) do
        if math.dist(x, y, v.x + enemyOffsets[v.type], v.y + enemyOffsets[v.type]) < range then
            table.insert(enemiesSorted, v)
        end
    end
    closestEnemies = enemiesSorted
    return enemiesSorted
end

--- Draw the Sentry boss bar if the Sentry is alive.
function enemyFuncs.drawSentryBossbar()
    love.graphics.setFont(font_VeraBold16)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf(string.format("Sentry - Wave %d", gameplay.wave), 810, 12, 300, "center")
    love.graphics.setColor(0.66, 0, 0, 1)
    love.graphics.rectangle("fill", 806, 36, 308, 28)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", 810, 40, 300, 20)
    love.graphics.setColor(0, 0.5, 0.2, 1)
    love.graphics.rectangle("fill", 810, 40, (sentryCurrentHP/sentryMaxHP * 300), 20)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf(string.format("%s/%s", notations.convertToLetterNotation(sentryCurrentHP, "precise"), notations.convertToLetterNotation(sentryMaxHP, "precise")), 810, 40, 300, "center")
end

--- Draw the Centurion boss bar if the Centurion is alive.
function enemyFuncs.drawCenturionBossbar()
    love.graphics.setFont(font_VeraBold16)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf(string.format("Centurion - Wave %d", gameplay.wave), 810, 12, 300, "center")
    love.graphics.setColor(0.66, 0, 0, 1)
    love.graphics.rectangle("fill", 806, 36, 308, 28)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", 810, 40, 300, 20)
    love.graphics.setColor(0, 0.5, 0.2, 1)
    love.graphics.rectangle("fill", 810, 40, (centurionCurrentHP/centurionMaxHP * 300), 20)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf(string.format("%s/%s", notations.convertToLetterNotation(centurionCurrentHP, "precise"), notations.convertToLetterNotation(centurionMaxHP, "precise")), 810, 40, 300, "center")
end

--- Kill the specified enemy by adding its drops to the player's resources, removing the enemy from the game field and creating some kill particles.
---@param s number The enemy to be killed.
function enemyFuncs.killEnemy(s, damageSource)
    local ke = enemiesOnField[s]
    local copper = {
        basic = 1,
        tank = 4,
        swift = 4,
        sentry = 25,
        centurion = 80,
        exploder = 5,
        }

    local silver = {
        basic = 0,
        tank = 1,
        swift = 1,
        sentry = 10,
        centurion = 50,
        exploder = 2,
        }
        
    local gold = {
        basic = 0,
        tank = 0,
        swift = 0,
        sentry = 1,
        centurion = 15,
        exploder = 0
        }

    local particleAmount = {
        basic = 8,
        tank = 12,
        swift = 12,
        sentry = 24,
        centurion = 32,
        exploder = 16
        }
    for i=1,particleAmount[ke.type] * settings_particleMultipliers[player.settings.particleMultiplierIndex] or 0 do
        createKillParticle(ke.x + enemyOffsets[ke.type], ke.y + enemyOffsets[ke.type], ke.type)
    end

    if damageSource ~= "exploder" then
        local oldCopperAmount = player.currencies.currentCopper
        misc.copperBuffer = misc.copperBuffer + (player.tower.copperBonus % 1) * copper[ke.type]
        player.currencies.currentCopper = player.currencies.currentCopper + math.floor(player.tower.copperBonus) * copper[ke.type]
        if misc.copperBuffer >= 1 then
            player.currencies.currentCopper = player.currencies.currentCopper + math.floor(misc.copperBuffer)
            misc.copperBuffer = misc.copperBuffer - math.floor(misc.copperBuffer)
        end
        local newCopperAmount = player.currencies.currentCopper
        local copperEarned = newCopperAmount - oldCopperAmount
        player.stats.battle.copperEarned = player.stats.battle.copperEarned + copperEarned

        local oldSilverAmount = player.currencies.currentSilver
        misc.silverBuffer = misc.silverBuffer + (player.tower.silverBonus % 1) * silver[ke.type] * difficultyMultipliers[gameplay.difficulty]
        player.currencies.currentSilver = player.currencies.currentSilver + math.floor(player.tower.silverBonus) * silver[ke.type] * difficultyMultipliers[gameplay.difficulty]
        if misc.silverBuffer >= 1 then
            player.currencies.currentSilver = player.currencies.currentSilver + math.floor(misc.silverBuffer)
            misc.silverBuffer = misc.silverBuffer - math.floor(misc.silverBuffer)
        end
        local newSilverAmount = player.currencies.currentSilver
        local silverEarned = newSilverAmount - oldSilverAmount
        player.stats.battle.silverEarned = player.stats.battle.silverEarned + silverEarned

        player.currencies.currentGold = player.currencies.currentGold + gold[ke.type]
        player.stats.battle.goldEarned = player.stats.battle.goldEarned + gold[ke.type]
        player.stats.save.goldEarned = player.stats.save.goldEarned + gold[ke.type]
        player.stats.battle.enemiesKilled = player.stats.battle.enemiesKilled + 1
        player.stats.save.enemiesKilled = player.stats.save.enemiesKilled + 1
    end
    if ke.type == "sentry" then
        sentryAlive = false
        local s = audio_enemy_kill_sentry:clone()
        s:setVolume(1 * player.settings.volume^2)
        s:play()
    elseif ke.type == "centurion" then
        centurionAlive = false
        local c = audio_enemy_kill_centurion:clone()
        c:setVolume(1 * player.settings.volume^2)
        c:play()
    elseif ke.type == "exploder" then
        local e = audio_enemy_kill_exploder:clone()
        e:setVolume(1 * player.settings.volume^2)
        e:play()
    else
        local m = audio_enemy_kill:clone()
        m:setVolume(1 * player.settings.volume^2)
        m:play()
    end
    if ke.type == "exploder" then
        local exploderAoE = {}
        exploderAoE.x = ke.x
        exploderAoE.y = ke.y
        exploderAoE.timer = 0
        exploderAoE.id = love.math.random(1, 65535)
        table.insert(exploderAoEs, exploderAoE)
    end
    player.stats.wave.enemiesKilled = player.stats.wave.enemiesKilled + 1
    if damageSource == "spikedCrystal" then
        player.stats.battle.spikedCrystals.enemiesKilled = player.stats.battle.spikedCrystals.enemiesKilled + 1
        player.stats.save.spikedCrystals.enemiesKilled = player.stats.save.spikedCrystals.enemiesKilled + 1
    elseif damageSource == "magmaPool" then
        player.stats.battle.magmaTouch.enemiesKilled = player.stats.battle.magmaTouch.enemiesKilled + 1
        player.stats.save.magmaTouch.enemiesKilled = player.stats.save.magmaTouch.enemiesKilled + 1
    elseif damageSource == "lightningOrb" then
        player.stats.battle.lightningOrb.enemiesKilled = player.stats.battle.lightningOrb.enemiesKilled + 1
        player.stats.save.lightningOrb.enemiesKilled = player.stats.save.lightningOrb.enemiesKilled + 1
    elseif damageSource == "disruptWave" then
        player.stats.battle.disruptWave.enemiesKilled = player.stats.battle.disruptWave.enemiesKilled + 1
        player.stats.save.disruptWave.enemiesKilled = player.stats.save.disruptWave.enemiesKilled + 1
    end
    table.remove(enemiesOnField, s)
end

--- Damage an enemy and create a Hit text particle.
---@param s number The enemy to be damaged.
---@param damage number Amount of damage to deal to the enemy.
---@param crit boolean Whether this hit is a Critical one or not.
function enemyFuncs.damageEnemy(s, damage, crit, superCrit, damageSource)
    local de = enemiesOnField[s]
    if damageSource ~= "lightningOrb" then
        createHitTextParticle(de.x, de.y, notations.convertToLetterNotation(math.min(de.currentHP, damage), "precise"), de.type, crit, superCrit)
    end
    if damageSource ~= "exploder" then
        player.stats.battle.damageDealt = player.stats.battle.damageDealt + math.min(damage, de.currentHP)
        player.stats.save.damageDealt = player.stats.save.damageDealt + math.min(damage, de.currentHP)
    end
    if superCrit then
        player.stats.battle.supercritical.triggered = player.stats.battle.supercritical.triggered + 1
        player.stats.battle.supercritical.damageDealt = player.stats.battle.supercritical.damageDealt + math.min(damage, de.currentHP)
        player.stats.save.supercritical.triggered = player.stats.save.supercritical.triggered + 1
        player.stats.save.supercritical.damageDealt = player.stats.save.supercritical.damageDealt + math.min(damage, de.currentHP)
    end
    if damageSource == "spikedCrystal" then
        player.stats.battle.spikedCrystals.damageDealt = player.stats.battle.spikedCrystals.damageDealt + math.min(damage, de.currentHP)
        player.stats.save.spikedCrystals.damageDealt = player.stats.save.spikedCrystals.damageDealt + math.min(damage, de.currentHP)
    elseif damageSource == "magmaPool" then
        player.stats.battle.magmaTouch.damageDealt = player.stats.battle.magmaTouch.damageDealt + math.min(damage, de.currentHP)
        player.stats.save.magmaTouch.damageDealt = player.stats.save.magmaTouch.damageDealt + math.min(damage, de.currentHP)
    elseif damageSource == "lightningOrb" then
        player.stats.battle.lightningOrb.damageDealt = player.stats.battle.lightningOrb.damageDealt + math.min(damage, de.currentHP)
        player.stats.save.lightningOrb.damageDealt = player.stats.save.lightningOrb.damageDealt + math.min(damage, de.currentHP)
    elseif damageSource == "disruptWave" then
        player.stats.battle.disruptWave.damageDealt = player.stats.battle.disruptWave.damageDealt + math.min(damage, de.currentHP)
        player.stats.save.disruptWave.damageDealt = player.stats.save.disruptWave.damageDealt + math.min(damage, de.currentHP)
    end
    de.currentHP = de.currentHP - damage
    if de.type == "sentry" then
        sentryCurrentHP = de.currentHP
    elseif type == "centurion" then
        centurionCurrentHP = de.currentHP
    end
    if de.currentHP <= 0 then
        enemyFuncs.killEnemy(s, damageSource)
    end
end

--- Update enemy spawn rate, spawn cap, attack damage, spawn chances, health and speed, together with the wave cooldown.
---@param difficulty number The difficulty which the enemy stats update to.
---@param wave number The wave which the enemy stats update to.
function enemyFuncs.updateEnemyStats(difficulty, wave)
    local waveCooldowns = {6, 5, 4, 3.5, 3}
    enemyAttributes = {}
    enemyAttributes.spawn = {}
    local pendingEnemies = 0
    local tankSpawnChance = 0
    local swiftSpawnChance = 0
    local exploderSpawnChance = 100
    if difficulty == 1 then
        --[[ Set stats for Level 0 enemies ]]--
        enemyAttributes.spawnRate = 0.5 + (math.floor(0.3 * math.sqrt(0.1 * wave) * 10) / 10)
        pendingEnemies = 5 + math.floor(math.sqrt(6 * wave))
        enemyAttributes.health = (1.95 + 1/20 * (1.25 * wave)^2.5 - 0.037) * 1.2 ^ math.floor(wave / 100)
        enemyAttributes.attackDamage = (0.875 + wave^2.25 / 40 + 0.1 * wave^2) * 1.1 ^ math.floor(wave / 100)
        tankSpawnChance = math.min(math.floor(math.log(wave^2, 10) * 100) / 100, 4)
        swiftSpawnChance = math.min(math.floor(math.log(wave^3, 10) * 100) / 100, 6)
    elseif difficulty == 2 then
        --[[ Set stats for Level α enemies ]]--
        enemyAttributes.spawnRate = 0.9 + (math.floor(0.12 * math.sqrt(wave) * 10)) / 10
        pendingEnemies = 7 + math.floor(3 * math.sqrt(1.2 * wave))
        enemyAttributes.health = (243.95 + 4 * wave^2 + 2.05 * wave^3) * 1.23 ^ math.floor(wave / 100)
        enemyAttributes.attackDamage = (70.73 + 9 * wave + 0.279 * wave^3) * 1.13 ^ math.floor(wave / 100)
        tankSpawnChance = math.min(math.floor((math.log(wave^5, 10))^0.75 * 100) / 100, 6)
        swiftSpawnChance = math.min(math.floor(math.log(wave^3.75, 10) * 100) / 100, 8)
        exploderSpawnChance = math.min(0.01 * wave, 1.5)
    elseif difficulty == 3 then
        --[[ Set stats for Level β enemies ]]--
        enemyAttributes.spawnRate = 1.3 + (math.floor((0.2 * wave) / (math.sqrt(1.75 * wave))) * 10) / 10
        pendingEnemies = 10 + 2 * math.floor((math.sqrt(17 * wave)) / 2)
        enemyAttributes.health = (1935.99 + (6 * wave)^2.2 + wave^3.2 / 10 * 125) * 1.26 ^ math.floor(wave / 100)
        enemyAttributes.attackDamage = (449.59 + 30 * wave + 0.411 * wave^3.45) * 1.16 ^ math.floor(wave / 100)
        tankSpawnChance = math.min(math.floor((math.sqrt(2.5 * wave - 2.5)^0.8) * 100) / 100, 10)
        swiftSpawnChance = math.min(math.floor((math.sqrt(2 * wave - 2) - math.log(wave^3, 10)) * 100) / 100, 12.5)
        exploderSpawnChance = math.min(0.014 * wave, 2.4)
    elseif difficulty == 4 then
        --[[ Set stats for Level γ enemies ]]--
        enemyAttributes.spawnRate = 1.8 + (math.floor(math.sqrt(0.04 * wave) * 10)) / 10
        pendingEnemies = 14 + 2 * math.floor((3 * math.sqrt(2.75 * wave)) / 2)
        enemyAttributes.health = (17791.09 + (8 * wave)^2.48 + 35.269 * wave^3.6) * 1.29 ^ math.floor(wave / 100)
        enemyAttributes.attackDamage = (3534.97 + 65 * wave^1.5 + 3 * wave^3.6) * 1.19 ^ math.floor(wave / 100)
        tankSpawnChance = math.min(math.floor((math.sqrt(4 * wave - 4)^0.85) * 100) / 100, 14)
        swiftSpawnChance = math.min(math.floor((math.sqrt(2 * wave - 2)^1.05) * 100) / 100, 18)
        exploderSpawnChance = math.min(0.019 * wave, 3)
    elseif difficulty == 5 then
        --[[ Set stats for Difficulty 5 enemies ]]--
        enemyAttributes.spawnRate = 2.2 + (math.floor(math.sqrt(0.05 * (wave+5)) * 10)) / 10
        pendingEnemies = 19 + 2 * math.floor((3 * math.sqrt(3 * wave)) / 1.9)
        enemyAttributes.health = (189391.18 + (14 * wave)^2.6 + 295.5 * (1/8 * (wave + 4)^3.9)) * 1.32 ^ math.floor(wave / 100)
        enemyAttributes.attackDamage = (7317.29 + 75 * wave^2.15 + 8.4 * (wave + 5)^3.8) * 1.22 ^ math.floor(wave / 100)
        tankSpawnChance = math.min(1.1 + math.floor((math.sqrt(4 * wave - 4)^0.85) * 100) / 100, 14)
        swiftSpawnChance = math.min(1.5 + math.floor((math.sqrt(2 * wave - 2)^1.05) * 100) / 100, 18)
        exploderSpawnChance = math.min(0.035 * wave, 5)
    end
    player.timers.nextWave = 0
    gameplay.waveCooldown = waveCooldowns[gameplay.difficulty]
    player.stats.wave.enemiesKilled = 0
    enemyAttributes.speed = 70
    enemyAttributes.pendingEnemies = pendingEnemies
    enemyAttributes.waveCap = pendingEnemies
    enemyAttributes.spawn.tank = tankSpawnChance
    enemyAttributes.spawn.swift = swiftSpawnChance
    enemyAttributes.spawn.exploder = exploderSpawnChance
    enemyAttributes.spawn.basic = 100 - (tankSpawnChance + swiftSpawnChance + exploderSpawnChance)
end