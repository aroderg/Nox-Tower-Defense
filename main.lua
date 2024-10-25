function love.load()
    lume = require "lume"
    require "loadGame"
    require "saveGame"
    require "towerInfo"
    require "upgradeMenu"
    require "particles"
    require "tooltips"
    require "gameOver"
    require "hub"
    electrumAlloying = false
    upgradeMenu = false
    settings = false
    hubSection = "Main"
    roundUpgradeSection = "ATK"
    gameSpeed = 1
    function assetReload()
        --[[ Reload all images ]]--
        img_background = love.graphics.newImage("assets/background.png")
        img_background_stellar = love.graphics.newImage("assets/background_stellar.png")
        img_currency_copper = love.graphics.newImage("assets/currency_copper.png")
        img_currency_silver = love.graphics.newImage("assets/currency_silver.png")
        img_currency_gold = love.graphics.newImage("assets/currency_gold.png")
        img_currency_electrum = love.graphics.newImage("assets/currency_electrum.png")
        img_currency_token = love.graphics.newImage("assets/currency_token.png")
        img_currency_token_big = love.graphics.newImage("assets/currency_token_big.png")
        img_tower_main = love.graphics.newImage("assets/tower_main.png")
        img_tower_main_shielded = love.graphics.newImage("assets/tower_main_shielded.png")
        img_tower_projectile = love.graphics.newImage("assets/tower_projectile.png")
        img_enemy_basic = love.graphics.newImage("assets/enemy_basic.png")
        img_enemy_tank = love.graphics.newImage("assets/enemy_tank.png")
        img_enemy_swift = love.graphics.newImage("assets/enemy_swift.png")
        img_enemy_sentry = love.graphics.newImage("assets/enemy_sentry.png")
        img_enemy_centurion = love.graphics.newImage("assets/enemy_centurion.png")
        img_icon_enemy_health = love.graphics.newImage("assets/icon_enemy_health.png")
        img_icon_enemy_attack = love.graphics.newImage("assets/icon_enemy_attack.png")
        img_icon_player_attack = love.graphics.newImage("assets/icon_player_attack.png")
        img_particle_collapse = love.graphics.newImage("assets/particle_collapse.png")
        img_particle_kill_enemy_basic = love.graphics.newImage("assets/particle_kill_enemy_basic.png")
        img_particle_kill_enemy_tank = love.graphics.newImage("assets/particle_kill_enemy_tank.png")
        img_particle_kill_enemy_swift = love.graphics.newImage("assets/particle_kill_enemy_swift.png")
        img_particle_kill_enemy_sentry = love.graphics.newImage("assets/particle_kill_enemy_sentry.png")
        img_particle_kill_enemy_centurion = love.graphics.newImage("assets/particle_kill_enemy_centurion.png")
        img_button_pause = love.graphics.newImage("assets/button_pause.png")
        img_button_arrowLeft = love.graphics.newImage("assets/button_arrowLeft.png")
        img_button_arrowRight = love.graphics.newImage("assets/button_arrowRight.png")
        img_meteor = love.graphics.newImage("assets/meteor.png")
    end 
    font_Vera12 = love.graphics.newFont("assets/fonts/Vera/Vera.ttf", 12)
    font_Vera16 = love.graphics.newFont("assets/fonts/Vera/Vera.ttf", 16)
    font_VeraBold16 = love.graphics.newFont("assets/fonts/Vera/VeraBd.ttf", 16)
    font_VeraBold18 = love.graphics.newFont("assets/fonts/Vera/VeraBd.ttf", 18)
    font_VeraBold24 = love.graphics.newFont("assets/fonts/Vera/VeraBd.ttf", 24)
    font_Afacad12 = love.graphics.newFont("assets/fonts/Afacad Flux/AfacadFlux-Regular.ttf", 12)
    font_Afacad16 = love.graphics.newFont("assets/fonts/Afacad Flux/AfacadFlux-Regular.ttf", 16)
    font_Afacad20 = love.graphics.newFont("assets/fonts/Afacad Flux/AfacadFlux-Regular.ttf", 20)
    font_Afacad24 = love.graphics.newFont("assets/fonts/Afacad Flux/AfacadFlux-Regular.ttf", 24)
    font_Afacad28 = love.graphics.newFont("assets/fonts/Afacad Flux/AfacadFlux-Regular.ttf", 28)
    font_AfacadBold20 = love.graphics.newFont("assets/fonts/Afacad Flux/AfacadFlux-Bold.ttf", 20)
    font_AfacadBold24 = love.graphics.newFont("assets/fonts/Afacad Flux/AfacadFlux-Bold.ttf", 24)
    font_AfacadBold28 = love.graphics.newFont("assets/fonts/Afacad Flux/AfacadFlux-Bold.ttf", 28)
    font_AfacadBold32 = love.graphics.newFont("assets/fonts/Afacad Flux/AfacadFlux-Bold.ttf", 32)
    font_AfacadBold48 = love.graphics.newFont("assets/fonts/Afacad Flux/AfacadFlux-Bold.ttf", 48)
    font_ViraSansBold20 = love.graphics.newFont("assets/fonts/Fira Sans/FiraSans-Bold.ttf", 20)
    font_ViraSansBold28 = love.graphics.newFont("assets/fonts/Fira Sans/FiraSans-Bold.ttf", 28)
    love.graphics.setLineStyle("rough")
    settings_particleMultiplierNames = {"None", "Minimal", "Reduced", "Normal", "Rich", "Fancy", "Fabulous", "Stormful"}
    settings_notationNames = {"kmbt", "e", "alphabet"}
    settings_particleMultipliers = {0, 0.25, 0.75, 1, 1.5, 2, 3, 5}
    levelNames = {"0", "α", "β", "γ"}
    difficultyMultipliers = {1, 1.75, 2.5, 3.75}
    gameplay_difficulty = 1
    assetReload()
    loadGame()
    resetRoundValues()
end

function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end

notations = {
    numbers = {
        kmbt = {"K", "M", "B", "T"},
        e = {"e3", "e6", "e9", "e12"},
        alphabet = {"a", "b", "c", "d"},
    },
    kmbt = {},
    e = {},
    alphabet = {}
    }

