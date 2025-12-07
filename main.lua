function love.load()
    lume = require "lume"
    require "technical"
    require "upgradeAndUnlockModules"
    require "loadGame"
    require "saveGame"
    require "towers"
    require "towerInfo"
    require "upgradeMenu"
    require "particles"
    require "tooltips"
    require "gameOver"
    require "notations"
    require "abilityObjects"
    require "abilityFunctions"
    require "enemy"
    loadGame()
    require "hub"
    require "stats"
    hubSection = "Main"
    roundUpgradeSection = "ATK"
    background = "eclipse"
    --- Reloads all images.
    function assetReload()
        --Backgrounds
        img_background = love.graphics.newImage("assets/background.png")
        img_background_stellar = love.graphics.newImage("assets/background_stellar.png")
        img_background_eclipse = love.graphics.newImage("assets/background_eclipse.png")
        img_background_nova = love.graphics.newImage("assets/background_nova.png")
        img_background_aurora = love.graphics.newImage("assets/background_aurora.png")
        --img_background_interstellar = love.graphics.newImage("assets/background_interstellar.png")

        --Currencies
        img_currency_copper = love.graphics.newImage("assets/currency_copper_new.png")
        img_currency_silver = love.graphics.newImage("assets/currency_silver_new.png")
        img_currency_gold = love.graphics.newImage("assets/currency_gold_new.png")
        img_currency_electrum = love.graphics.newImage("assets/currency_electrum.png")
        img_currency_token = love.graphics.newImage("assets/currency_token.png")
        img_currency_token_big = love.graphics.newImage("assets/currency_token_big.png")

        --Tower objects
        img_tower_main = love.graphics.newImage("assets/tower_main.png")
        img_tower_main_shielded = love.graphics.newImage("assets/tower_main_shielded.png")
        img_tower_eclipse_sun = love.graphics.newImage("assets/tower_eclipse_sun.png")
        img_tower_eclipse_sun2 = love.graphics.newImage("assets/tower_eclipse_sun2.png")
        img_tower_eclipse_sun2_shielded = love.graphics.newImage("assets/tower_eclipse_sun2_shielded.png")
        img_tower_eclipse_moon = love.graphics.newImage("assets/tower_eclipse_moon.png")
        img_tower_eclipse_moon2 = love.graphics.newImage("assets/tower_eclipse_moon2.png")
        img_tower_nova_static = love.graphics.newImage("assets/tower_nova_static.png")
        img_tower_nova_outerLines = love.graphics.newImage("assets/tower_nova_outerLines.png")
        img_tower_nova_branches = love.graphics.newImage("assets/tower_nova_branches.png")
        img_tower_nova_shield = love.graphics.newImage("assets/tower_nova_shield.png")
        img_tower_aurora_static = love.graphics.newImage("assets/tower_aurora_static.png")
        img_tower_aurora_unshielded = love.graphics.newImage("assets/tower_aurora_unshielded.png")
        img_tower_aurora_shield = love.graphics.newImage("assets/tower_aurora_shield.png")
        img_tower_projectile = love.graphics.newImage("assets/tower_projectile.png")

        --Enemies
        img_enemy_basic = love.graphics.newImage("assets/enemy_basic.png")
        img_enemy_tank = love.graphics.newImage("assets/enemy_tank.png")
        img_enemy_swift = love.graphics.newImage("assets/enemy_swift.png")
        img_enemy_sentry = love.graphics.newImage("assets/enemy_sentry.png")
        img_enemy_centurion = love.graphics.newImage("assets/enemy_centurion.png")
        img_enemy_exploder_static = love.graphics.newImage("assets/enemy_exploder_static.png")

        --Icons
        img_icon_enemy_health = love.graphics.newImage("assets/icon_enemy_health.png")
        img_icon_enemy_attack = love.graphics.newImage("assets/icon_enemy_attack.png")
        img_icon_player_attack = love.graphics.newImage("assets/icon_player_attack.png")

        --Particles
        img_particle_collapse = love.graphics.newImage("assets/particle_collapse.png")
        img_particle_kill_enemy_basic = love.graphics.newImage("assets/particle_kill_enemy_basic.png")
        img_particle_kill_enemy_tank = love.graphics.newImage("assets/particle_kill_enemy_tank.png")
        img_particle_kill_enemy_swift = love.graphics.newImage("assets/particle_kill_enemy_swift.png")
        img_particle_kill_enemy_sentry = love.graphics.newImage("assets/particle_kill_enemy_sentry.png")
        img_particle_kill_enemy_centurion = love.graphics.newImage("assets/particle_kill_enemy_centurion.png")
        img_particle_kill_enemy_exploder = love.graphics.newImage("assets/particle_kill_enemy_exploder.png")
        img_particle_crystalExplosion = love.graphics.newImage("assets/particle_crystalExplosion.png")
        img_particle_burn = love.graphics.newImage("assets/particle_burn.png")
        img_particle_meteor = love.graphics.newImage("assets/particle_meteor.png")

        --Buttons
        img_button_pause = love.graphics.newImage("assets/button_pause.png")
        img_button_arrowLeft = love.graphics.newImage("assets/button_arrowLeft.png")
        img_button_arrowRight = love.graphics.newImage("assets/button_arrowRight.png")
        img_button_arrowLeft_big = love.graphics.newImage("assets/button_arrowLeft_big.png")
        img_button_arrowRight_big = love.graphics.newImage("assets/button_arrowRight_big.png")
        img_button_questionMark = love.graphics.newImage("assets/button_questionMark.png")

        img_meteor = love.graphics.newImage("assets/meteor.png")

        --Ability objects
        img_crystal = love.graphics.newImage("assets/crystal.png")
        img_crystal_multilayered_l1 = love.graphics.newImage("assets/crystal_multilayered_l1.png")
        img_crystal_multilayered_l2 = love.graphics.newImage("assets/crystal_multilayered_l2.png")
        img_crystal_multilayered_l3 = love.graphics.newImage("assets/crystal_multilayered_l3.png")
        img_crystal_aoe = love.graphics.newImage("assets/crystal_aoe.png")
        img_rainforest = love.graphics.newImage("assets/rainforest.png")
        img_ice_domain = love.graphics.newImage("assets/ice_domain.png")
        img_magmaTouch_pool = love.graphics.newImage("assets/magmaTouch_pool.png")
        img_lightningOrb = love.graphics.newImage("assets/lightningOrb.png")
        img_lightningOrb_shadow = love.graphics.newImage("assets/lightningOrb_shadow.png")
        img_lightningOrb_laser_var1 = love.graphics.newImage("assets/lightningOrb_laser_var1.png")
        img_lightningOrb_laser_var2 = love.graphics.newImage("assets/lightningOrb_laser_var2.png")
        img_lightningOrb_laser_var3 = love.graphics.newImage("assets/lightningOrb_laser_var3.png")
        img_JerelosBlessing_vines_var1 = love.graphics.newImage("assets/JerelosBlessing_vines_var1.png")
        img_JerelosBlessing_vines_var2 = love.graphics.newImage("assets/JerelosBlessing_vines_var2.png")
        img_JerelosBlessing_vines_var3 = love.graphics.newImage("assets/JerelosBlessing_vines_var3.png")
        img_JerelosBlessing_vines_var4 = love.graphics.newImage("assets/JerelosBlessing_vines_var4.png")
        img_JerelosBlessing_water = love.graphics.newImage("assets/JerelosBlessing_water.png")
        img_JerelosBlessing_waves_var1 = love.graphics.newImage("assets/JerelosBlessing_waves_var1.png")
        img_JerelosBlessing_waves_var2 = love.graphics.newImage("assets/JerelosBlessing_waves_var2.png")
        img_JerelosBlessing_waves_var3 = love.graphics.newImage("assets/JerelosBlessing_waves_var3.png")
        img_JerelosBlessing_waves_var4 = love.graphics.newImage("assets/JerelosBlessing_waves_var4.png")
        img_disruptWave = love.graphics.newImage("assets/disruptWave.png")

        --Ability previews
        img_ability_preview_spikedCrystals = love.graphics.newImage("assets/ability_preview_spikedCrystals.png")
        img_ability_preview_scatterFire = love.graphics.newImage("assets/ability_preview_scatterFire.png")
        img_ability_preview_burstFire = love.graphics.newImage("assets/ability_preview_burstFire.png")
        img_ability_preview_rainforest = love.graphics.newImage("assets/ability_preview_rainforest.png")
        img_ability_preview_iceDomain = love.graphics.newImage("assets/ability_preview_iceDomain.png")
        img_ability_preview_magmaTouch = love.graphics.newImage("assets/ability_preview_magmaTouch.png")
        img_ability_preview_lightningOrb = love.graphics.newImage("assets/ability_preview_lightningOrb.png")
        img_ability_preview_JerelosBlessing = love.graphics.newImage("assets/ability_preview_JerelosBlessing.png")
        img_ability_preview_berserkerKit = love.graphics.newImage("assets/ability_preview_berserkerKit.png")
        img_ability_preview_sniperKit = love.graphics.newImage("assets/ability_preview_sniperKit.png")
        img_ability_preview_tankKit = love.graphics.newImage("assets/ability_preview_tankKit.png")
        img_ability_preview_supercritical = love.graphics.newImage("assets/ability_preview_supercritical.png")
        img_ability_preview_disruptWave = love.graphics.newImage("assets/ability_preview_disruptWave.png")

        --Audio
        audio_enemy_kill = love.audio.newSource("assets/audio/enemy_kill.wav", "static")
        audio_enemy_kill_centurion = love.audio.newSource("assets/audio/enemy_kill_centurion.wav", "static")
        audio_enemy_kill_sentry = love.audio.newSource("assets/audio/enemy_kill_sentry.wav", "static")
        audio_enemy_kill_exploder = love.audio.newSource("assets/audio/exploder_explode.wav", "static")
        audio_crystal_explosion = love.audio.newSource("assets/audio/crystal_explode.wav", "static")
        audio_tower_scatterFire__burstFire = love.audio.newSource("assets/audio/tower_scatterFire-burstFire.wav", "static")
        audio_tower_damageTaken = love.audio.newSource("assets/audio/tower_damageTaken.wav", "static")
        audio_tower_damageAbsorbed = love.audio.newSource("assets/audio/tower_damageAbsorbed.wav", "static")
        audio_tower_collapse = love.audio.newSource("assets/audio/tower_collapse.wav", "static")
        audio_tower_fire = love.audio.newSource("assets/audio/tower_fire2.wav", "static")
        audio_tower_lifestealTrigger = love.audio.newSource("assets/audio/tower_lifesteal2.wav", "static")
        audio_rainforest_activation = love.audio.newSource("assets/audio/rainforest_activation.wav", "static")
        audio_lightningOrb_launch = love.audio.newSource("assets/audio/lightningOrb_launch.wav", "static")
        audio_upgrade_bought = love.audio.newSource("assets/audio/upgrade_bought.wav", "static")

        --Music
        -- audioST_Echoes = love.audio.newSource("assets/audio/Echoes.mp3", "stream")

        --Quads
        quads_enemy_exploder = love.graphics.newImage("assets/enemy_exploder_quads.png")

        --Miscere
        img_exploder_aoe = love.graphics.newImage("assets/exploder_aoe_big.png")
        img_discordLogo = love.graphics.newImage("assets/discord.png")
    end

    --- Reloads all fonts.
    function fontReload()
        --Vera Sans Font (regular)
        font_Vera12 = love.graphics.newFont("assets/fonts/Vera/Vera.ttf", 12)
        font_Vera16 = love.graphics.newFont("assets/fonts/Vera/Vera.ttf", 16)

        --Vera Sans Font (bold)
        font_VeraBold16 = love.graphics.newFont("assets/fonts/Vera/VeraBd.ttf", 16)
        font_VeraBold18 = love.graphics.newFont("assets/fonts/Vera/VeraBd.ttf", 18)
        font_VeraBold24 = love.graphics.newFont("assets/fonts/Vera/VeraBd.ttf", 24)

        --Afacad Flux Font (regular)
        font_Afacad12 = love.graphics.newFont("assets/fonts/Afacad Flux/AfacadFlux-Regular.ttf", 12)
        font_Afacad16 = love.graphics.newFont("assets/fonts/Afacad Flux/AfacadFlux-Regular.ttf", 16)
        font_Afacad18 = love.graphics.newFont("assets/fonts/Afacad Flux/AfacadFlux-Regular.ttf", 18)
        font_Afacad20 = love.graphics.newFont("assets/fonts/Afacad Flux/AfacadFlux-Regular.ttf", 20)
        font_Afacad24 = love.graphics.newFont("assets/fonts/Afacad Flux/AfacadFlux-Regular.ttf", 24)
        font_Afacad28 = love.graphics.newFont("assets/fonts/Afacad Flux/AfacadFlux-Regular.ttf", 28)

        --Afacad Flux Font (medium)
        font_AfacadMedium24 = love.graphics.newFont("assets/fonts/Afacad Flux/AfacadFlux-Medium.ttf", 24)

        --Afacad Flux Font (semi-bold)
        font_AfacadSemiBold24 = love.graphics.newFont("assets/fonts/Afacad Flux/AfacadFlux-SemiBold.ttf", 24)
        font_AfacadSemiBold28 = love.graphics.newFont("assets/fonts/Afacad Flux/AfacadFlux-SemiBold.ttf", 28)

        --Afacad Flux Font (bold)
        font_AfacadBold18 = love.graphics.newFont("assets/fonts/Afacad Flux/AfacadFlux-Bold.ttf", 18)
        font_AfacadBold20 = love.graphics.newFont("assets/fonts/Afacad Flux/AfacadFlux-Bold.ttf", 20)
        font_AfacadBold24 = love.graphics.newFont("assets/fonts/Afacad Flux/AfacadFlux-Bold.ttf", 24)
        font_AfacadBold28 = love.graphics.newFont("assets/fonts/Afacad Flux/AfacadFlux-Bold.ttf", 28)
        font_AfacadBold32 = love.graphics.newFont("assets/fonts/Afacad Flux/AfacadFlux-Bold.ttf", 32)
        font_AfacadBold48 = love.graphics.newFont("assets/fonts/Afacad Flux/AfacadFlux-Bold.ttf", 48)
    end
    --What range melee enemies can attack from at maximum
    TOWER_SIZE = 42
    --Maximum delta time, game slows down if FPS is lower than 1/MAX_STEP
    MAX_STEP = 1/50
    love.graphics.setLineStyle("rough")
    settings_particleMultiplierNames = {"None", "Minimal", "Reduced", "Normal", "Rich", "Fancy", "Fabulous", "Stormful"}
    settings_notationNames = {"kmbt", "e", "alphabet"}
    settings_themeNames = {
        main = "Nox",
        stellar = "Stellar",
        eclipse = "Eclipse",
        nova = "Nova",
        aurora = "Aurora"
    }
    settings_themes = {
        "main", "stellar", "eclipse", "nova", "aurora"
    }
    enemyFuncs.load()
    settings_particleMultipliers = {0, 0.25, 0.75, 1, 1.5, 2, 3, 5}
    difficultyMultipliers = {1, 1.4, 1.75, 2.1, 2.4}
    assetReload()
    fontReload()
    resetRoundValues()
    towers.reload()
    upgradeModuleFuncs.load()