function notations.getLetterForNumber(x)
    if x >= 1000 then
        if settings_notation == "kmbt" then
            return notations.numbers.kmbt[math.floor(math.log(x, 10) / 3)]
        elseif settings_notation == "e" then
            return notations.numbers.e[math.floor(math.log(x, 10) / 3)]
        elseif settings_notation == "alphabet" then
            return notations.numbers.alphabet[math.floor(math.log(x, 10) / 3)]
        end
    else
        return nil
    end
end

function notations.formatLargeNumber(x)
    if x >= 1000 then
        return x / 1000^math.floor(math.log(x, 10) / 3)
    else
        return x
    end
end

function notations.convertToLetterNotation(x, precision)
    if x <= 1000 then
        if precision == "precise2" then
            return string.format("%.2f", notations.formatLargeNumber(x))
        elseif precision == "precise" then
            return string.format("%.1f", notations.formatLargeNumber(x))
        elseif precision == "brief" then
            return string.format("%d", notations.formatLargeNumber(x))
        end
    else
        return string.format("%.2f%s", notations.formatLargeNumber(x), notations.getLetterForNumber(x))
    end
end

processUpgradeModule = {}
function processUpgradeModule.draw(upgName, x, y, valueVar, costVar, levelVar, type, maxLevel, precision, prefix, suffix)
    --[[ Draw the upgrade module given the upgrade name and coordinates, together with the variables used to store cost and value ]]--
    love.graphics.setColor(0, 0.1, 0.2, 1)
    love.graphics.rectangle("fill", x, y, 350, 60)
    love.graphics.setColor(0.1, 0.55, 0.98, 1)
    love.graphics.rectangle("line", x, y, 350, 60)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(font_Afacad20)
    love.graphics.print(string.format("%s: %s%s%s", upgName or "Upgrade Name", prefix or "", notations.convertToLetterNotation(valueVar, precision), suffix or ""), x + 5, y + 15)
    love.graphics.setColor(0.05, 0.35, 0.45, 1)
    love.graphics.rectangle("fill", x + 257, y + 3, 90, 54)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle("line", x + 257, y + 3, 90, 54)
    local maxLevel = maxLevel or math.huge
    if levelVar < maxLevel then
        if type == "round" then
            love.graphics.draw(img_currency_copper, x + 261, y + 18, 0, 20/32)
        else
            love.graphics.draw(img_currency_silver, x + 261, y + 18, 0, 20/32)
        end
        love.graphics.print(string.format("%s", notations.convertToLetterNotation(costVar, "brief")), x + 280, y + 15)
    else
        love.graphics.printf("Max", x + 257, y + 15, 90, "center")
    end
end
function processUpgradeModule.click(x, y, ux, uy, upgValue, upgLevel, upgCost, costFormula, type, maxLevel, valueFormula)
    if x >= ux and x <= ux + 80 and y >= uy and y <= uy + 54 then
        if currentSilver >= upgCost and type == "science" and upgLevel < maxLevel then
            currentSilver = currentSilver - upgCost
            upgCost = math.floor(costFormula)
            upgValue = valueFormula
        end
        return upgCost, upgLevel + 1, upgValue
    end
    return upgCost, upgLevel, upgValue
end

processUnlockPanel = {}
function processUnlockPanel.draw(upgName, x, y, upgUnlockVar, cost)
    --[[ Display an "Unlock" panel if upgrades are not unlocked ]]--
    love.graphics.setColor(0, 0.1, 0.2, 1)
    love.graphics.rectangle("fill", x, y, 620, 60)
    love.graphics.setColor(0.1, 0.55, 0.98, 1)
    love.graphics.rectangle("line", x, y, 620, 60)
    love.graphics.setFont(font_Afacad20)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf("Unlock " .. upgName .. " upgrades", x, y + 15, 537, "center")
    love.graphics.setColor(0.05, 0.35, 0.45, 1)
    love.graphics.rectangle("fill", x + 537, y + 3, 80, 54)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle("line", x + 537, y + 3, 80, 54)
    love.graphics.draw(img_currency_electrum, x + 541, y + 18, 0, 20/32)
    love.graphics.print(cost, x + 560, y + 15)
end
function processUnlockPanel.click(x, y, ux, uy, upgUnlockVar, cost)
    --[[ Upgrade unlock ]]--
    if x >= ux and x <= ux + 80 and y >= uy and y <= uy + 54 and not upgUnlockVar then
        if currentElectrum >= cost then
            currentElectrum = currentElectrum - cost
            upgUnlockVar = true
            return upgUnlockVar
        end
    end
end