end

function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end

function reloadIdleGains()
    local silver = 0
    local gold = 0
    for i=1,5 do
        local diffIndex = "d" .. i
        silver = silver + 0.8 * math.floor(player.bestWaves[diffIndex] / 10)
        gold = gold + 0.024 * math.floor(player.bestWaves[diffIndex] / 100)
    end
    return silver, gold
end

--- Create a projectile flying in a specified angle.
---@param x number Starting horizontal position of the projectile.
---@param y number Starting vertical position of the projectile.
---@param speed number Speed of the projectile (px/s).
---@param scatterFire boolean Whether this projectile was triggered by Scatter Fire.
---@param burstFire boolean Whether this projectile was triggered by Burst Fire.
---@param enemyIndex number What enemy to target this projectile to.
---@param efficiency number Damage multiplier individual to this projectile.
function createProjectile(x, y, speed, scatterFire, burstFire, enemyIndex, efficiency)
    local projectilesCreated = 0
    projectile = {}
    projectile.x = x
    projectile.y = y
    projectile.speed = speed
    projectile.efficiency = efficiency or 1
    if player.upgrades.unlocks.crit then
        local isCrit = love.math.random() * 100
        if isCrit <= player.tower.critChance then
            projectile.isCrit = true
        else
            projectile.isCrit = false
        end
    end
    if projectile.isCrit then
        local isSupercrit = player.abilities.supercritical.equipped and love.math.random() * 100 or 101
        if isSupercrit <= levelingInfo[11].supercriticalChance[player.abilities.supercritical.level + 1] then
            projectile.isSupercrit = true
        else
            projectile.isSupercrit = false
        end
    end
    if scatterFire then
        projectile.scatterFire = true
        projectile.angle = love.math.random() * 2 * math.pi
        projectilesCreated = projectilesCreated + 1
    elseif burstFire then
        projectile.burstFire = true
        projectile.angle = love.math.random() * 2 * math.pi
        projectilesCreated = projectilesCreated + 1
    else
        enemyFuncs.findClosestEnemyInRange(960, 540, player.tower.range)
        projectile.angle = math.atan2(enemyFuncs.findClosestEnemyInRange(960, 540, player.tower.range)[enemyIndex].y - 540 + enemyOffsets[enemyFuncs.findClosestEnemyInRange(960, 540, player.tower.range)[enemyIndex].type], enemyFuncs.findClosestEnemyInRange(960, 540, player.tower.range)[enemyIndex].x - 960 + enemyOffsets[enemyFuncs.findClosestEnemyInRange(960, 540, player.tower.range)[enemyIndex].type])
        projectilesCreated = projectilesCreated + 1
    end
    table.insert(projectilesOnField, projectile)
    player.stats.battle.projectilesFired = player.stats.battle.projectilesFired + projectilesCreated
    player.stats.save.projectilesFired = player.stats.save.projectilesFired + projectilesCreated
end

--- Create a Meteor.
---@param angle number Angle which the Meteor spawns at.
function createMeteor(angle)
    meteor = {}
    meteor.angle = angle
    meteor.particleFreq = 0.065
    meteor.timer_particle = 0
    table.insert(meteors, meteor)
end

--- Skip waves and give the player some resources based on how many waves were skipped and the bonuses per wave
---@param wavesSkipped number The amount of waves being skipped.
function skipWave(wavesSkipped)
    gameplay.wave = gameplay.wave + wavesSkipped

    local oldCopperAmount = player.currencies.currentCopper
    misc.copperBuffer = misc.copperBuffer + player.tower.copperBonus * player.tower.copperPerWave * wavesSkipped
    player.currencies.currentCopper = player.currencies.currentCopper + math.floor(player.tower.copperBonus) * player.tower.copperPerWave * wavesSkipped
    if misc.copperBuffer >= 1 then
        player.currencies.currentCopper = player.currencies.currentCopper + math.floor(misc.copperBuffer)
        misc.copperBuffer = misc.copperBuffer - math.floor(misc.copperBuffer)
    end
    local newCopperAmount = player.currencies.currentCopper
    local copperEarned = newCopperAmount - oldCopperAmount
    player.stats.battle.copperEarned = player.stats.battle.copperEarned + copperEarned

    local oldSilverAmount = player.currencies.currentSilver
    misc.silverBuffer = misc.silverBuffer + player.tower.silverBonus * player.tower.silverPerWave * wavesSkipped
    player.currencies.currentSilver = player.currencies.currentSilver + math.floor(player.tower.silverBonus) * player.tower.silverPerWave * wavesSkipped
    if misc.silverBuffer >= 1 then
        player.currencies.currentSilver = player.currencies.currentSilver + math.floor(misc.silverBuffer)
        misc.silverBuffer = misc.silverBuffer - math.floor(misc.silverBuffer)
    end
    local newSilverAmount = player.currencies.currentSilver
    local silverEarned = newSilverAmount - oldSilverAmount
    player.stats.battle.silverEarned = player.stats.battle.silverEarned + silverEarned

    if wavesSkipped > 0 then
        player.misc.waveSkipMessage = true
    end

    local JerelosBlessingRegen = love.math.random() * 100
    if JerelosBlessingRegen <= levelingInfo[7].regenChance[player.abilities.JerelosBlessing.level + 1] and gameplay.gameSpeed > 0 then
        player.tower.currentHealth = player.tower.health
    end

    player.stats.battle.wavesSkipped = player.stats.battle.wavesSkipped + wavesSkipped
    player.stats.save.wavesSkipped = player.stats.save.wavesSkipped + wavesSkipped
    timers.waveSkip = 0
end

function love.draw()
    tooltips.general()
    if player.location == "round" then
        love.graphics.draw(accentColors[player.misc.theme].background, 0, 0)
        love.graphics.setLineWidth(2)
        love.graphics.setLineStyle("smooth")
        love.graphics.setColor(1, 1, 1, 0.5)
        love.graphics.ellipse("line", 960, 540, player.tower.range, player.tower.range)
        love.graphics.setColor(1, 1, 0, 0.4)
        love.graphics.setLineWidth(1.5)
        love.graphics.ellipse("line", 960, 540, TOWER_SIZE, TOWER_SIZE)
        love.graphics.setLineStyle("rough")
        love.graphics.setFont(font_Vera16)
        if player.abilities.JerelosBlessing.equipped then
            abilityObjects.JerelosBlessing.draw()
        end
        love.graphics.setColor(1, 1, 1, 1)
        towers.aurora()
        love.graphics.setColor(1, 1, 1, 1)
        --[[ Different enemy types have different appearances ingame ]]--
        for i,v in ipairs(enemiesOnField) do
            local x = math.floor(v.x * 4) / 4
            local y = math.floor(v.y * 4) / 4
            local enemyAssets = {
                basic = img_enemy_basic,
                tank = img_enemy_tank,
                swift = img_enemy_swift,
                sentry = img_enemy_sentry,
                centurion = img_enemy_centurion,
                exploder = img_enemy_exploder,
            }
            if v.type == "exploder" then
                love.graphics.draw(quads_enemy_exploder, enemyAssets[v.type], x, y)
            else
                love.graphics.draw(enemyAssets[v.type], x, y)
            end
        end
        for i,v in ipairs(exploderAoEs) do
            local cs = math.min((v.timer / exploderExplodeTime)^0.5, 1)
            love.graphics.setColor(1, 1, 1, 1 - (v.timer / exploderExplodeTime))
            love.graphics.draw(img_exploder_aoe, v.x + 12 - 108 * cs, v.y + 12 - 108 * cs, 0, cs, cs)
            --love.graphics.draw(img_exploder_aoe, v.x, v.y, 0, cs, cs)
        end
        love.graphics.setColor(1, 1, 1, 1)
        for i,v in ipairs(projectilesOnField) do
            love.graphics.draw(img_tower_projectile, v.x, v.y)
        end
        love.graphics.setFont(font_VeraBold16)
        --[[ Display enemy and gameplay info ]]--
        --love.graphics.printf(string.format("Wave %d", gameplay_wave), 810, 1000, 300, "center")
        for i,v in ipairs(meteors) do
            love.graphics.draw(img_meteor, v.x - 14, v.y - 14)
        end
        if player.abilities.disruptWave.unlocked and player.abilities.disruptWave.equipped then
            local spreadTime = 0.4
            local fadeTime = 0.2
            local waveScale = math.min(timers.disruptWave, spreadTime) * (1/spreadTime) * (player.tower.range*2/512)
            local wavePosScale = math.min(timers.disruptWave, spreadTime) * (1/spreadTime)
            local fadeAlpha = math.min(math.max(timers.disruptWave - spreadTime, 0), fadeTime) * (0.8/fadeTime)
            love.graphics.setColor(1, 1, 1, player.stats.battle.gameTime > 1 and 0.8 - fadeAlpha or 0)
            love.graphics.draw(img_disruptWave, 960 - player.tower.range * wavePosScale, 540 - player.tower.range * wavePosScale, 0, waveScale)
        end
        renderParticles()
        abilityObjects.spikedCrystal.draw()
        abilityObjects.magmaPool.draw()
        abilityObjects.lightningOrb.draw()
        abilityObjects.lightningOrb_laser.draw()
        drawUpgradeMenu()
        towerInfo_visual()
        if player.misc.iceDomainActive then
            love.graphics.setColor(1, 1, 1, levelingInfo[4].density[player.abilities.iceDomain.level + 1] / 100)
            love.graphics.draw(img_ice_domain, 960 - player.tower.range, 540 - player.tower.range, 0, (player.tower.range * 2 + 42) / 1080)
        end
        love.graphics.setColor(1, 1, 1, 1)
        if sentryAlive then
            enemyFuncs.drawSentryBossbar()
        elseif centurionAlive then
            enemyFuncs.drawCenturionBossbar()
        end
        if player.settings.waveSkipMessages then
            if player.misc.waveSkipMessage then
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.setFont(font_Afacad20)
                if not player.menu.upgrades then
                    love.graphics.printf({{1, 1, 1, 1}, "Skipped ", {0.35, 1, 0.75, 1}, string.format("%d ", wavesSkipped), {1, 1, 1, 1}, "wave", {1, 1, 1, 1}, string.format("%s!", wavesSkipped > 1 and "s" or "")}, 1690, 920, 220, "center")
                else
                    love.graphics.printf({{1, 1, 1, 1}, "Skipped ", {0.35, 1, 0.75, 1}, string.format("%d ", wavesSkipped), {1, 1, 1, 1}, "wave", {1, 1, 1, 1}, string.format("%s!", wavesSkipped > 1 and "s" or "")}, 1690, 690, 220, "center")
                end
            end
            if player.misc.copperAddedMessage then
                love.graphics.setFont(font_Afacad16)
                love.graphics.print({{1, 1, 1, 1}, "+", {0.92, 0.45, 0.26}, notations.convertToLetterNotation(math.floor(player.tower.copperPerWave * player.tower.copperBonus), "brief")}, 123, 116)
            end
            if player.misc.silverAddedMessage then
                love.graphics.setFont(font_Afacad16)
                love.graphics.print({{1, 1, 1, 1}, "+", {0.94, 0.97, 0.95}, notations.convertToLetterNotation(math.floor(player.tower.silverPerWave * player.tower.silverBonus * difficultyMultipliers[gameplay.difficulty]), "brief")}, 123, 148)
            end
        end
        love.graphics.draw(img_button_pause, 1870, 10)
        love.graphics.setLineWidth(2)
        love.graphics.rectangle("line", 1870, 10, 40, 40, 2, 2)
        love.graphics.setColor(1, 1, 1, 1)
        --[[ Print currency balances for Copper, Silver and Gold ]]--
        love.graphics.setColor(0, 0, 0, 0.5)
        love.graphics.setLineStyle("smooth")
        love.graphics.rectangle("fill", 1, 100, 119, 200, 4, 4)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setLineWidth(2)
        love.graphics.rectangle("line", 1, 100, 119, 200, 4, 4)
        love.graphics.setFont(font_Vera16)
        love.graphics.draw(img_currency_copper, 8, 110)
        love.graphics.printf(string.format("%s", notations.convertToLetterNotation(player.currencies.currentCopper, "brief")), 42, 117, 100, "left")
        love.graphics.draw(img_currency_silver, 8, 142)
        love.graphics.printf(string.format("%s", notations.convertToLetterNotation(player.currencies.currentSilver, "brief")), 42, 149, 100, "left")
        love.graphics.draw(img_currency_gold, 8, 174)
        love.graphics.printf(string.format("%s", notations.convertToLetterNotation(player.currencies.currentGold, "brief")), 42, 181, 100, "left")
        love.graphics.draw(img_currency_electrum, 8, 206)
        love.graphics.printf(string.format("%s", notations.convertToLetterNotation(player.currencies.currentElectrum, "brief")), 42, 213, 100, "left")
        love.graphics.draw(img_currency_token, 8, 238)
        love.graphics.printf(string.format("%s", notations.convertToLetterNotation(player.currencies.currentTokens, "brief")), 42, 245, 100, "left")
        if #collapseParticles == 0 and player.tower.currentHealth <= 0 then
            menu_display_gameOver()
        end
        if player.menu.gameplayInfo then
            love.graphics.setLineWidth(1)
            love.graphics.setColor(0, 0, 0, 0.5)
            love.graphics.rectangle("fill", 0, 0, 1920, 1080)
            love.graphics.setColor(accentColors[player.misc.theme].menus)
            love.graphics.rectangle("fill", 710, 240, 500, 600, 2, 2)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.rectangle("line", 710, 240, 500, 600, 2, 2)
            love.graphics.setFont(font_AfacadBold28)
            love.graphics.printf(string.format("Gameplay Info - Wave %d", gameplay.wave), 710, 243, 500, "center")
            love.graphics.setFont(font_AfacadBold20)
            local columnCenters = {}
            for i=1,5 do
                table.insert(columnCenters, 760 + (i - 1) * 100)
            end
            local rowCenters = {}
            for i=1,7 do
                table.insert(rowCenters, 290 + (i - 1) * 40)
            end
            local wrapWidth = 200
            local enemySize = {20, 32, 16, 44, 60, 24}
            local enemyStats = {
                {"Enemy", "Health", "Damage/t", "Speed", "Chance"},
                {img_enemy_basic, img_enemy_tank, img_enemy_swift, img_enemy_sentry, img_enemy_centurion, img_enemy_exploder_static},
                {enemyAttributes.health, enemyAttributes.health * 5, enemyAttributes.health * 0.75, enemyAttributes.health * (10 + math.floor((gameplay.wave - 10) / 10) * 2.5), enemyAttributes.health * 256, enemyAttributes.health},
                {enemyAttributes.attackDamage, enemyAttributes.attackDamage * 1.2, enemyAttributes.attackDamage, enemyAttributes.attackDamage * 4, enemyAttributes.attackDamage * 10, enemyAttributes.attackDamage * 2.5},
                {1, 0.9, 1.5, 0.75, 0.5},
                {enemyAttributes.speed / 20, enemyAttributes.speed * 0.8 / 20, enemyAttributes.speed * 2 / 20, enemyAttributes.speed * 0.6 / 20, enemyAttributes.speed * 0.5 / 20, enemyAttributes.speed / 20},
                {enemyAttributes.spawn.basic, enemyAttributes.spawn.tank, enemyAttributes.spawn.swift, gameplay.wave % 10 == 0 and gameplay.wave % 100 ~= 0 and 100 or 0, gameplay.wave % 100 == 0 and 100 or 0, enemyAttributes.spawn.exploder},
            }
            for i=1,#enemyStats[1] do
                love.graphics.printf(enemyStats[1][i], columnCenters[i] - wrapWidth / 2, rowCenters[1], wrapWidth, "center")
            end
            for i=1,#enemyStats[2] do
                love.graphics.draw(enemyStats[2][i], columnCenters[1] - 11, rowCenters[i+1], 0, 20 / enemySize[i])
            end
            love.graphics.setFont(font_Afacad20)
            for j=1,#enemyStats[2] do
                love.graphics.printf(notations.convertToLetterNotation(enemyStats[3][j], "precise"), columnCenters[2] - wrapWidth / 2, rowCenters[j+1] - 2, wrapWidth, "center")
            end
            for j=1,#enemyStats[2] do
                love.graphics.printf(notations.convertToLetterNotation(enemyStats[4][j], "precise") .. (enemyStats[5][j] and string.format("/%.2fs", 1 / enemyStats[5][j]) or ""), columnCenters[3] - wrapWidth / 2, rowCenters[j+1] - 2, wrapWidth, "center")
            end
            for i=1,#enemyStats[2] do
                love.graphics.printf(string.format("%.1fu", enemyStats[6][i]), columnCenters[4] - wrapWidth / 2, rowCenters[i+1] - 2, wrapWidth, "center")
            end
            for i=1,#enemyStats[2] do
                love.graphics.printf(string.format("%.1f%%", enemyStats[7][i]), columnCenters[5] - wrapWidth / 2, rowCenters[i+1] - 2, wrapWidth, "center")
            end
            love.graphics.setColor(accentColors[player.misc.theme].buttons)
            love.graphics.rectangle("fill", 890, 790, 140, 40)
            love.graphics.setColor(accentColors[player.misc.theme].buttonOutlines)
            love.graphics.setLineWidth(2)
            love.graphics.rectangle("line", 890, 790, 140, 40, 2, 2)
            love.graphics.setFont(font_Afacad24)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.printf("Enemy Info", 870, 792, 180, "center")
            love.graphics.setFont(font_Afacad20)
            love.graphics.printf({{1, 1, 1, 1}, "Enemy spawn cap: ", {1, 0.8, 0.5, 1}, string.format("%d", enemyAttributes.waveCap)}, 710, 730, 500, "center")
            love.graphics.printf({{1, 1, 1, 1}, "Enemy spawn wrate: ", {1, 0.8, 0.5, 1}, string.format("%.1f", enemyAttributes.spawnRate), {1, 1, 1, 1}, "/s"}, 710, 755, 500, "center")
            love.graphics.draw(img_button_arrowRight_big, 1210, 522)
            if player.settings.tooltips then
                tooltips.displayGameplayInfo()
            end
        end
        if player.menu.enemyInfo then
            statsMenus.enemyInfo.draw()
        end
        if player.menu.battleStats then
            statsMenus.battle.draw()
        end
        if player.menu.paused then
            love.graphics.setColor(0, 0, 0, 0.5)
            love.graphics.rectangle("fill", 0, 0, 1920, 1080)
            love.graphics.setColor(accentColors[player.misc.theme].menus)
            love.graphics.rectangle("fill", 710, 390, 500, 300)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.setLineWidth(1)
            love.graphics.rectangle("line", 710, 390, 500, 300, 3, 3)
            love.graphics.setFont(font_AfacadBold32)
            love.graphics.printf("Paused", 860, 400, 200, "center")

            love.graphics.setColor(accentColors[player.misc.theme].buttons)
            love.graphics.rectangle("fill", 890, 560, 140, 40)
            love.graphics.setColor(accentColors[player.misc.theme].buttonOutlines)
            love.graphics.setLineWidth(2)
            love.graphics.rectangle("line", 890, 560, 140, 40, 2, 2)
            love.graphics.setFont(font_Afacad24)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.printf("Settings", 870, 562, 180, "center")

            love.graphics.setColor(accentColors[player.misc.theme].buttons)
            love.graphics.rectangle("fill", 810, 610, 140, 60)
            love.graphics.setColor(accentColors[player.misc.theme].buttonOutlines)
            love.graphics.setLineWidth(2)
            love.graphics.rectangle("line", 810, 610, 140, 60, 2, 2)
            love.graphics.setFont(font_Afacad24)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.printf("Back to game", 810, 622, 140, "center")

            love.graphics.setColor(accentColors[player.misc.theme].buttons)
            love.graphics.rectangle("fill", 970, 610, 140, 60)
            love.graphics.setColor(accentColors[player.misc.theme].buttonOutlines)
            love.graphics.setLineWidth(2)
            love.graphics.rectangle("line", 970, 610, 140, 60, 2, 2)
            love.graphics.setFont(font_Afacad24)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.setColor(1, 0.2, 0.25, 1)
            love.graphics.printf("End Battle", 970, 622, 140, "center")
        end
    elseif player.location == "hub" then
        inHub_visual()
        if hubSection == "Science" and not player.menu.saveStats and not player.menu.settings and player.settings.tooltips then
            tooltips.displayScience()
        end
        if player.menu.saveStats then
            statsMenus.savefile.draw()
        end
    end

    if player.menu.settings then
        love.graphics.setColor(0, 0, 0, 0.5)
        love.graphics.rectangle("fill", 0, 0, 1920, 1080)
        love.graphics.setColor(accentColors[player.misc.theme].menus)
        love.graphics.rectangle("fill", 710, 240, 500, 600)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setLineWidth(1)
        love.graphics.rectangle("line", 710, 240, 500, 600, 3, 3)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setFont(font_AfacadBold32)
        love.graphics.printf("Settings", 860, 250, 200, "center")

        love.graphics.setFont(font_AfacadBold24)
        love.graphics.printf("Particles", 710, 300, 500, "center")
        love.graphics.setFont(font_Afacad20)
        love.graphics.printf(string.format("%s (x%.2f)", settings_particleMultiplierNames[player.settings.particleMultiplierIndex], settings_particleMultipliers[player.settings.particleMultiplierIndex]), 710, 330, 500, "center")
        if player.settings.particleMultiplierIndex > 1 then
            love.graphics.draw(img_button_arrowLeft, 820, 332)
        end
        if player.settings.particleMultiplierIndex < 8 then
            love.graphics.draw(img_button_arrowRight, 1076, 332)
        end

        love.graphics.setFont(font_AfacadBold24)
        love.graphics.printf("Wave Skip Messages", 710, 380, 500, "center")
        love.graphics.setFont(font_Afacad20)
        love.graphics.printf(string.format("%s", not player.settings.waveSkipMessages and "Off" or player.settings.waveSkipMessages and "On"), 710, 410, 500, "center")
        if player.settings.waveSkipMessages then
            love.graphics.draw(img_button_arrowLeft, 820, 412)
        else
            love.graphics.draw(img_button_arrowRight, 1076, 412)
        end

        love.graphics.setFont(font_AfacadBold24)
        love.graphics.printf("Notation", 710, 460, 500, "center")
        love.graphics.setFont(font_Afacad20)
        love.graphics.printf(string.format("%s", player.settings.notation == settings_notationNames[1] and "KMBT" or player.settings.notation == settings_notationNames[2] and "Scientific" or "Alphabet"), 710, 490, 500, "center")
        if player.settings.notation ~= settings_notationNames[1] then
            love.graphics.draw(img_button_arrowLeft, 820, 492)
        end
        if player.settings.notation ~= settings_notationNames[3] then
            love.graphics.draw(img_button_arrowRight, 1076, 492)
        end

        love.graphics.setFont(font_AfacadBold24)
        love.graphics.printf("Tooltips", 710, 540, 500, "center")
        love.graphics.setFont(font_Afacad20)
        love.graphics.printf(string.format("%s", not player.settings.tooltips and "Off" or player.settings.tooltips and "On"), 710, 570, 500, "center")
        if player.settings.tooltips then
            love.graphics.draw(img_button_arrowLeft, 820, 572)
        else
            love.graphics.draw(img_button_arrowRight, 1076, 572)
        end

        love.graphics.setFont(font_AfacadBold24)
        love.graphics.printf("Volume", 710, 620, 500, "center")
        love.graphics.setFont(font_Afacad20)
        love.graphics.printf(math.floor(player.settings.volume * 100) .. "%", 710, 644, 500, "center")
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.rectangle("fill", 835, 670, 250, 12)
        love.graphics.setColor(0, 1, 0, 1)
        love.graphics.rectangle("fill", 835, 670, 250 * (math.floor(player.settings.volume * 100) / 100), 12)

        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setFont(font_AfacadBold24)
        love.graphics.printf("Theme", 710, 700, 500, "center")
        love.graphics.setFont(font_Afacad20)
        love.graphics.printf(settings_themeNames[player.misc.theme], 710, 730, 500, "center")
        if player.misc.theme ~= settings_themes[1] then
            love.graphics.draw(img_button_arrowLeft, 820, 732)
        end
        if player.misc.theme ~= settings_themes[5] then
            love.graphics.draw(img_button_arrowRight, 1076, 732)
        end

        love.graphics.setColor(accentColors[player.misc.theme].buttons)
        love.graphics.rectangle("fill", 910, 780, 100, 40, 2, 2)
        love.graphics.setColor(accentColors[player.misc.theme].buttonOutlines)
        love.graphics.setLineWidth(2)
        love.graphics.rectangle("line", 910, 780, 100, 40, 2, 2)
        love.graphics.setFont(font_Afacad24)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf("Back", 910, 782, 100, "center")
    end
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(font_Afacad16)
    love.graphics.printf("v" .. gameVersionSemantic .. " - " .. love.timer.getFPS() .. "fps, " .. player.debug.memUsage .. "KB, " .. player.debug.UPS .. "ups", 1643, 0, 220, "right")
    if player.menu.debugInfo then
        love.graphics.setColor(0, 0, 0, 0.8)
        love.graphics.rectangle("fill", 0, 0, 170, 470)
        love.graphics.setColor(1, 1, 1, 0.25)
        love.graphics.setLineWidth(1)
        love.graphics.rectangle("line", -1, -1, 171, 471)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print("pjc: " .. #projectilesOnField, 5, 0)
        love.graphics.print("enc: " .. #enemiesOnField, 5, 15)
        love.graphics.print("pjt: " .. timers.projectile, 5, 45)
        love.graphics.print("ent: " .. timers.enemy, 5, 60)
        love.graphics.print("sat: " .. timers.shieldActivation, 5, 75)
        love.graphics.print("sdt: " .. timers.shieldActive, 5, 90)
        love.graphics.print("wst: " .. timers.waveSkip, 5, 105)
        love.graphics.print("cat: " .. timers.copperAdd, 5, 120)
        love.graphics.print("sam: " .. timers.silverAdd, 5, 135)
        love.graphics.print("mtt: " .. timers.magmaPool, 5, 150)
        love.graphics.print("sct: " .. timers.crystal, 5, 165)
        love.graphics.print("nwt: " .. timers.nextWave, 5, 180)
        love.graphics.print("lot: " .. timers.lightningOrb, 5, 195)
        love.graphics.print("dwt: " .. timers.disruptWave, 5, 210)
        love.graphics.print("tht: " .. player.tower.health / player.tower.regeneration, 5, 225)
        love.graphics.print("rht: " .. (player.tower.health - player.tower.currentHealth) / player.tower.regeneration, 5, 240)

        love.graphics.print("cbf: " .. misc.copperBuffer, 5, 270)
        love.graphics.print("sbf: " .. misc.silverBuffer, 5, 285)

        love.graphics.print("cpw: " .. player.tower.copperPerWave * player.tower.copperBonus, 5, 315)
        love.graphics.print("spw: " .. player.tower.silverPerWave * player.tower.silverBonus * difficultyMultipliers[player.difficulty.difficulty], 5, 330)
        love.graphics.print("dt: " .. love.timer.getDelta(), 5, 345)
        love.graphics.print("lst: " .. logicStep, 5, 360)

        love.graphics.print("bsm: " .. tostring(player.menu.battleStats), 5, 390)
        love.graphics.print("ssm: " .. tostring(player.menu.saveStats), 5, 405)
        love.graphics.print("stm: " .. tostring(player.menu.settings), 5, 420)
        love.graphics.print("gim: " .. tostring(player.menu.gameplayInfo), 5, 435)
        love.graphics.print("eim: " .. tostring(player.menu.enemyInfo), 5, 450)
    end
end

function love.update(dt)
    logicStep = math.min(dt, MAX_STEP)
    if player.debug.updateTimer < player.debug.updateInterval then
        player.debug.updateTimer = player.debug.updateTimer + dt
        player.debug.currentUpdates = player.debug.currentUpdates + 1
        player.debug.memUsage = math.floor(collectgarbage("count"))
    else
        player.debug.updateTimer = 0
        player.debug.UPS = player.debug.currentUpdates
        player.debug.currentUpdates = 0
        -- player.debug.UPS = math.floor(1 / dt)
    end
    if player.location == "round" then
        --[[ Update Exploders' animation ]]--
        exploderAnimationFrame = (exploderAnimationFrame + 14 * logicStep) % 11
        img_enemy_exploder = exploderAnimation[math.floor(exploderAnimationFrame + 1)]
        --[[ Automatically shoot the closest enemy in range ]]--
        if player.tower.currentHealth > 0 then
            if not player.menu.paused then
                towers.aurora(true, logicStep)
            end
            if timers.projectile < 1 / player.tower.attackSpeed then
                timers.projectile = timers.projectile + logicStep * gameplay.gameSpeed
            else
                local targetAmount = 1
                local clusterFireProbability = player.upgrades.unlocks.clusterFire and love.math.random() * 100 or 101
                if clusterFireProbability <= player.tower.clusterFireChance then
                    targetAmount = player.tower.clusterFireTargets
                    if enemyFuncs.findClosestEnemyInRange(960, 540, player.tower.range)[2] ~= nil then
                        player.stats.battle.clusterFire.triggered = player.stats.battle.clusterFire.triggered + 1
                        player.stats.save.clusterFire.triggered = player.stats.save.clusterFire.triggered + 1
                    end
                end
                if enemyFuncs.findClosestEnemyInRange(960, 540, player.tower.range)[1] then
                    timers.projectile = 0
                    if targetAmount == 1 then
                        local f = audio_tower_fire:clone()
                        f:setVolume(1 * player.settings.volume^2)
                        f:play()
                    end
                end
                for i=1,targetAmount do
                    if enemyFuncs.findClosestEnemyInRange(960, 540, player.tower.range)[i] then
                        local scatterFireChance = love.math.random() * 100
                        local burstFireChance = love.math.random() * 100
                        local efficiency = i == 1 and 1 or player.tower.clusterFireEfficiency / 100
                        createProjectile(957, 537, 500, false, false, i, efficiency)
                        if scatterFireChance <= levelingInfo[2].frequency[player.abilities.scatterFire.level + 1] and player.abilities.scatterFire.unlocked and player.abilities.scatterFire.equipped then
                            local sx = love.math.random(50, 1870)
                            local sy = love.math.random(50, 1030)
                            local sf = audio_tower_scatterFire__burstFire:clone()
                            sf:setVolume(1 * player.settings.volume^2)
                            sf:play()
                            for i=1,levelingInfo[2].quantity[player.abilities.scatterFire.level + 1] do
                                createProjectile(sx, sy, 500, true, false, i)
                            end
                            player.stats.battle.scatterFire.triggered = player.stats.battle.scatterFire.triggered + 1
                            player.stats.save.scatterFire.triggered = player.stats.save.scatterFire.triggered + 1
                        end
                        if burstFireChance <= levelingInfo[3].frequency[player.abilities.burstFire.level + 1] and player.abilities.burstFire.unlocked and player.abilities.burstFire.equipped then
                            local bf = audio_tower_scatterFire__burstFire:clone()
                            bf:setVolume(1 * player.settings.volume^2)
                            bf:play()
                            for i=1,levelingInfo[3].quantity[player.abilities.burstFire.level + 1] do
                                createProjectile(957, 537, 500, false, true, i)
                            end
                            player.stats.battle.burstFire.triggered = player.stats.battle.burstFire.triggered + 1
                            player.stats.save.burstFire.triggered = player.stats.save.burstFire.triggered + 1
                        end
                    end
                end
            end
            --[[ Spawn an enemy once the enemy spawn timer goes off ]]--
            if timers.enemy < 1 / enemyAttributes.spawnRate then
                timers.enemy = timers.enemy + logicStep * gameplay.gameSpeed
            else
                timers.enemy = 0
                if enemyAttributes.pendingEnemies > 0 then
                    enemyFuncs.createEnemy(enemyAttributes.health, enemyAttributes.speed, 1, enemyAttributes.attackDamage)
                    enemyAttributes.pendingEnemies = enemyAttributes.pendingEnemies - 1
                end
            end
            enemyFuncs.findClosestEnemyInRange(960, 540, player.tower.range)
        end
        --[[ Move projectiles depending on their angle ]]--
        for i=#projectilesOnField,1,-1 do
            local v = projectilesOnField[i]
            v.x = v.x + math.cos(v.angle) * v.speed * logicStep * gameplay.gameSpeed
            v.y = v.y + math.sin(v.angle) * v.speed * logicStep * gameplay.gameSpeed
            if math.dist(960, 540, v.x + 3, v.y + 3) > player.tower.range and not v.scatterFire then
                table.remove(projectilesOnField, i)
            elseif v.x + 3 < -10 or v.x + 3 > 1930 or v.y + 3 < -10 or v.y + 3 > 1090 and v.scatterFire then
                table.remove(projectilesOnField, i)
            end
            for j=#enemiesOnField,1,-1 do
                local w = enemiesOnField[j]
                local size = {
                    basic = 20,
                    tank = 32,
                    swift = 16,
                    sentry = 44,
                    centurion = 60,
                    exploder = 24
                }
                if v.x > w.x and v.x < w.x + size[w.type] and v.y > w.y and v.y < w.y + size[w.type] then
                    table.remove(projectilesOnField, i)
                    --[[ If the projectile deals crit damage, deal more damage based on Critical Factor ]]--
                    local critFactor = v.isCrit and player.tower.critFactor or 1
                    local superCritFactor = v.isSupercrit and levelingInfo[11].supercriticalFactor[player.abilities.supercritical.level + 1] or 1
                    local damage = player.tower.attackDamage * critFactor * superCritFactor * v.efficiency
                    local lifesteal = love.math.random() * 100
                    if v.scatterFire then
                        player.stats.battle.scatterFire.damageDealt = player.stats.battle.scatterFire.damageDealt + math.min(damage, w.currentHP)
                        player.stats.save.scatterFire.damageDealt = player.stats.save.scatterFire.damageDealt + math.min(damage, w.currentHP)
                    end
                    if v.burstFire then
                        player.stats.battle.burstFire.damageDealt = player.stats.battle.burstFire.damageDealt + math.min(damage, w.currentHP)
                        player.stats.save.burstFire.damageDealt = player.stats.save.burstFire.damageDealt + math.min(damage, w.currentHP)
                    end
                    if lifesteal <= player.tower.lifestealChance and gameplay.gameSpeed > 0 then
                        local oldHealth = player.tower.currentHealth
                        player.tower.currentHealth = math.min(player.tower.currentHealth + (math.min(damage, w.currentHP) * (player.tower.lifestealPercent / 100)), player.tower.health)
                        local healthGap = player.tower.currentHealth - oldHealth
                        local ls = audio_tower_lifestealTrigger:clone()
                        ls:setVolume(1 * player.settings.volume^2)
                        ls:play()
                        player.stats.battle.lifesteal.triggered = player.stats.battle.lifesteal.triggered + 1
                        player.stats.save.lifesteal.triggered = player.stats.save.lifesteal.triggered + 1
                        player.stats.battle.lifesteal.healed = player.stats.battle.lifesteal.healed + healthGap
                        player.stats.save.lifesteal.healed = player.stats.save.lifesteal.healed + healthGap
                    end
                    enemyFuncs.damageEnemy(j, damage, v.isCrit, v.isSupercrit, "projectile")
                    break
                end
            end
        end

        for i=#enemiesOnField,1,-1 do
            local v = enemiesOnField[i]
            local stopDistance = {
                basic = TOWER_SIZE + 10,
                tank = TOWER_SIZE + 16,
                swift = TOWER_SIZE + 8,
                sentry = TOWER_SIZE + 22,
                centurion = TOWER_SIZE + 30,
                exploder = TOWER_SIZE + 12
                }
            local iceDomainSpeedMultiplier = player.misc.iceDomainActive and 1 - levelingInfo[4].density[player.abilities.iceDomain.level + 1] / 100 or 1
            if v.burningTime > 0 and gameplay.gameSpeed > 0 then
                for i=1,love.math.random(-4, 1) * settings_particleMultipliers[player.settings.particleMultiplierIndex] do
                    createBurnParticle(v.x, v.y, v.type)
                end
            end
            if v.timer_untilAttack < (1 / v.attackSpeed) / iceDomainSpeedMultiplier then
                v.timer_untilAttack = v.timer_untilAttack + logicStep * gameplay.gameSpeed
            else
                --[[ If an enemy is close enough, start attacking the tower ]]--
                local damageReduction = not v.resistanceIgnore and 1 - player.tower.resistance / 100 or 1
                local da = audio_tower_damageAbsorbed:clone()
                local dk = audio_tower_damageTaken:clone()
                if math.dist(v.x + enemyOffsets[v.type], v.y + enemyOffsets[v.type], 960, 540) < stopDistance[v.type] + 1 and player.tower.currentHealth > 0 and v.type ~= "exploder" then
                    v.timer_untilAttack = 0
                    if not v.shieldIgnore then
                        if not shieldActive then
                            player.tower.currentHealth = player.tower.currentHealth - v.attackDamage * damageReduction
                            player.stats.battle.damageTaken = player.stats.battle.damageTaken + v.attackDamage * damageReduction
                            dk:setVolume(1 * player.settings.volume^2)
                            dk:play()
                        else
                            player.stats.battle.shieldDamageAbsorb = player.stats.battle.shieldDamageAbsorb + v.attackDamage * damageReduction
                            da:setVolume(1 * player.settings.volume^2)
                            da:play()
                        end
                    else
                        player.tower.currentHealth = player.tower.currentHealth - v.attackDamage * damageReduction
                        player.stats.battle.damageTaken = player.stats.battle.damageTaken + v.attackDamage * damageReduction
                        dk:setVolume(1 * player.settings.volume^2)
                        dk:play()
                    end
                elseif math.dist(v.x + enemyOffsets[v.type], v.y + enemyOffsets[v.type], 960, 540) < 100 and player.tower.currentHealth > 0 and v.type == "exploder" then
                    local exploderAoE = {}
                    exploderAoE.x = v.x
                    exploderAoE.y = v.y
                    exploderAoE.timer = 0
                    exploderAoE.id = love.math.random(1, 65535)
                    table.insert(exploderAoEs, exploderAoE)
                    table.remove(enemiesOnField, i)
                end
            end
            --[[ Move each enemy towards the central tower if it is further than the specified distance ]]--
            if math.dist(v.x + enemyOffsets[v.type], v.y + enemyOffsets[v.type], 960, 540) > stopDistance[v.type] then
                local hyperloopMultiplier = math.dist(v.x + enemyOffsets[v.type], v.y + enemyOffsets[v.type], 960, 540) > player.tower.range and 1 + player.modifiers.hyperloop.value / 100 or 1
                local iceDomainSpeedMultiplier = (player.misc.iceDomainActive and math.dist(v.x + enemyOffsets[v.type], v.y + enemyOffsets[v.type], 960, 540) <= player.tower.range) and 1 - levelingInfo[4].density[player.abilities.iceDomain.level + 1] / 100 or 1
                v.angle = math.atan2(540 - v.y - 2 - enemyOffsets[v.type], 960 - v.x - 2 - enemyOffsets[v.type])
                v.x = v.x + math.cos(v.angle) * v.speed * logicStep * gameplay.gameSpeed * hyperloopMultiplier * iceDomainSpeedMultiplier
                v.y = v.y + math.sin(v.angle) * v.speed * logicStep * gameplay.gameSpeed * hyperloopMultiplier * iceDomainSpeedMultiplier
            end
            --[[ Regenerate 1% of Centurion health per second ]]
            if v.type == "centurion" and player.tower.currentHealth > 0 then
                if v.currentHP < v.maxHP then
                    v.currentHP = math.min(v.currentHP + v.maxHP * (0.01 * logicStep * gameplay.gameSpeed), v.maxHP)
                    centurionCurrentHP = v.currentHP
                end
            end
            if player.abilities.magmaTouch.unlocked and player.abilities.magmaTouch.equipped then
                if v.burningTime > 0 then
                    v.burningTime = v.burningTime - logicStep * gameplay.gameSpeed
                    v.burningUntilDamage = v.burningUntilDamage - logicStep * gameplay.gameSpeed
                end
                if v.burningUntilDamage < 0 then
                    enemyFuncs.damageEnemy(i, player.tower.attackDamage * (levelingInfo[5].damage[player.abilities.magmaTouch.level + 1] / 100), false, false, "magmaPool")
                    v.burningUntilDamage = 1
                end
            end
        end
        for i=#exploderAoEs,1,-1 do
            local v = exploderAoEs[i]
            v.timer = v.timer + logicStep * gameplay.gameSpeed
            if v.timer >= exploderExplodeTime then
                for j,w in ipairs(enemiesOnField) do
                    table.remove(w.hitByExploderIDs, v.id)
                end
                table.remove(exploderAoEs, i)
            end
            local cs = math.min((v.timer / exploderExplodeTime)^0.5, 1) * 200
            for j,w in ipairs(enemiesOnField) do
                if math.dist(w.x + enemyOffsets[w.type], w.y + enemyOffsets[w.type], v.x, v.y) <= cs / 2 and not technical.findItemInList(v.id, w.hitByExploderIDs) then
                    enemyFuncs.damageEnemy(i, enemyAttributes.attackDamage * 2.5, false, false, "exploder")
                    table.insert(w.hitByExploderIDs, v.id)
                end 
            end
            if math.dist(v.x, v.y, 960, 540) <= 30 + (math.min(v.timer * 4, 0.75) * 108) then
                local damageReduction = not v.resistanceIgnore and 1 - player.tower.resistance / 100 or 1
                local da = audio_tower_damageAbsorbed:clone()
                local dk = audio_tower_damageTaken:clone()
                if not shieldActive then
                    player.tower.currentHealth = player.tower.currentHealth - enemyAttributes.attackDamage * 2.5 * damageReduction
                    player.stats.battle.damageTaken = player.stats.battle.damageTaken + enemyAttributes.attackDamage * 2.5 * damageReduction
                    dk:setVolume(1 * player.settings.volume^2)
                    dk:play()
                else
                    player.stats.battle.shieldDamageAbsorb = player.stats.battle.shieldDamageAbsorb + enemyAttributes.attackDamage * 2.5 * damageReduction
                    da:setVolume(1 * player.settings.volume^2)
                    da:play()
                end
            end
        end
        for i,v in ipairs(meteors) do
            --[[ Orbit Meteors around the tower ]]--
            local potentialParticlePos = {
                {960 + (player.tower.range + 40 + love.math.random(-14, 14)) * math.cos(v.angle - 0.024 * math.pi), 540 + (player.tower.range + 40 + love.math.random(-14, 14)) * math.sin(v.angle - 0.024 * math.pi)},
                {960 + (player.tower.range + 40 + love.math.random(-14, 14)) * math.cos(v.angle - 0.018 * math.pi), 540 + (player.tower.range + 40 + love.math.random(-14, 14)) * math.sin(v.angle - 0.018 * math.pi)}
            }
            v.angle = v.angle + (player.tower.meteorRPM * (2 * math.pi)) / 60 * logicStep * gameplay.gameSpeed
            v.x = 960 + (player.tower.range + 40) * math.cos(v.angle)
            v.y = 540 + (player.tower.range + 40) * math.sin(v.angle)
            if v.timer_particle < v.particleFreq then
                v.timer_particle = v.timer_particle + logicStep * gameplay.gameSpeed
            else
                for i=1,love.math.random(1, 2) * settings_particleMultipliers[player.settings.particleMultiplierIndex] do
                    createMeteorParticle(love.math.random(potentialParticlePos[1][1], potentialParticlePos[2][1]), love.math.random(potentialParticlePos[1][2], potentialParticlePos[2][2]))
                end
                v.timer_particle = 0
            end
            local size = {
                basic = 20,
                tank = 32,
                swift = 16,
                sentry = 44,
                centurion = 60,
                exploder = 12
            }
            for j,w in ipairs(enemiesOnField) do
                if v.x + 13 > w.x and v.x - 13 < w.x + size[w.type] and v.y + 13 > w.y and v.y - 13 < w.y + size[w.type] and player.tower.currentHealth > 0 then
                    if w.type == "basic" or w.type == "tank" or w.type == "swift" or w.type == "exploder" then
                        enemyFuncs.killEnemy(j, "meteor")
                    end
                end
            end
        end
        abilityObjects.spikedCrystal.process(logicStep)
        abilityObjects.magmaPool.process(logicStep)
        abilityObjects.lightningOrb.process(logicStep)
        abilityObjects.lightningOrb_laser.process(logicStep)

        --[[ If no enemies on field are present and the wave enemy cap is reached, wait a few seconds before advancing to the next wave ]]--
        if player.tower.currentHealth > 0 then
            if #enemiesOnField == 0 and enemyAttributes.pendingEnemies <= 0 then
                if timers.nextWave < gameplay.waveCooldown then
                    timers.nextWave = timers.nextWave + logicStep * gameplay.gameSpeed
                else
                    wavesSkipped = 0
                    timers.nextWave = 0

                    local oldCopperAmount = player.currencies.currentCopper
                    misc.copperBuffer = misc.copperBuffer + player.tower.copperBonus * (player.tower.copperPerWave % 1)
                    player.currencies.currentCopper = player.currencies.currentCopper + math.floor(player.tower.copperBonus) * player.tower.copperPerWave
                    if misc.copperBuffer >= 1 then
                        player.currencies.currentCopper = player.currencies.currentCopper + math.floor(misc.copperBuffer)
                        misc.copperBuffer = misc.copperBuffer - math.floor(misc.copperBuffer)
                    end
                    local newCopperAmount = player.currencies.currentCopper
                    local copperEarned = newCopperAmount - oldCopperAmount
                    player.stats.battle.copperEarned = player.stats.battle.copperEarned + copperEarned
                    player.misc.copperAddedMessage = true

                    local oldSilverAmount = player.currencies.currentSilver
                    misc.silverBuffer = misc.silverBuffer + player.tower.silverBonus * (player.tower.silverPerWave % 1) * difficultyMultipliers[gameplay.difficulty]
                    player.currencies.currentSilver = player.currencies.currentSilver + math.floor(player.tower.silverBonus) * player.tower.silverPerWave * difficultyMultipliers[gameplay.difficulty]
                    if misc.silverBuffer >= 1 then
                        player.currencies.currentSilver = player.currencies.currentSilver + math.floor(misc.silverBuffer)
                        misc.silverBuffer = misc.silverBuffer - math.floor(misc.silverBuffer)
                    end
                    local newSilverAmount = player.currencies.currentSilver
                    local silverEarned = newSilverAmount - oldSilverAmount
                    player.stats.battle.silverEarned = player.stats.battle.silverEarned + silverEarned
                    player.stats.save.silverEarned = player.stats.save.silverEarned + silverEarned
                    player.misc.silverAddedMessage = true

                    gameplay.wave = gameplay.wave + 1
                    player.stats.save.wavesBeaten = player.stats.save.wavesBeaten + 1
                    local waveSkip = love.math.random() * 100
                    while waveSkip <= player.modifiers.waveSkip.value do
                        wavesSkipped = wavesSkipped + 1
                        local waveSkip = love.math.random() * 100
                        if waveSkip > player.modifiers.waveSkip.value then
                            break
                        end
                    end
                    local JerelosBlessingRegen = player.abilities.JerelosBlessing.equipped and love.math.random() * 100 or 101
                    if JerelosBlessingRegen <= levelingInfo[7].regenChance[player.abilities.JerelosBlessing.level + 1] * player.upgrades.nexus.abilityChance.value then
                        local healthGap = player.tower.health - player.tower.currentHealth
                        player.tower.currentHealth = player.tower.health
                        player.stats.battle.JerelosBlessing.triggered = player.stats.battle.JerelosBlessing.triggered + 1
                        player.stats.save.JerelosBlessing.triggered = player.stats.save.JerelosBlessing.triggered + 1
                        player.stats.battle.JerelosBlessing.healthRegenerated = player.stats.battle.JerelosBlessing.healthRegenerated + healthGap
                        player.stats.save.JerelosBlessing.healthRegenerated = player.stats.save.JerelosBlessing.healthRegenerated + healthGap
                    end
                    skipWave(wavesSkipped)
                    enemyFuncs.updateEnemyStats(gameplay.difficulty, gameplay.wave)
                end
            end
        end

        --[[ Regenerate health every frame, cap at max health if regeneration overflows ]]--
        if player.tower.currentHealth < player.tower.health and player.tower.currentHealth > 0 then
            player.tower.currentHealth = math.min(player.tower.currentHealth + player.tower.regeneration * logicStep * gameplay.gameSpeed, player.tower.health)
        end

        if player.misc.waveSkipMessage and timers.waveSkip < 3 then
            timers.waveSkip = timers.waveSkip + logicStep
        else
            timers.waveSkip = 0
            player.misc.waveSkipMessage = false
        end
        if player.misc.copperAddedMessage and timers.copperAdd < 2 then
            timers.copperAdd = timers.copperAdd + logicStep
        else
            timers.copperAdd = 0
            player.misc.copperAddedMessage = false
        end
        if player.misc.silverAddedMessage and timers.silverAdd < 2 then
            timers.silverAdd = timers.silverAdd + logicStep
        else
            timers.silverAdd = 0
            player.misc.silverAddedMessage = false
        end

        if player.upgrades.unlocks.shield then
            --[[ Count time until Shield activation, activate Shield for a specified time when cooldown ends (only if Shield upgrades are unlocked) ]]--
            if not shieldActive then
                if timers.shieldActivation < player.tower.shieldCooldown then
                    timers.shieldActivation = timers.shieldActivation + logicStep * gameplay.gameSpeed
                else
                    timers.shieldActivation = 0
                    shieldActive = true
                end
            elseif shieldActive then
                if timers.shieldActive < player.tower.shieldDuration then
                    timers.shieldActive = timers.shieldActive + logicStep * gameplay.gameSpeed
                else
                    timers.shieldActive = 0
                    shieldActive = false
                end
            end
        end

        checkIfTowerCollapsed()
        updateParticles(logicStep)

        player.stats.battle.gameTime = player.stats.battle.gameTime + logicStep * gameplay.gameSpeed
        player.stats.battle.realTime = player.stats.battle.realTime + logicStep * (gameplay.gameSpeed ~= 0 and 1 or 0)

        if player.abilities.iceDomain.unlocked and player.abilities.iceDomain.equipped then
            if gameplay.wave >= 20 and (gameplay.wave % 10 <= 4) then
                if not player.misc.iceDomainActive then
                    player.misc.iceDomainActive = true
                    player.stats.battle.iceDomain.triggered = player.stats.battle.iceDomain.triggered + 1
                    player.stats.save.iceDomain.triggered = player.stats.save.iceDomain.triggered + 1
                end
            else
                player.misc.iceDomainActive = false
            end
        end

        if player.abilities.magmaTouch.unlocked and player.abilities.magmaTouch.equipped then
            if timers.magmaPool < levelingInfo[5].frequency[player.abilities.magmaTouch.level + 1] then
                timers.magmaPool = timers.magmaPool + logicStep * gameplay.gameSpeed
            else
                if #magmaPools < 20 then
                    timers.magmaPool = 0
                    abilityObjects.magmaPool.spawn()
                end
            end
        end

        if player.abilities.disruptWave.unlocked and player.abilities.disruptWave.equipped then
            if timers.disruptWave < levelingInfo[12].frequency then
                timers.disruptWave = timers.disruptWave + logicStep * gameplay.gameSpeed
            else
                local damage = player.tower.attackDamage * levelingInfo[12].damage[player.abilities.disruptWave.level + 1]
                player.stats.battle.disruptWave.triggered = player.stats.battle.disruptWave.triggered + 1
                player.stats.save.disruptWave.triggered = player.stats.save.disruptWave.triggered + 1
                for i=#enemyFuncs.findClosestEnemyInRange(960, 540, player.tower.range),1,-1 do
                    enemyFuncs.damageEnemy(i, damage, false, false, "disruptWave")
                end
                timers.disruptWave = 0
            end
        end

        if player.abilities.lightningOrb.unlocked and player.abilities.lightningOrb.equipped then
            if timers.lightningOrb < levelingInfo[6].frequency[player.abilities.lightningOrb.level + 1] then
                timers.lightningOrb = timers.lightningOrb + logicStep * gameplay.gameSpeed
            else
                timers.lightningOrb = 0
                abilityObjects.lightningOrb.spawn()
                player.stats.battle.lightningOrb.spawned = player.stats.battle.lightningOrb.spawned + 1
                player.stats.save.lightningOrb.spawned = player.stats.save.lightningOrb.spawned + 1
            end
        end

        if player.menu.battleStats then
            statsMenus.battle.process(logicStep)
        elseif player.menu.enemyInfo then
            statsMenus.enemyInfo.process(logicStep)
        end

    elseif player.location == "hub" then
        player.abilities.equipped = 0
        for i=1,#internalAbilities do
            if internalAbilities[i].equipped then
                player.abilities.equipped = player.abilities.equipped + 1
            end
        end
        if player.menu.saveStats then
            statsMenus.savefile.process(logicStep)
        end
    end
    if love.mouse.isDown(1) then
        local mcx, mcy = love.mouse.getPosition()
        if player.menu.settings then
            if mcx >= 835 and mcx <= 1085 and mcy >= 670 and mcy <= 682 then
                player.settings.volume = math.floor((mcx - 835) / 250 * 200) / 200
                -- audioST_Echoes:setVolume(1 * player.settings.volume^2)
            end
        end
    end
    --[[ Set a timer for alloying Electrum, add 1 Electrum when the timer runs out ]]--
    if not player.canClaim.electrum then
        if player.timers.electrum < player.cooldowns.electrum then
            player.timers.electrum = player.timers.electrum + logicStep
        else
            player.timers.electrum = 0
            player.canClaim.electrum = true
            player.currencies.currentElectrum = player.currencies.currentElectrum + 1
        end
    end
    if not player.canClaim.tokens then
        if player.timers.tokens < player.cooldowns.tokens then
            player.timers.tokens = player.timers.tokens + logicStep
        else
            player.timers.tokens = 0
            player.canClaim.tokens = true
        end
    end
    if not player.canClaim.ability and player.misc.abilityAssembling then
        if player.timers.abilityAssembly < player.cooldowns.abilityAssembly_current then
            player.timers.abilityAssembly = player.timers.abilityAssembly + logicStep
        else
            player.timers.abilityAssembly = player.cooldowns.abilityAssembly_current
            player.canClaim.ability = true
            player.misc.abilityAssembling = false
        end
    end
    local oldIdleTime = math.floor(player.idleTime / 60)
    player.idleTime = math.min(player.idleTime + logicStep, 21600)
    if math.floor(player.idleTime / 60) > oldIdleTime then
        player.storedGains.silver = player.storedGains.silver + player.idleGains.silver
        player.storedGains.gold = player.storedGains.gold + player.idleGains.gold
    end
end

function love.mousepressed(x, y)

    upgradeMenu_mouse_new(x, y)

    if player.tower.currentHealth > 0 then
        --[[ Open/close upgrade menu ]]--
        if x >= 860 and x <= 1060 and y >= 1030 and y <= 1080 and not player.menu.upgrades and not player.menu.paused and not player.menu.gameplayInfo and not player.menu.battleStats and player.location == "round" then
            player.menu.upgrades = true
        elseif x >= 860 and x <= 1060 and y >= 750 and y <= 800 and player.menu.upgrades and not player.menu.paused and not player.menu.gameplayInfo and not player.menu.battleStats and player.location == "round" then
            player.menu.upgrades = false
        end

        if x >= 1870 and x <= 1910 and y >= 10 and y <= 50 and not player.menu.paused and not player.menu.gameplayInfo and not player.menu.battleStats and player.location == "round" then
            gameplay.gameSpeed = 0
            player.menu.paused = true
        end

        if x >= 810 and x <= 950 and y >= 610 and y <= 670 and player.menu.paused and not player.menu.settings and not player.menu.gameplayInfo and not player.menu.battleStats and player.location == "round" then
            gameplay.gameSpeed = player.maxGameSpeed
            player.menu.paused = false
        elseif x >= 970 and x <= 1110 and y >= 610 and y <= 670 and player.menu.paused and not player.menu.settings and not player.menu.gameplayInfo and not player.menu.battleStats and player.location == "round" then
            gameplay.gameSpeed = player.maxGameSpeed
            player.menu.paused = false
            player.tower.currentHealth = 0
        elseif x >= 890 and x <= 1030 and y >= 560 and y <= 600 and player.menu.paused and not player.menu.settings and not player.menu.gameplayInfo and not player.menu.battleStats and player.location == "round" then
            player.menu.settings = true
        end
    end

    if player.menu.settings then
        if x >= 820 and x <= 844 and y >= 332 and y <= 356 and player.settings.particleMultiplierIndex > 1 then
            player.settings.particleMultiplierIndex = player.settings.particleMultiplierIndex - 1
        elseif x >= 1076 and x <= 1100 and y >= 332 and y <= 356 and player.settings.particleMultiplierIndex < 8 then
            player.settings.particleMultiplierIndex = player.settings.particleMultiplierIndex + 1
        end

        if x >= 820 and x <= 844 and y >= 412 and y <= 436 and player.settings.waveSkipMessages then
            player.settings.waveSkipMessages = false
        elseif x >= 1076 and x <= 1100 and y >= 412 and y <= 436 and not player.settings.waveSkipMessages then
            player.settings.waveSkipMessages = true
        end

        if x >= 820 and x <= 844 and y >= 492 and y <= 516 and player.settings.notation ~= settings_notationNames[1] then
            if player.settings.notation == settings_notationNames[3] then
                player.settings.notation = settings_notationNames[2]
            elseif player.settings.notation == settings_notationNames[2] then
                player.settings.notation = settings_notationNames[1]
            end
        elseif x >= 1076 and x <= 1100 and y >= 492 and y <= 516 and player.settings.notation ~= settings_notationNames[3] then
            if player.settings.notation == settings_notationNames[1] then
                player.settings.notation = settings_notationNames[2]
            elseif player.settings.notation == settings_notationNames[2] then
                player.settings.notation = settings_notationNames[3]
            end
        end

        if x >= 820 and x <= 844 and y >= 572 and y <= 596 and player.settings.tooltips then
            player.settings.tooltips = false
        elseif x >= 1076 and x <= 1100 and y >= 572 and y <= 596 and not player.settings.tooltips then
            player.settings.tooltips = true
        end

        local themeIndex = 0
        for i,v in ipairs(settings_themes) do
            if player.misc.theme == v then
                themeIndex = i
            end
        end
        if x >= 820 and x <= 844 and y >= 732 and y <= 756 and player.misc.theme ~= settings_themes[1] then
            player.misc.theme = settings_themes[themeIndex - 1]
        elseif x >= 1076 and x <= 1100 and y >= 732 and y <= 756 and player.misc.theme ~= settings_themes[5] then
            player.misc.theme = settings_themes[themeIndex + 1]
        end

        if x >= 910 and x <= 1010 and y >= 780 and y <= 820 then
            player.menu.settings = false
        end
    end

    if player.menu.gameplayInfo then
        if x >= 1210 and x <= 1246 and y >= 522 and y <= 558 and not player.menu.enemyInfo then
            player.menu.gameplayInfo = false
            player.menu.battleStats = true
            statsMenus.resetScroll()
        elseif x >= 890 and x <= 1030 and y >= 790 and y <= 830 and not player.menu.enemyInfo then
            player.menu.enemyInfo = true
            statsMenus.resetScroll()
        elseif x >= 890 and x <= 1030 and y >= 820 and y <= 860 and player.menu.enemyInfo then
            player.menu.enemyInfo = false
        end
    elseif player.menu.battleStats and player.tower.currentHealth > 0 then
        if x >= 674 and x <= 710 and y >= 522 and y <= 558 then
            player.menu.gameplayInfo = true
            player.menu.battleStats = false
        end
    end

    --[[ If the "To Hub" button is pressed at the end screen, go to Hub ]]--
    if gameOver and #collapseParticles == 0 and player.location == "round" and not player.menu.gameplayInfo and not player.menu.battleStats then
        if x >= 890 and x <= 1030 and y >= 570 and y <= 610 then
            player.menu.battleStats = true
            statsMenus.resetScroll()
        elseif x >= 870 and x <= 1050 and y >= 620 and y <= 680 then
            player.menu.upgrades = false
            player.location = "hub"
            gameplay.gameSpeed = 1
            player.menu.paused = false
            hubSection = "Main"
            resetRoundValues()
            upgradeModuleFuncs.load()
            player.idleGains.silver, player.idleGains.gold = reloadIdleGains()
        end
    end

    if player.menu.battleStats then
        if x >= 910 and x <= 1010 and y >= 780 and y <= 820 then
            player.menu.gameplayInfo = false
            player.menu.battleStats = false
            gameplay.gameSpeed = player.menu.gameplayInfo and 0 or player.maxGameSpeed
        end
    end

    inHub_mouse(x, y)
end

function love.keypressed(key)
    if key == "escape" then
        if player.location == "hub" then
            saveGame()
            love.event.quit()
        elseif not player.menu.settings and not player.menu.battleStats and not player.menu.gameplayInfo and not gameOver then
            gameplay.gameSpeed = player.menu.paused and player.maxGameSpeed or 0
            player.menu.paused = not player.menu.paused
        end
    end
    if love.keyboard.isDown("w") and key == "f2" then
        player.menu.debugInfo = not player.menu.debugInfo
    end
    if key == "tab" and not player.menu.paused then
        if player.location == "round" then
            if not player.menu.battleStats and not player.menu.enemyInfo then
                player.menu.gameplayInfo = not player.menu.gameplayInfo
                gameplay.gameSpeed = player.menu.gameplayInfo and 0 or player.maxGameSpeed
            elseif player.menu.battleStats then
                player.menu.gameplayInfo = false
                player.menu.battleStats = false
                gameplay.gameSpeed = player.menu.gameplayInfo and 0 or player.maxGameSpeed
                statsMenus.resetScroll()
            end
        elseif player.location == "hub" and not player.menu.settings and not abilityFunctions.checkMenuDisplay() then
            if player.menu.saveStats then
                statsMenus.resetScroll()
            end
            player.menu.saveStats = not player.menu.saveStats
        end
    end
end

--[[function love.wheelmoved(x, y)
    local mcx, mcy = love.mouse.getPosition()
    if player.menu.settings then
        if mcx >= 835 and mcx <= 1085 and mcy >= 670 and mcy <= 698 then
            player.settings.volume = y > 0 and math.min(player.settings.volume + 0.05, 1) or math.max(player.settings.volume - 0.05, 0)
        end
    end
end]]-- old function for volume control

function love.quit()
    saveGame()
end