function createProjectile(x, y, angle, speed)
    --[[ Create a projectile that aims for the closest enemy in range, if no enemy is found then don't create the projectile ]]--
    findClosestEnemyInRange()
    if closestEnemies[1] ~= nil then
        projectile = {}
        if upgrade_unlock_crit then
            local isCrit = love.math.random(0, 10000) / 100
            if isCrit <= tower_value_critical_chance then
                projectile.isCrit = true
            else
                projectile.isCrit = false
            end
        end
        projectile.x = x
        projectile.y = y
        local offsets = {
            ["basic"] = 10,
            ["tank"] = 16,
            ["swift"] = 8,
            ["sentry"] = 22,
            ["centurion"] = 30,
            }
        projectile.angle = math.atan2(closestEnemies[1].y - 540 + offsets[closestEnemies[1].type], closestEnemies[1].x - 960 + offsets[closestEnemies[1].type])
        projectile.speed = speed
        table.insert(projectilesOnField, projectile)
    end
end

function createEnemy(hp, speed, attackSpeed, attackDamage)
    enemy = {}
    --[[ Make the enemy of basic, Sentry or Centurion type depending on wave and whether the enemy is last in the wave ]]--
    local typeChoose = love.math.random(0, 10000) / 100
    if pendingEnemies ~= 0 then
        if typeChoose <= enemy_spawnPercentage_tank then
            enemy.type = "tank"
        elseif typeChoose > enemy_spawnPercentage_tank and typeChoose <= (enemy_spawnPercentage_tank + enemy_spawnPercentage_swift) then
            enemy.type = "swift"
        elseif typeChoose > (enemy_spawnPercentage_tank + enemy_spawnPercentage_swift) then
            enemy.type = "basic"
        end
    end

    if gameplay_wave % 10 == 0 and gameplay_wave % 100 ~= 0 and pendingEnemies == 1 then
        enemy.type = "sentry"
    end

    if gameplay_wave % 100 == 0 and pendingEnemies == 1 then
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
        enemy.maxHP = hp * 3
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
        enemy.maxHP = hp * (10 + math.floor((gameplay_wave - 10) / 10) * 2.5)
        enemy.currentHP = enemy.maxHP
        enemy.attackSpeed = attackSpeed * 0.75
        enemy.attackDamage = attackDamage * 4
        sentryAlive = true
        sentryMaxHP = enemy.maxHP
        sentryCurrentHP = enemy.maxHP
        enemy.speed = speed * 0.6
        enemy.resistanceIgnore = false
        enemy.shieldIgnore = true

    elseif enemy.type == "centurion" then
        enemy.maxHP = hp * 256
        enemy.currentHP = enemy.maxHP
        enemy.attackSpeed = attackSpeed * 0.5
        enemy.attackDamage = attackDamage * 10
        centurionAlive = true
        centurionMaxHP = enemy.maxHP
        centurionCurrentHP = enemy.maxHP
        enemy.speed = speed * 0.5
        enemy.resistanceIgnore = true
        enemy.shieldIgnore = true
    end

    --[[ Set offsets to be half of the enemy's width/height ]]--
    local offsets = {
                    ["basic"] = 12,
                    ["tank"] = 16,
                    ["swift"] = 10,
                    ["sentry"] = 24,
                    ["centurion"] = 32,
            }
    local spawnproofRange = {
                    ["basic"] = 400,
                    ["tank"] = 400,
                    ["swift"] = 400,
                    ["sentry"] = 500,
                    ["centurion"] = 500,
            }

    --[[ Spawn an enemy if their position from the tower is further than the specified value, otherwise reroll ]]--
    enemy.x = love.math.random(-2, 1918 - offsets[enemy.type] * 2)
    enemy.y = love.math.random(-2, 1078 - offsets[enemy.type] * 2)
    while math.dist(enemy.x + offsets[enemy.type], enemy.y + offsets[enemy.type], 960, 540) <= spawnproofRange[enemy.type] do
        enemy.x = love.math.random(-2, 1918 - offsets[enemy.type])
        enemy.y = love.math.random(-2, 1078 - offsets[enemy.type])
        print(math.dist(enemy.x + offsets[enemy.type], enemy.y + offsets[enemy.type], 960, 540))
        if math.dist(enemy.x + offsets[enemy.type], enemy.y + offsets[enemy.type], 960, 540) > spawnproofRange[enemy.type] then
            break
        end
    end
    enemy.timer_untilAttack = 0
    table.insert(enemiesOnField, enemy)
end

function findClosestEnemyInRange()
    --[[ Find the closest enemy within the tower range, returns nil if no enemies are within the tower range ]]--
    local offsets = {
        ["basic"] = 12,
        ["tank"] = 18,
        ["swift"] = 10,
        ["sentry"] = 24,
        ["centurion"] = 32,
        }

    table.sort(enemiesOnField, function(a, b)
        return math.dist(960, 540, a.x + offsets[a.type], a.y + offsets[a.type]) < math.dist(960, 540, b.x + offsets[b.type], b.y + offsets[b.type])
    end)
    local enemiesSorted = {}
    for i,v in ipairs(enemiesOnField) do
        if math.dist(960, 540, v.x + offsets[v.type], v.y + offsets[v.type]) < tower_value_range then
            table.insert(enemiesSorted, v)
        end
    end
    closestEnemies = enemiesSorted
    return closestEnemies
end

function drawSentryBossbar()
    --[[ Draw a boss bar if the Sentry is alive ]]--
    love.graphics.setFont(font_VeraBold16)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf(string.format("Sentry - Wave %d", gameplay_wave), 810, 12, 300, "center")
    love.graphics.setColor(0.66, 0, 0, 1)
    love.graphics.rectangle("fill", 806, 36, 308, 28)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", 810, 40, 300, 20)
    love.graphics.setColor(0, 0.5, 0.2, 1)
    love.graphics.rectangle("fill", 810, 40, (sentryCurrentHP/sentryMaxHP * 300), 20)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf(string.format("%s/%s", notations.convertToLetterNotation(sentryCurrentHP, "precise"), notations.convertToLetterNotation(sentryMaxHP, "precise")), 810, 40, 300, "center")
end

function drawCenturionBossbar()
    --[[ Draw a boss bar if the Centurion is alive ]]--
    love.graphics.setFont(font_VeraBold16)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf(string.format("Centurion - Wave %d", gameplay_wave), 810, 12, 300, "center")
    love.graphics.setColor(0.66, 0, 0, 1)
    love.graphics.rectangle("fill", 806, 36, 308, 28)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", 810, 40, 300, 20)
    love.graphics.setColor(0, 0.5, 0.2, 1)
    love.graphics.rectangle("fill", 810, 40, (centurionCurrentHP/centurionMaxHP * 300), 20)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf(string.format("%s/%s", notations.convertToLetterNotation(centurionCurrentHP, "precise"), notations.convertToLetterNotation(centurionMaxHP, "precise")), 810, 40, 300, "center")
end

function createMeteor(angle)
    --[[ Create a meteor at initial coordinates ]]--
    meteor = {}
    meteor.angle = angle
    table.insert(meteors, meteor)
end

function skipWave(wavesSkipped)
    gameplay_wave = gameplay_wave + wavesSkipped
    gameplay_copperBuffer = gameplay_copperBuffer + (gameplay_copperBonus % 1) * gameplay_copperPerWave * wavesSkipped
    currentCopper = currentCopper + math.floor(gameplay_copperBonus) * gameplay_copperPerWave * wavesSkipped
    if gameplay_copperBuffer >= 1 then
        currentCopper = currentCopper + math.floor(gameplay_copperBuffer)
        gameplay_copperBuffer = gameplay_copperBuffer - math.floor(gameplay_copperBuffer)
    end

    gameplay_silverBuffer = gameplay_silverBuffer + (gameplay_silverBonus % 1) * gameplay_silverPerWave * wavesSkipped
    currentSilver = currentSilver + math.floor(gameplay_silverBonus) * gameplay_silverPerWave * wavesSkipped
    if gameplay_silverBuffer >= 1 then
        currentSilver = currentSilver + math.floor(gameplay_silverBuffer)
        gameplay_silverBuffer = gameplay_silverBuffer - math.floor(gameplay_silverBuffer)
    end
end

function killEnemy(x, y, type, copperDrop, silverDrop, goldDrop, particles)
    local offsets = {
        ["basic"] = 10,
        ["tank"] = 16,
        ["swift"] = 8,
        ["sentry"] = 22,
        ["centurion"] = 30,
        }
    for i=1,particles or 0 do
        createKillParticle(x + offsets[type], y + offsets[type], type)
    end

    gameplay_copperBuffer = gameplay_copperBuffer + (gameplay_copperBonus % 1) * copperDrop
    currentCopper = currentCopper + math.floor(gameplay_copperBonus) * copperDrop
    if gameplay_copperBuffer >= 1 then
        currentCopper = currentCopper + math.floor(gameplay_copperBuffer)
        gameplay_copperBuffer = gameplay_copperBuffer - math.floor(gameplay_copperBuffer)
    end

    gameplay_silverBuffer = gameplay_silverBuffer + (gameplay_silverBonus % 1) * silverDrop
    currentSilver = currentSilver + math.floor(gameplay_silverBonus) * silverDrop
    if gameplay_silverBuffer >= 1 then
        currentSilver = currentSilver + math.floor(gameplay_silverBuffer)
        gameplay_silverBuffer = gameplay_silverBuffer - math.floor(gameplay_silverBuffer)
    end

    currentGold = currentGold + goldDrop
    if type == "sentry" then
        sentryAlive = false
    elseif type == "centurion" then
        centurionAlive = false
    end
    enemiesKilledThisWave = enemiesKilledThisWave + 1
end

function updateEnemyStats(difficulty, wave)
    local waveCooldowns = {6, 5, 4, 3.5}
    if difficulty == 1 then
        --[[ Set stats for Level 0 enemies ]]--
        enemySpawnRate = 0.6 + math.floor(wave / 15) * 0.1
        pendingEnemies = 6 + math.floor(wave / 15) * 3
        enemy_value_health = (1.95 + (wave^2.25 / 20)) * (1.2^(math.floor(wave / 100)))
        enemy_value_attack_damage = (1 + (wave^2 / 40) - 0.024) * (1.1^math.floor(wave / 100))
        enemy_value_speed = 60
        enemy_spawnPercentage_tank = math.min(math.floor(math.log(wave^2, 10) * 100) / 100, 4)
        enemy_spawnPercentage_swift = math.min(math.floor(math.log(wave^3, 10) * 100) / 100, 6)
    elseif difficulty == 2 then
        --[[ Set stats for Level α enemies ]]--
        enemySpawnRate = 0.9 + math.floor(wave / 15) * 0.15
        pendingEnemies = 8 + math.floor(wave / 15) * 4
        enemy_value_health = (148.95 + wave^2 + (wave^3 / 20)) * (1.22^(math.floor(wave / 100)))
        enemy_value_attack_damage = (23.95 + wave + (wave^2.4 / 20)) * (1.11^math.floor(wave / 100))
        enemy_value_speed = 66
        enemy_spawnPercentage_tank = math.min(math.floor((math.log(wave^2, 10))^0.75 * 100) / 100, 6)
        enemy_spawnPercentage_swift = math.min(math.floor(math.log(wave^3.75, 10) * 100) / 100, 8)
    elseif difficulty == 3 then
        --[[ Set stats for Level β enemies ]]--
        enemySpawnRate = 1.4 + math.floor(wave / 15) * 0.225
        pendingEnemies = 11 + math.floor(wave / 15) * 5
        enemy_value_health = (21624.9 + 850 * wave + 25 * wave^2 + (wave^3.5 / 10)) * (1.24^(math.floor(wave / 100)))
        enemy_value_attack_damage = (708.95 + 90 * wave + wave^2 + (wave^2.9 / 20)) * (1.12^math.floor(wave / 100))
        enemy_value_speed = 72
        enemy_spawnPercentage_tank = math.min(math.floor((math.sqrt(2.5 * wave - 2.5)^0.8) * 100) / 100, 10)
        enemy_spawnPercentage_swift = math.min(math.floor((math.sqrt(2 * wave - 2) - math.log(wave^3, 10)) * 100) / 100, 12.5)
    elseif difficulty == 4 then
        --[[ Set stats for Level γ enemies ]]--
        enemySpawnRate = 1.8 + math.floor(wave / 15) * 0.3
        pendingEnemies = 13 + math.floor(wave / 15) * 6
        enemy_value_health = (475749.875 + 24000 * wave + 250 * wave^2 + (wave^4.28 / 8)) * (1.26^(math.floor(wave / 100)))
        enemy_value_attack_damage = (15099.9 + 900 * wave + (wave^3.4 / 5)) * (1.13^math.floor(wave / 100))
        enemy_value_speed = 78
        enemy_spawnPercentage_tank = math.min(math.floor((math.sqrt(4 * wave - 4)^0.85) * 100) / 100, 14)
        enemy_spawnPercentage_swift = math.min(math.floor((math.sqrt(2 * wave - 2)^1.05) * 100) / 100, 18)
    end
    enemyWaveCap = pendingEnemies
    enemy_spawnPercentage_basic = 100 - (enemy_spawnPercentage_tank + enemy_spawnPercentage_swift)
    gameplay_wave_cooldown = waveCooldowns[difficulty]
    gameplay_copperAdditionalEnemyDrop = math.floor(gameplay_wave / 15)
    timer_untilNextWave = 0
    enemiesKilledThisWave = 0
end

function love.draw()
    tooltips.general()
    if not inHub then
        love.graphics.setLineWidth(1)
        love.graphics.draw(img_background_stellar, 0, 0)
        if tower_value_currentHealth > 0 and not shieldActive then
            love.graphics.draw(img_tower_main, 928, 508)
        elseif tower_value_currentHealth > 0 and shieldActive then
            love.graphics.draw(img_tower_main_shielded, 928, 508)
        end
        love.graphics.setLineStyle("smooth")
        love.graphics.ellipse("line", 960, 540, tower_value_range, tower_value_range)
        love.graphics.setLineStyle("rough")
        love.graphics.setFont(font_Vera16)
        --[[ Print currency balances for Copper, Silver and Gold ]]--
        love.graphics.draw(img_currency_copper, 16, 16)
        love.graphics.printf(string.format("%s", notations.convertToLetterNotation(currentCopper, "brief")), 50, 23, 100, "left")
        love.graphics.draw(img_currency_silver, 16, 48)
        love.graphics.printf(string.format("%s", notations.convertToLetterNotation(currentSilver, "brief")), 50, 55, 100, "left")
        love.graphics.draw(img_currency_gold, 16, 80)
        love.graphics.printf(string.format("%s", notations.convertToLetterNotation(currentGold, "brief")), 50, 87, 100, "left")
        for i,v in ipairs(projectilesOnField) do
            love.graphics.draw(img_tower_projectile, v.x, v.y)
        end
        --[[ Different enemy types have different appearances ingame ]]--
        for i,v in ipairs(enemiesOnField) do
            if v.type == "basic" then
                love.graphics.draw(img_enemy_basic, v.x, v.y)
            elseif v.type == "tank" then
                love.graphics.draw(img_enemy_tank, v.x, v.y)
            elseif v.type == "swift" then
                love.graphics.draw(img_enemy_swift, v.x, v.y)
            elseif v.type == "sentry" then
                love.graphics.draw(img_enemy_sentry, v.x, v.y)
            elseif v.type == "centurion" then
                love.graphics.draw(img_enemy_centurion, v.x, v.y)
            end
        end
        love.graphics.setFont(font_VeraBold16)
        --[[ Display enemy and gameplay info ]]--
        --love.graphics.printf(string.format("Wave %d", gameplay_wave), 810, 1000, 300, "center")
        for i,v in ipairs(meteors) do
            love.graphics.draw(img_meteor, v.x - 14, v.y - 14)
        end
        renderParticles()
        drawUpgradeMenu()
        towerInfo_visual()
        if not settings and upgradeMenu then
            tooltips.displayRound()
        end
        love.graphics.setColor(1, 1, 1, 1)
        if sentryAlive then
            drawSentryBossbar()
        elseif centurionAlive then
            drawCenturionBossbar()
        end
        if skipWaveMessage and settings_waveSkipMessages then
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.setFont(font_Afacad20)
            if not upgradeMenu then
                love.graphics.printf({{1, 1, 1, 1}, "Skipped ", {0.35, 1, 0.75, 1}, string.format("%d ", wavesSkipped), {1, 1, 1, 1}, "wave", {1, 1, 1, 1}, string.format("%s!", wavesSkipped > 1 and "s" or "")}, 1710, 920, 200, "center")
            else
                love.graphics.printf({{1, 1, 1, 1}, "Skipped ", {0.35, 1, 0.75, 1}, string.format("%d ", wavesSkipped), {1, 1, 1, 1}, "wave", {1, 1, 1, 1}, string.format("%s!", wavesSkipped > 1 and "s" or "")}, 1710, 690, 200, "center")
            end
        end
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(img_button_pause, 1870, 10)
        love.graphics.setLineWidth(2)
        love.graphics.rectangle("line", 1870, 10, 40, 40, 3, 3)
        if paused then
            love.graphics.setColor(0, 0, 0, 0.5)
            love.graphics.rectangle("fill", 0, 0, 1920, 1080)
            love.graphics.setColor(0.2, 0, 0.35, 1)
            love.graphics.rectangle("fill", 710, 390, 500, 300)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.setFont(font_AfacadBold32)
            love.graphics.printf("Paused", 860, 400, 200, "center")

            love.graphics.setColor(0.1, 0.15, 0.5, 1)
            love.graphics.rectangle("fill", 890, 530, 140, 40)
            love.graphics.setColor(0.3, 0.75, 0.85, 1)
            love.graphics.setLineWidth(2)
            love.graphics.rectangle("line", 890, 530, 140, 40, 3, 3)
            love.graphics.setFont(font_Afacad24)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.printf("Settings", 870, 532, 180, "center")

            love.graphics.setColor(0.1, 0.15, 0.5, 1)
            love.graphics.rectangle("fill", 810, 610, 140, 60)
            love.graphics.setColor(0.3, 0.75, 0.85, 1)
            love.graphics.setLineWidth(2)
            love.graphics.rectangle("line", 810, 610, 140, 60, 3, 3)
            love.graphics.setFont(font_Afacad24)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.printf("Back to game", 810, 622, 140, "center")

            love.graphics.setColor(0.1, 0.15, 0.5, 1)
            love.graphics.rectangle("fill", 970, 610, 140, 60)
            love.graphics.setColor(0.3, 0.75, 0.85, 1)
            love.graphics.setLineWidth(2)
            love.graphics.rectangle("line", 970, 610, 140, 60, 3, 3)
            love.graphics.setFont(font_Afacad24)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.setColor(1, 0.2, 0.25, 1)
            love.graphics.printf("End Battle", 970, 622, 140, "center")

            if settings then
                love.graphics.setColor(0, 0, 0, 0.5)
                love.graphics.rectangle("fill", 0, 0, 1920, 1080)
                love.graphics.setColor(0.2, 0, 0.35, 1)
                love.graphics.rectangle("fill", 710, 240, 500, 600)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.setFont(font_AfacadBold32)
                love.graphics.printf("Settings", 860, 250, 200, "center")

                love.graphics.setFont(font_AfacadBold24)
                love.graphics.printf("Particles", 710, 300, 500, "center")
                love.graphics.setFont(font_Afacad20)
                love.graphics.printf(string.format("%s (x%.2f)", settings_particleMultiplierNames[settings_particleMultiplierIndex], settings_particleMultipliers[settings_particleMultiplierIndex]), 710, 330, 500, "center")
                if settings_particleMultiplierIndex > 1 then
                    love.graphics.draw(img_button_arrowLeft, 820, 332)
                end
                if settings_particleMultiplierIndex < 8 then
                    love.graphics.draw(img_button_arrowRight, 1076, 332)
                end

                love.graphics.setFont(font_AfacadBold24)
                love.graphics.printf("Wave Skip Messages", 710, 380, 500, "center")
                love.graphics.setFont(font_Afacad20)
                love.graphics.printf(string.format("%s", not settings_waveSkipMessages and "Off" or settings_waveSkipMessages and "On"), 710, 410, 500, "center")
                if settings_waveSkipMessages then
                    love.graphics.draw(img_button_arrowLeft, 820, 412)
                elseif not settings_waveSkipMessages then
                    love.graphics.draw(img_button_arrowRight, 1076, 412)
                end

                love.graphics.setFont(font_AfacadBold24)
                love.graphics.printf("Notation", 710, 460, 500, "center")
                love.graphics.setFont(font_Afacad20)
                love.graphics.printf(string.format("%s", settings_notation == settings_notationNames[1] and "KMBT" or settings_notation == settings_notationNames[2] and "Scientific" or "Alphabet"), 710, 490, 500, "center")
                if settings_notation ~= settings_notationNames[1] then
                    love.graphics.draw(img_button_arrowLeft, 820, 492)
                end
                if settings_notation ~= settings_notationNames[3] then
                    love.graphics.draw(img_button_arrowRight, 1076, 492)
                end

                love.graphics.setFont(font_AfacadBold24)
                love.graphics.printf("Tooltips", 710, 540, 500, "center")
                love.graphics.setFont(font_Afacad20)
                love.graphics.printf(string.format("%s", not settings_tooltips and "Off" or settings_tooltips and "On"), 710, 570, 500, "center")
                if settings_tooltips then
                    love.graphics.draw(img_button_arrowLeft, 820, 572)
                elseif not settings_tooltips then
                    love.graphics.draw(img_button_arrowRight, 1076, 572)
                end

                love.graphics.setColor(0.1, 0.15, 0.5, 1)
                love.graphics.rectangle("fill", 910, 780, 100, 40)
                love.graphics.setColor(0.3, 0.75, 0.85, 1)
                love.graphics.setLineWidth(2)
                love.graphics.rectangle("line", 910, 780, 100, 40, 3, 3)
                love.graphics.setFont(font_Afacad24)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.printf("Back", 910, 782, 100, "center")
            end
        end
        if #collapseParticles == 0 and tower_value_currentHealth <= 0 then
            menu_display_gameOver()
        end
    else
        inHub_visual()
        if hubSection == "Science" then
            tooltips.displayHub()
        end
    end
    love.graphics.setColor(1, 1, 1, 1)
end

function love.update(dt)
    if not inHub then
        --[[ Automatically shoot the closest enemy in range ]]--
        if timer_untilProjectile < 1 / tower_value_attack_speed then
            timer_untilProjectile = timer_untilProjectile + dt * gameSpeed
        else
            if closestEnemies[1] ~= nil then
                timer_untilProjectile = 0
                createProjectile(957, 537, love.math.random(0, 2 * math.pi * 1000) / 1000, 500)
            end
        end
        --[[ Spawn an enemy once the enemy spawn timer goes off ]]--
        if timer_untilEnemy < 1 / enemySpawnRate then
            timer_untilEnemy = timer_untilEnemy + dt * gameSpeed
        else
            timer_untilEnemy = 0
            if pendingEnemies > 0 then
                createEnemy(enemy_value_health, enemy_value_speed, enemy_value_attack_speed, enemy_value_attack_damage)
                pendingEnemies = pendingEnemies - 1
            end
        end
        if tower_value_currentHealth > 0 then
            findClosestEnemyInRange()
        end
        --[[ Move projectiles depending on their angle ]]--
        for i,v in ipairs(projectilesOnField) do
            v.x = v.x + math.cos(v.angle) * v.speed * dt * gameSpeed
            v.y = v.y + math.sin(v.angle) * v.speed * dt * gameSpeed
            if math.dist(960, 540, v.x + 3, v.y + 3) > tower_value_range then
                table.remove(projectilesOnField, i)
            end
            for j,w in ipairs(enemiesOnField) do
                local size = {
                    ["basic"] = 22,
                    ["tank"] = 34,
                    ["swift"] = 16,
                    ["sentry"] = 46,
                    ["centurion"] = 62,
                    }
                if v.x > w.x + 2 and v.x < w.x + size[w.type] and v.y > w.y + 2 and v.y < w.y + size[w.type] then
                    --[[ Detect collision of any projectile with any enemy, remove a part of enemy health if true, add 1 Copper if enemy is killed ]]--
                    table.remove(projectilesOnField, i)
                    --[[ If the projectile deals crit damage, deal more damage based on Critical Factor ]]--

                    local critFactor = v.isCrit and tower_value_critical_factor or 1
                    local damage = tower_value_attack_damage * critFactor
                    createHitTextParticle(w.x, w.y, notations.convertToLetterNotation(math.min(w.currentHP, damage), "precise"), w.type, v.isCrit)
                    w.currentHP = w.currentHP - damage

                    if w.type == "sentry" then
                        sentryCurrentHP = w.currentHP
                    elseif w.type == "centurion" then
                        centurionCurrentHP = w.currentHP
                    end

                    --[[ If enemy health is less or equal to 0, kill it by removing it from the field and adding its drop to player's resources ]]--
                    if w.currentHP <= 0 then
                        local copper = {
                            ["basic"] = 1,
                            ["tank"] = 4,
                            ["swift"] = 4,
                            ["sentry"] = 25,
                            ["centurion"] = 80
                            }

                        local silver = {
                            ["basic"] = 0,
                            ["tank"] = 1,
                            ["swift"] = 1,
                            ["sentry"] = 10,
                            ["centurion"] = 50
                            }
                            
                        local gold = {
                            ["basic"] = 0,
                            ["tank"] = 0,
                            ["swift"] = 0,
                            ["sentry"] = 1,
                            ["centurion"] = 15
                            }

                        local particleAmount = {
                            ["basic"] = 8,
                            ["tank"] = 12,
                            ["swift"] = 12,
                            ["sentry"] = 24,
                            ["centurion"] = 32
                            }

                        killEnemy(w.x, w.y, w.type, copper[w.type], silver[w.type] * difficultyMultipliers[gameplay_difficulty], gold[w.type], math.floor(particleAmount[w.type] * settings_particleMultipliers[settings_particleMultiplierIndex]))
                        table.remove(enemiesOnField, j)
                    end
                    closestEnemies[1] = nil
                end
            end
        end

        for i,v in ipairs(enemiesOnField) do
            local offsets = {
                ["basic"] = 10,
                ["tank"] = 16,
                ["swift"] = 8,
                ["sentry"] = 22,
                ["centurion"] = 30,
                }

            local stopDistance = {
                ["basic"] = 42,
                ["tank"] = 48,
                ["swift"] = 38,
                ["sentry"] = 58,
                ["centurion"] = 67
                }
            if v.timer_untilAttack < 1 / v.attackSpeed then
                v.timer_untilAttack = v.timer_untilAttack + dt * gameSpeed
            else
                --[[ If a Basic is close enough, start attacking the tower ]]--
                if math.dist(v.x + offsets[v.type] + 2, v.y + offsets[v.type] + 2, 960, 540) < stopDistance[v.type] + 1 and tower_value_currentHealth > 0 then
                    v.timer_untilAttack = 0
                    local damageReduction = not v.resistanceIgnore and 1 - tower_value_resistance / 100 or 1
                    if not v.shieldIgnore then
                        if not shieldActive then
                            tower_value_currentHealth = tower_value_currentHealth - v.attackDamage * damageReduction
                        end
                    elseif v.shieldIgnore then
                        tower_value_currentHealth = tower_value_currentHealth - v.attackDamage * damageReduction
                    end
                end
            end
            --[[ Move each enemy towards the central tower if it is further than the specified distance ]]--

            if math.dist(v.x + offsets[v.type] + 2, v.y + offsets[v.type] + 2, 960, 540) > stopDistance[v.type] then
                v.angle = math.atan2(540 - v.y - 2 - offsets[v.type], 960 - v.x - 2 - offsets[v.type])
                v.x = v.x + math.cos(v.angle) * v.speed * dt * gameSpeed
                v.y = v.y + math.sin(v.angle) * v.speed * dt * gameSpeed
            end
            --[[ Regenerate 1% of Centurion health per second ]]
            if v.type == "centurion" and tower_value_currentHealth > 0 then
                if v.currentHP < v.maxHP then
                    v.currentHP = v.currentHP + v.maxHP * (0.01 * dt * gameSpeed)
                    centurionCurrentHP = v.currentHP
                else
                    v.currentHP = v.maxHP
                    centurionCurrentHP = v.currentHP
                end
            end
        end

        for i,v in ipairs(meteors) do
            --[[ Orbit Meteors around the tower ]]--
            v.angle = v.angle + (tower_value_meteor_RPM * (2 * math.pi)) / 60 * dt * gameSpeed
            v.x = 960 + tower_value_range * math.cos(v.angle)
            v.y = 540 + tower_value_range * math.sin(v.angle)
            local size = {
                ["basic"] = 22,
                ["tank"] = 34,
                ["swift"] = 16,
                ["sentry"] = 46,
                ["centurion"] = 62,
                }
            for j,w in ipairs(enemiesOnField) do
                if v.x + 13 > w.x + 2 and v.x - 13 < w.x + size[w.type] and v.y + 13 > w.y + 2 and v.y - 13 < w.y + size[w.type] and tower_value_currentHealth > 0 then
                    if w.type == "basic" or w.type == "tank" or w.type == "swift" then
                        local copper = {
                            ["basic"] = 1,
                            ["tank"] = 2,
                            ["swift"] = 2,
                            ["sentry"] = 25,
                            ["centurion"] = 80
                            }

                        local silver = {
                            ["basic"] = 0,
                            ["tank"] = 1,
                            ["swift"] = 1,
                            ["sentry"] = 10,
                            ["centurion"] = 50
                            }
                            
                        local gold = {
                            ["basic"] = 0,
                            ["tank"] = 0,
                            ["swift"] = 0,
                            ["sentry"] = 1,
                            ["centurion"] = 15
                            }

                        local particleAmount = {
                            ["basic"] = 8,
                            ["tank"] = 12,
                            ["swift"] = 12,
                            ["sentry"] = 24,
                            ["centurion"] = 32
                            }

                        killEnemy(w.x, w.y, w.type, copper[w.type], silver[w.type] * difficultyMultipliers[gameplay_difficulty], gold[w.type], math.floor(particleAmount[w.type] * settings_particleMultipliers[settings_particleMultiplierIndex]))
                        table.remove(enemiesOnField, j)
                        closestEnemies[1] = nil
                    end
                end
            end
        end

        --[[ If no enemies on field are present and the wave enemy cap is reached, wait a few seconds before advancing to the next wave ]]--
        if tower_value_currentHealth > 0 then
            if #enemiesOnField == 0 and pendingEnemies <= 0 then
                if timer_untilNextWave < gameplay_wave_cooldown then
                    timer_untilNextWave = timer_untilNextWave + dt * gameSpeed
                else
                    wavesSkipped = 0

                    gameplay_copperBuffer = gameplay_copperBuffer + (gameplay_copperBonus % 1) * gameplay_copperPerWave
                    currentCopper = currentCopper + math.floor(gameplay_copperBonus) * gameplay_copperPerWave
                    if gameplay_copperBuffer >= 1 then
                        currentCopper = currentCopper + math.floor(gameplay_copperBuffer)
                        gameplay_copperBuffer = gameplay_copperBuffer - math.floor(gameplay_copperBuffer)
                    end

                    gameplay_silverBuffer = gameplay_silverBuffer + (gameplay_silverBonus % 1) * gameplay_silverPerWave * difficultyMultipliers[gameplay_difficulty]
                    currentSilver = currentSilver + math.floor(gameplay_silverBonus) * gameplay_silverPerWave * difficultyMultipliers[gameplay_difficulty]
                    if gameplay_silverBuffer >= 1 then
                        currentSilver = currentSilver + math.floor(gameplay_silverBuffer)
                        gameplay_silverBuffer = gameplay_silverBuffer - math.floor(gameplay_silverBuffer)
                    end

                    gameplay_wave = gameplay_wave + 1
                    local waveSkip = love.math.random(0, 10000) / 100
                    while waveSkip <= ability_waveSkip_chance do
                        wavesSkipped = wavesSkipped + 1
                        local waveSkip = love.math.random(0, 10000) / 100
                        if waveSkip > ability_waveSkip_chance then
                            break
                        end
                    end
                    skipWave(wavesSkipped)
                    if wavesSkipped > 0 then
                        skipWaveMessage = true
                    end
                    updateEnemyStats(gameplay_difficulty, gameplay_wave)
                end
            end
        end

        --[[ Regenerate health every frame, cap at max health if regeneration overflows ]]--
        if tower_value_currentHealth < tower_value_maxHealth and tower_value_currentHealth > 0 then
            tower_value_currentHealth = math.min(tower_value_currentHealth + tower_value_healthRegen * dt * gameSpeed, tower_value_maxHealth)
        end

        if skipWaveMessage then
            if timer_waveSkipMessage < 3 then
                timer_waveSkipMessage = timer_waveSkipMessage + dt
            else
                skipWaveMessage = false
                timer_waveSkipMessage = 0
            end
        end

        if upgrade_unlock_shield then
            --[[ Count time until Shield activation, activate Shield for a specified time when cooldown ends (only if Shield upgrades are unlocked) ]]--
            if not shieldActive then
                if timer_untilShieldActive < tower_value_shield_cooldown then
                    timer_untilShieldActive = timer_untilShieldActive + dt * gameSpeed
                else
                    timer_untilShieldActive = 0
                    shieldActive = true
                end
            elseif shieldActive then
                if timer_shieldActive < tower_value_shield_duration then
                    timer_shieldActive = timer_shieldActive + dt * gameSpeed
                else
                    timer_shieldActive = 0
                    shieldActive = false
                end
            end
        end

        checkIfTowerCollapsed()
        updateParticles(dt)

    elseif inHub then
        --[[ Set a timer for alloying Electrum, add 1 Electrum when the timer runs out ]]--
        if electrumAlloying then
            if timer_untilElectrum < 24 then
                timer_untilElectrum = timer_untilElectrum + dt * gameSpeed
            else
                timer_untilElectrum = 0
                electrumAlloying = false
                currentElectrum = currentElectrum + 1
            end
        end
    end
    if tokensOnCooldown then
        if timer_untilTokens < tokenCooldown then
            timer_untilTokens = timer_untilTokens + dt * gameSpeed
        else
            timer_untilTokens = 0
            tokensOnCooldown = false
        end
    end
end

function love.mousepressed(x, y)

    upgradeMenu_mouse(x, y)

    if tower_value_currentHealth > 0 then
        --[[ Open/close upgrade menu ]]--
        if x >= 860 and x <= 1060 and y >= 1030 and y <= 1080 and not upgradeMenu and not paused then
            upgradeMenu = true
        elseif x >= 860 and x <= 1060 and y >= 750 and y <= 800 and upgradeMenu and not paused then
            upgradeMenu = false
        end

        if x >= 1870 and x <= 1910 and y >= 10 and y <= 50 and not paused then
            gameSpeed = 0
            paused = true
        end

        if x >= 810 and x <= 950 and y >= 610 and y <= 670 and paused and not settings then
            gameSpeed = 1
            paused = false
        elseif x >= 970 and x <= 1110 and y >= 610 and y <= 670 and paused and not settings then
            gameSpeed = 1
            paused = false
            tower_value_currentHealth = 0
        elseif x >= 890 and x <= 1150 and y >= 530 and y <= 570 and paused and not settings then
            settings = true
        end
    end

    if settings then
        if x >= 820 and x <= 844 and y >= 332 and y <= 356 and settings_particleMultiplierIndex > 1 then
            settings_particleMultiplierIndex = settings_particleMultiplierIndex - 1
        elseif x >= 1076 and x <= 1100 and y >= 332 and y <= 356 and settings_particleMultiplierIndex < 8 then
            settings_particleMultiplierIndex = settings_particleMultiplierIndex + 1
        end

        if x >= 820 and x <= 844 and y >= 412 and y <= 436 and settings_waveSkipMessages then
            settings_waveSkipMessages = false
        elseif x >= 1076 and x <= 1100 and y >= 412 and y <= 436 and not settings_waveSkipMessages then
            settings_waveSkipMessages = true
        end

        if x >= 820 and x <= 844 and y >= 492 and y <= 516 and settings_notation ~= settings_notationNames[1] then
            if settings_notation == settings_notationNames[3] then
                settings_notation = settings_notationNames[2]
            elseif settings_notation == settings_notationNames[2] then
                settings_notation = settings_notationNames[1]
            end
        elseif x >= 1076 and x <= 1100 and y >= 492 and y <= 516 and settings_notation ~= settings_notationNames[3] then
            if settings_notation == settings_notationNames[1] then
                settings_notation = settings_notationNames[2]
            elseif settings_notation == settings_notationNames[2] then
                settings_notation = settings_notationNames[3]
            end
        end

        if x >= 820 and x <= 844 and y >= 572 and y <= 596 and settings_tooltips then
            settings_tooltips = false
        elseif x >= 1076 and x <= 1100 and y >= 572 and y <= 596 and not settings_tooltips then
            settings_tooltips = true
        end

        if x >= 910 and x <= 1010 and y >= 780 and y <= 820 then
            settings = false
        end
    end

    --[[ If the "To Hub" button is pressed at the end screen, go to Hub ]]--
    if gameOver and #collapseParticles == 0 then
        if x >= 870 and x <= 1050 and y >= 760 and y <= 820 then
            upgradeMenu = false
            inHub = true
            gameSpeed = 1
            paused = false
            hubSection = "Main"
            resetRoundValues()
        end
    end

    inHub_mouse(x, y)
end

function love.keypressed(key)
    if key == "escape" then
        saveGame()
        love.event.quit()
    end
end