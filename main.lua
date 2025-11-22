function love.load()
    lume = require "lume"
    require "technical"
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
    settings_particleMultipliers = {0, 0.25, 0.75, 1, 1.5, 2, 3, 5}
    difficultyMultipliers = {1, 1.4, 1.75, 2.1, 2.4}
    assetReload()
    fontReload()
    resetRoundValues()
    towers.reload()
    processUpgradeModule.reload()
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

processUpgradeModule = {}

---Simply reloads all Battle/Science upgrade modules and upgrade unlock panels with their respective effects and costs.
function processUpgradeModule.reload()
    upgradeModules = {
        round = {
            ["ATK"] = {
                {"Damage", 10, 850, 350, 60, player.tower.attackDamage, player.upgrades.round.attackDamage.cost, player.upgrades.round.attackDamage.level, "round", math.huge, "precise", nil, nil, ["precedingUpgrade"] = 0}, --Attack Damage Science upgrade
                {"Attack Speed", 10, 920, 350, 60, player.tower.attackSpeed, player.upgrades.round.attackSpeed.cost, player.upgrades.round.attackSpeed.level, "round", 106, "precise2", nil, nil, ["precedingUpgrade"] = 0}, --Attack Speed Science upgrade
                {"Critical Chance", 10, 990, 350, 60, player.tower.critChance, player.upgrades.round.critChance.cost, player.upgrades.round.critChance.level, "round", 81, "precise", nil, "%", ["precedingUpgrade"] = player.upgrades.unlocks.crit}, --Critical Chance Science upgrade
                {"Critical Factor", 370, 850, 350, 60, player.tower.critFactor, player.upgrades.round.critFactor.cost, player.upgrades.round.critFactor.level, "round", 181, "precise2", "x", nil, ["precedingUpgrade"] = player.upgrades.unlocks.crit}, --Critical Factor Science upgrade
                {"Range", 370, 920, 350, 60, player.tower.range, player.upgrades.round.range.cost, player.upgrades.round.range.level, "round", 81, "precise", nil, nil, ["precedingUpgrade"] = player.upgrades.unlocks.range}, --Range Science upgrade
                {"Cluster Fire Chance", 370, 990, 350, 60, player.tower.clusterFireChance, player.upgrades.round.clusterFireChance.cost, player.upgrades.round.clusterFireChance.level, "round", 121, "precise2", nil, "%", ["precedingUpgrade"] = player.upgrades.unlocks.clusterFire}, --Cluster Fire Chance Science upgrade
                {"Cluster Fire Targets", 730, 850, 350, 60, player.tower.clusterFireTargets, player.upgrades.round.clusterFireTargets.cost, player.upgrades.round.clusterFireTargets.level, "round", 5, "brief", nil, nil, ["precedingUpgrade"] = player.upgrades.unlocks.clusterFire}, --Range Science upgrade
                {"Cluster Fire Efficiency", 730, 920, 350, 60, player.tower.clusterFireEfficiency, player.upgrades.round.clusterFireEfficiency.cost, player.upgrades.round.clusterFireEfficiency.level, "round", 144, "precise2", nil, "%", ["precedingUpgrade"] = player.upgrades.unlocks.clusterFire}, --Range Science upgrade
            },

            ["VIT"] = {
                {"Health", 10, 850, 350, 60, player.tower.health, player.upgrades.round.health.cost, player.upgrades.round.health.level, "round", math.huge, "precise", nil, nil, ["precedingUpgrade"] = 0}, --Health Science Upgrade
                {"Regeneration", 10, 920, 350, 60, player.tower.regeneration, player.upgrades.round.regeneration.cost, player.upgrades.round.regeneration.level, "round", math.huge, "precise2", nil, "/s", ["precedingUpgrade"] = 0}, --Regeneration Science Upgrade
                {"Resistance", 10, 990, 350, 60, player.tower.resistance, player.upgrades.round.resistance.cost, player.upgrades.round.resistance.level, "round", 101, "precise2", nil, "%", ["precedingUpgrade"] = player.upgrades.unlocks.resistance}, --Resistance Science Upgrade
                {"Shield Cooldown", 370, 850, 350, 60, player.tower.shieldCooldown, player.upgrades.round.shieldCooldown.cost, player.upgrades.round.shieldCooldown.level, "round", 126, "precise", nil, "s", ["precedingUpgrade"] = player.upgrades.unlocks.shield}, --Shield Cooldown Science Upgrade
                {"Shield Duration", 370, 920, 350, 60, player.tower.shieldDuration, player.upgrades.round.shieldDuration.cost, player.upgrades.round.shieldDuration.level, "round", 111, "precise2", nil, "s", ["precedingUpgrade"] = player.upgrades.unlocks.shield}, --Shield Duration Science Upgrade
                {"Meteor Amount", 370, 990, 350, 60, player.tower.meteorAmount, player.upgrades.round.meteorAmount.cost, player.upgrades.round.meteorAmount.level, "round", 6, "brief", nil, nil, ["precedingUpgrade"] = player.upgrades.unlocks.meteor}, --Meteor Amount Science Upgrade
                {"Meteor RPM", 730, 850, 350, 60, player.tower.meteorRPM, player.upgrades.round.meteorRPM.cost, player.upgrades.round.meteorRPM.level, "round", 40, "precise2", nil, nil, ["precedingUpgrade"] = player.upgrades.unlocks.meteor}, --Meteor RPM Science Upgrade
                {"Lifesteal Chance", 730, 920, 350, 60, player.tower.lifestealChance, player.upgrades.round.lifestealChance.cost, player.upgrades.round.lifestealChance.level, "round", 41, "precise", nil, "%", ["precedingUpgrade"] = player.upgrades.unlocks.lifesteal, "lifesteal"}, --Lifesteal Chance Science upgrade
                {"Lifesteal Percent", 730, 990, 350, 60, player.tower.lifestealPercent, player.upgrades.round.lifestealPercent.cost, player.upgrades.round.lifestealPercent.level, "round", 76, "precise2", nil, "%", ["precedingUpgrade"] = player.upgrades.unlocks.lifesteal, "lifesteal"}, --Lifesteal Percent Science upgrade
            },

            ["UTL"] = {
                {"Copper/Wave", 10, 850, 350, 60, player.tower.copperPerWave, player.upgrades.round.copperPerWave.cost, player.upgrades.round.copperPerWave.level, "round", math.huge, "precise", nil, nil, ["precedingUpgrade"] = 0}, --Copper/wave Science Upgrade
                {"Silver/Wave", 10, 920, 350, 60, player.tower.silverPerWave, player.upgrades.round.silverPerWave.cost, player.upgrades.round.silverPerWave.level, "round", math.huge, "precise", nil, nil, ["precedingUpgrade"] = 0}, --Silver/wave Science Upgrade
                {"Copper Bonus", 10, 990, 350, 60, player.tower.copperBonus, player.upgrades.round.copperBonus.cost, player.upgrades.round.copperBonus.level, "round", 451, "precise2", "x", nil, ["precedingUpgrade"] = player.upgrades.unlocks.resourceBonus}, --Copper Bonus Science Upgrade
                {"Silver Bonus", 370, 850, 350, 60, player.tower.silverBonus, player.upgrades.round.silverBonus.cost, player.upgrades.round.silverBonus.level, "round", 301, "precise2", "x", nil, ["precedingUpgrade"] = player.upgrades.unlocks.resourceBonus} --Silver Bonus Science Upgrade
            }
        },
        science = {
            ["ATK"] = {
                {"Damage", 245, 240, 350, 60, player.tower.attackDamage, player.upgrades.science.attackDamage.cost, player.upgrades.science.attackDamage.level, "science", math.huge, "precise", nil, nil, ["precedingUpgrade"] = 0}, --Attack Damage Science upgrade
                {"Attack Speed", 605, 240, 350, 60, player.tower.attackSpeed, player.upgrades.science.attackSpeed.cost, player.upgrades.science.attackSpeed.level, "science", 106, "precise2", nil, nil, ["precedingUpgrade"] = 0}, --Attack Speed Science upgrade
                {"Critical Chance", 965, 240, 350, 60, player.tower.critChance, player.upgrades.science.critChance.cost, player.upgrades.science.critChance.level, "science", 81, "precise", nil, "%", ["precedingUpgrade"] = player.upgrades.unlocks.crit, "crit"}, --Critical Chance Science upgrade
                {"Critical Factor", 1325, 240, 350, 60, player.tower.critFactor, player.upgrades.science.critFactor.cost, player.upgrades.science.critFactor.level, "science", 181, "precise2", "x", nil, ["precedingUpgrade"] = player.upgrades.unlocks.crit, "crit"}, --Critical Factor Science upgrade
                {"Range", 245, 310, 350, 60, player.tower.range, player.upgrades.science.range.cost, player.upgrades.science.range.level, "science", 81, "precise", nil, nil, ["precedingUpgrade"] = player.upgrades.unlocks.range, "range"}, --Range Science upgrade
                {"Cluster Fire Chance", 605, 310, 350, 60, player.tower.clusterFireChance, player.upgrades.science.clusterFireChance.cost, player.upgrades.science.clusterFireChance.level, "science", 121, "precise2", nil, "%", ["precedingUpgrade"] = player.upgrades.unlocks.clusterFire, "clusterFire"}, --Cluster Fire Chance Science upgrade
                {"Cluster Fire Targets", 965, 310, 350, 60, player.tower.clusterFireTargets, player.upgrades.science.clusterFireTargets.cost, player.upgrades.science.clusterFireTargets.level, "science", 5, "brief", nil, nil, ["precedingUpgrade"] = player.upgrades.unlocks.clusterFire, "clusterFire"}, --Cluster Fire Targets Science upgrade
                {"Cluster Fire Efficiency", 1325, 310, 350, 60, player.tower.clusterFireEfficiency, player.upgrades.science.clusterFireEfficiency.cost, player.upgrades.science.clusterFireEfficiency.level, "science", 144, "precise2", nil, "%", ["precedingUpgrade"] = player.upgrades.unlocks.clusterFire, "clusterFire"}, --Cluster Fire Targets Science upgrade
            },

            ["VIT"] = {
                {"Health", 245, 540, 350, 60, player.tower.health, player.upgrades.science.health.cost, player.upgrades.science.health.level, "science", math.huge, "precise", nil, nil, ["precedingUpgrade"] = 0}, --Health Science Upgrade
                {"Regeneration", 605, 540, 350, 60, player.tower.regeneration, player.upgrades.science.regeneration.cost, player.upgrades.science.regeneration.level, "science", math.huge, "precise2", nil, "/s", ["precedingUpgrade"] = 0}, --Regeneration Science Upgrade
                {"Resistance", 965, 540, 350, 60, player.tower.resistance, player.upgrades.science.resistance.cost, player.upgrades.science.resistance.level, "science", 101, "precise2", nil, "%", ["precedingUpgrade"] = player.upgrades.unlocks.resistance, "resistance"}, --Resistance Science Upgrade
                {"Shield Cooldown", 1325, 540, 350, 60, player.tower.shieldCooldown, player.upgrades.science.shieldCooldown.cost, player.upgrades.science.shieldCooldown.level, "science", 126, "precise", nil, "s", ["precedingUpgrade"] = player.upgrades.unlocks.shield, "shield"}, --Shield Cooldown Science Upgrade
                {"Shield Duration", 245, 610, 350, 60, player.tower.shieldDuration, player.upgrades.science.shieldDuration.cost, player.upgrades.science.shieldDuration.level, "science", 111, "precise2", nil, "s", ["precedingUpgrade"] = player.upgrades.unlocks.shield, "shield"}, --Shield Duration Science Upgrade
                {"Meteor Amount", 605, 610, 350, 60, player.tower.meteorAmount, player.upgrades.science.meteorAmount.cost, player.upgrades.science.meteorAmount.level, "science", 6, "brief", nil, nil, ["precedingUpgrade"] = player.upgrades.unlocks.meteor, "meteor"}, --Meteor Amount Science Upgrade
                {"Meteor RPM", 965, 610, 350, 60, player.tower.meteorRPM, player.upgrades.science.meteorRPM.cost, player.upgrades.science.meteorRPM.level, "science", 40, "precise2", nil, nil, ["precedingUpgrade"] = player.upgrades.unlocks.meteor, "meteor"}, --Meteor RPM Science Upgrade
                {"Lifesteal Chance", 1325, 610, 350, 60, player.tower.lifestealChance, player.upgrades.science.lifestealChance.cost, player.upgrades.science.lifestealChance.level, "science", 41, "precise", nil, "%", ["precedingUpgrade"] = player.upgrades.unlocks.lifesteal, "lifesteal"}, --Lifesteal Chance Science upgrade
                {"Lifesteal Percent", 245, 680, 350, 60, player.tower.lifestealPercent, player.upgrades.science.lifestealPercent.cost, player.upgrades.science.lifestealPercent.level, "science", 76, "precise2", nil, "%", ["precedingUpgrade"] = player.upgrades.unlocks.lifesteal, "lifesteal"}, --Lifesteal Percent Science upgrade
            },

            ["UTL"] = {
                {"Copper/Wave", 245, 840, 350, 60, player.tower.copperPerWave, player.upgrades.science.copperPerWave.cost, player.upgrades.science.copperPerWave.level, "science", math.huge, "precise", nil, nil, ["precedingUpgrade"] = 0}, --Copper/wave Science Upgrade
                {"Silver/Wave", 605, 840, 350, 60, player.tower.silverPerWave, player.upgrades.science.silverPerWave.cost, player.upgrades.science.silverPerWave.level, "science", math.huge, "precise", nil, nil, ["precedingUpgrade"] = 0}, --Silver/wave Science Upgrade
                {"Copper Bonus", 965, 840, 350, 60, player.tower.copperBonus, player.upgrades.science.copperBonus.cost, player.upgrades.science.copperBonus.level, "science", 451, "precise2", "x", nil, ["precedingUpgrade"] = player.upgrades.unlocks.resourceBonus, "resourceBonus"}, --Copper Bonus Science Upgrade
                {"Silver Bonus", 1325, 840, 350, 60, player.tower.silverBonus, player.upgrades.science.silverBonus.cost, player.upgrades.science.silverBonus.level, "science", 301, "precise2", "x", nil, ["precedingUpgrade"] = player.upgrades.unlocks.resourceBonus, "resourceBonus"} --Silver Bonus Science Upgrade
            }
        }
    }

    unlockPanels = {
        crit = {"Crit Chance/Factor", 645, 310, 620, 60, player.upgrades.unlocks.crit, 3},
        range = {"Range", 645, 310, 620, 60, player.upgrades.unlocks.range, 4},
        clusterFire = {"Cluster Fire", 645, 310, 620, 60, player.upgrades.unlocks.clusterFire, 10},
        resistance = {"Resistance", 645, 610, 620, 60, player.upgrades.unlocks.resistance, 5},
        shield = {"Shield", 645, 610, 620, 60, player.upgrades.unlocks.shield, 8},
        meteor = {"Meteor", 645, 610, 620, 60, player.upgrades.unlocks.meteor, 12},
        lifesteal = {"Lifesteal", 645, 680, 620, 60, player.upgrades.unlocks.lifesteal, 14},
        resourceBonus = {"Resource Bonus", 645, 910, 620, 60, player.upgrades.unlocks.resourceBonus, 5}
    }
end

---Reload Battle/Science upgrade costs and values (effects) based on their level and whether you're in the Hub or in a Battle.
---@param x number Battle upgrade level.
---@param z number Science upgrade level.
function reloadFormulae(x, z)
    abilityFunctions.updateLeveling()
    
    z = z or 1
    local BKAttackDamage = (player.abilities.berserkerKit.equipped and 1 + levelingInfo[8].attackDamageIncrease[player.abilities.berserkerKit.level + 1] / 100 or 1)
    local BKAttackSpeed = (player.abilities.berserkerKit.equipped and 1 + levelingInfo[8].attackSpeedIncrease[player.abilities.berserkerKit.level + 1] / 100 or 1)
    local BKHealth = (player.abilities.berserkerKit.equipped and 1 - levelingInfo[8].healthDecrease / 100 or 1)
    local BKResistance = (player.abilities.berserkerKit.equipped and 1 - levelingInfo[8].resistanceDecrease / 100 or 1)
    local JBHealth = (player.abilities.JerelosBlessing.equipped and levelingInfo[7].healthIncrease[player.abilities.JerelosBlessing.level + 1] or 1)
    local SKAttackSpeed = (player.abilities.sniperKit.equipped and 1 - levelingInfo[9].attackSpeedDecrease / 100 or 1)
    local SKRange = (player.abilities.sniperKit.equipped and 1 + levelingInfo[9].rangeIncrease[player.abilities.sniperKit.level + 1] / 100 or 1)
    local TKAttackDamage = (player.abilities.tankKit.equipped and 1 - levelingInfo[10].attackDamageDecrease / 100 or 1)
    local TKAttackSpeed = (player.abilities.tankKit.equipped and 1 - levelingInfo[10].attackSpeedDecrease / 100 or 1)
    local TKHealth = (player.abilities.tankKit.equipped and 1 + levelingInfo[10].healthStatsIncrease[player.abilities.tankKit.level + 1] / 100 or 1)
    local TKResistance = (player.abilities.tankKit.equipped and 1 + levelingInfo[10].resistanceIncrease[player.abilities.tankKit.level + 1] / 100 or 1)
    local SCCritChance = (player.abilities.supercritical.equipped and 1 + levelingInfo[11].criticalChanceIncrease[player.abilities.supercritical.level + 1] / 100 or 1)
    local SCCritFactor = (player.abilities.supercritical.equipped and levelingInfo[11].criticalFactorIncrease[player.abilities.supercritical.level + 1] or 1)
    local upgradeModuleFormulae = {
        round = {
            ATK = {
                {(0.2 * ((z - x + 1)^2) + 0.4 * (z - x + 1) + 0.4) / ((z - x + 1)^0.2) + 1, ((0.25 * z - 0.25)^3 + 4 + z) * player.upgrades.nexus.attackDamage.value * BKAttackDamage * TKAttackDamage}, --Attack Damage Round upgrade
                {5 * ((z - x + 1)^math.log(((z - x + 1) + 10) / 10)), (math.min(0.8 + 0.04 * (z - 1), 5)) * player.upgrades.nexus.attackSpeed.value * BKAttackSpeed * SKAttackSpeed * TKAttackSpeed}, --Attack Speed Round upgrade
                {((z - x) / 2)^2 + 5.75, math.min(0.3 * (z - 1), 24) * SCCritChance}, --Critical Chance Round upgrade
                {0.1 * ((z - x)^2) + (z - x) + 0.9, math.min(1 + 0.05 * (z - 1), 10) * SCCritFactor}, --Critical Factor Round upgrade
                {((z - x)^2 + 5 * (z - x)) / 6 + 2 * (z - x) + 5/3, math.min(240 + 2 * (z - 1), 400) * SKRange}, --Range Round upgrade
                {(z - x)^1.7 + 2 * (z - x) + 7, math.min(0.25 * (z-1), 30)}, --Cluster Fire Chance Round upgrade
                {(3.6 * (z - x + 1))^3 + 354, math.min(z + 1, 6)}, --Cluster Fire Targets Round upgrade
                {0.35 * (z - x + 3)^2 + 5.65 - 2 * (z-x + 3), math.min(25 + math.sqrt(25 * z), 85)}, --Cluster Fire Efficiency Science upgrade
            },

            VIT = {
                {(0.2 * ((z - x + 1)^2) + 0.4 * (z - x + 1) + 0.4) / ((z - x + 1)^(1/6)) + 1.95, ((0.3 * z - 0.3)^3.75 + 14.6 + 0.4 * z) * player.upgrades.nexus.health.value * BKHealth * JBHealth * TKHealth}, --Health Round upgrade
                {(z - x + 1)^1.5 + 3, (((0.8 * z - 0.8)^2.5) / 50) * player.upgrades.nexus.regeneration.value * TKHealth}, --Regeneration Round upgrade
                {(z - x) * math.sqrt(z - x) + 4, math.min(0.75 * (z - 1), 75) * BKResistance * TKResistance}, --Resistance Round upgrade
                {(z - x)^(math.log(z - x, 10) / 1.2) + 3, math.max(120 - 0.6 * (z - 1), 45)}, --Shield Cooldown Round upgrade
                {(z - x)^(math.log(z - x) / 2.5) + 2, math.min(0.05 * (z - 1) + 0.5, 6)}, --Shield Duration upgrade
                {(12 * (z - x + 1))^2 + 56, math.min(z - 1, 5)}, --Meteor Amount Round upgrade
                {4 * ((z - x + 1)^2) + 16, math.min(0.15 * z + 0.25, 6.25)}, --Meteor RPM Round upgrade
                {10 + 10 * (z-x + 1), math.min(0.5 * (z-1), 30)}, --Lifesteal Chance Round upgrade
                {10 + 8 * (z-x+1) * (math.log(z-x + 1, 10)), math.min(0.11 * (z-1), 8.25)}, --Lifesteal Percentage Round upgrade
            },

            UTL = {
                {(z - x + 1) * ((z - x + 1) + 1) / 2 + 9, 6 * (z-1)^0.75}, --Copper/wave Round upgrade
                {((z - x + 1) + 2)^2 + 1, 3 * (z-1)^0.6}, --Silver/wave Round upgrade
                {(0.2 * (z - x))^2 + 2 * (z - x) + 3.96, math.min(1 + 0.02 * (z - 1), 10)}, --Copper Bonus Round upgrade
                {0.4 * (z - x)^1.6 + 6.6, math.min(1 + 0.01 * (z - 1), 4)} --Silver Bonus Round upgrade
            }
        },
        science = {
            ATK = {
                {0.4 * x^2 + 2.6, ((0.25 * x - 0.25)^3 + 4 + x) * player.upgrades.nexus.attackDamage.value * BKAttackDamage * TKAttackDamage}, --Attack Damage Science upgrade
                {8^((x - 1) / 20) + 3 * x + 4, (math.min(0.8 + 0.04 * (x - 1), 5)) * player.upgrades.nexus.attackSpeed.value * BKAttackSpeed * SKAttackSpeed * TKAttackSpeed}, --Attack Speed Science upgrade
                {(x / 2)^2 + 4 * x + 1.75, math.min(0.3 * (x - 1), 24) * SCCritChance}, --Critical Chance Science Upgrade
                {0.2 * (x^2) + 1.8, math.min(1 + 0.05 * (x - 1), 10) * SCCritFactor}, --Critical Factor Science upgrade
                {(x^2 + 5 * x) / 3 + 2 * x + 4, math.min(240 + 2 * (x - 1), 400) * SKRange}, --Range Science upgrade
                {x^2.1 + 29 * x, math.min(0.25 * (x-1), 30)}, --Cluster Fire Chance Science upgrade
                {(5 * x)^3.2 + 728, math.min(x + 1, 6)}, --Cluster Fire Targets Science upgrade
                {0.35 * (x + 4)^2.3 + 0.85 + 2 * (x + 4), math.min(25 + math.sqrt(25 * x), 85)}, --Cluster Fire Efficiency Science upgrade
            },

            VIT = {
                {0.6 * x^2 + 3.4, ((0.3 * x - 0.3)^3.75 + 14.6 + 0.4 * x) * player.upgrades.nexus.health.value * BKHealth * JBHealth * TKHealth}, --Health Science upgrade
                {x^1.75 + 2 * x + 3, (((0.8 * x - 0.8)^2.5) / 50) * player.upgrades.nexus.regeneration.value * TKHealth}, --Regeneration Science upgrade
                {x * math.sqrt(2 * x) + 3 - math.sqrt(2), math.min(0.75 * (x - 1), 75) * BKResistance * TKResistance}, --Resistance Science Upgrade
                {x^(math.log(x, 10)) + 3, math.max(120 - 0.6 * (x - 1), 42)}, --Shield Cooldown Science upgrade
                {(x)^(math.log(x) / 2) + 3, math.min(0.05 * (x - 1) + 0.5, 6)}, --Shield Duration upgrade
                {(16 * x)^2 + 144, math.min(x - 1, 5)}, --Meteor Amount Science upgrade
                {(3 * x)^2 + 41, math.min(0.15 * x + 0.25, 6.25)}, --Meteor RPM Science upgrade
                {150 + 50 * (x + 1), math.min(0.5 * (x-1), 30)}, --Lifesteal Chance Round upgrade
                {10 + 10 * (x+1) * (math.log((x+1)^2, 10)), math.min(0.11 * (x-1), 8.25)}, --Lifesteal Percentage Round upgrade
            },

            UTL = {
                {(x^2 + x + 1) * 3 + 11, 6 * (x-1)^0.75}, --Copper/wave Science Upgrade
                {((8 * x) / 5)^2 + 27.44, 3 * (x-1)^0.6}, --Silver/wave Science Upgrade
                {(0.4 * (x - 1))^1.9 + 8, math.min(1 + 0.02 * (x - 1), 10)}, --Copper Bonus Science Upgrade
                {0.4 * x^2 + x + 8.6, math.min(1 + 0.01 * (x - 1), 4)} --Silver Bonus Science Upgrade
            }
        }
    }
    return upgradeModuleFormulae
end

--- Draw an upgrade module, work for both Battle and Science upgrades.
---@param module table Upgrade module to draw.
function processUpgradeModule.draw(module)
    local attributes = {
        name = module[1],
        ux = module[2],
        uy = module[3],
        width = module[4],
        height = module[5],
        value = module[6],
        cost = module[7],
        level = module[8],
        type = module[9],
        maxLevel = module[10],
        precision = module[11],
        prefix = module[12],
        suffix = module[13],
        precedingUpgrade = module.precedingUpgrade
    }
    if attributes.precedingUpgrade ~= false then
        love.graphics.setColor(accentColors[player.misc.theme].upgradeModule)
        love.graphics.rectangle("fill", attributes.ux, attributes.uy, attributes.width, attributes.height)
        love.graphics.setColor(0.1, 0.55, 0.98, 1)
        love.graphics.rectangle("line", attributes.ux, attributes.uy, attributes.width, attributes.height)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setFont(font_Afacad20)
        local buttonXY = {attributes.width - 90 - 3, 3}
        if module == upgradeModules["round"]["ATK"][5] or module == upgradeModules["science"]["ATK"][5] then
            love.graphics.print(string.format("%s: %s%s%s", attributes.name or "Upgrade Name", attributes.prefix or "", notations.convertToLetterNotation(attributes.value / 20, attributes.precision), "u", attributes.suffix or ""), attributes.ux + 5, attributes.uy + ((attributes.height - buttonXY[2] * 2) / 2) - 11)
        else
            love.graphics.print(string.format("%s: %s%s%s", attributes.name or "Upgrade Name", attributes.prefix or "", notations.convertToLetterNotation(attributes.value, attributes.precision), attributes.suffix or ""), attributes.ux + 5, attributes.uy + ((attributes.height - buttonXY[2] * 2) / 2) - 11)
        end
        love.graphics.setColor(0.05, 0.35, 0.45, 1)
        if attributes.type == "round" and player.currencies.currentCopper >= attributes.cost and attributes.level < attributes.maxLevel then
            love.graphics.setColor(0.05, 0.35, 0.45, 1)
        elseif attributes.type == "science" and player.currencies.currentSilver >= attributes.cost and attributes.level < attributes.maxLevel then
            love.graphics.setColor(0.05, 0.35, 0.45, 1)
        else
            love.graphics.setColor(0.03, 0.2, 0.25)
        end
        love.graphics.rectangle("fill", attributes.ux + buttonXY[1], attributes.uy + buttonXY[2], attributes.width - buttonXY[1] - 3, attributes.height - buttonXY[2] * 2)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.rectangle("line", attributes.ux + buttonXY[1], attributes.uy + buttonXY[2], attributes.width - buttonXY[1] - 3, attributes.height - buttonXY[2] * 2)
        if attributes.level < attributes.maxLevel then
            if attributes.type == "round" then
                love.graphics.draw(img_currency_copper, attributes.ux + buttonXY[1] + 2, attributes.uy + (attributes.height - buttonXY[2] * 2 - 15) / 2, 0, 20/32)
                if player.currencies.currentCopper >= attributes.cost then
                    love.graphics.setColor(1, 1, 1, 1)
                else
                    love.graphics.setColor(1, 0.5, 0.5, 1)
                end
            else
                love.graphics.draw(img_currency_silver, attributes.ux + buttonXY[1] + 2, attributes.uy + (attributes.height - buttonXY[2] * 2 - 15) / 2, 0, 20/32)
                if player.currencies.currentSilver >= attributes.cost then
                    love.graphics.setColor(1, 1, 1, 1)
                else
                    love.graphics.setColor(1, 0.5, 0.5, 1)
                end
            end
            love.graphics.print(string.format("%s", notations.convertToLetterNotation(attributes.cost, "brief")), attributes.ux + buttonXY[1] + 21, attributes.uy + ((attributes.height - buttonXY[2] * 2) / 2) - 11)
        else
            love.graphics.printf("Max", attributes.ux + buttonXY[1], attributes.uy + ((attributes.height - buttonXY[2] * 2) / 2) - 12, attributes.width - buttonXY[1] - 3, "center")
        end
    end
end

--- Levels up an upgrade if the player has enough currency.
---@param x number Mouse cursor position (horizontal).
---@param y number Mouse cursor position (vertical).
---@param module table Upgrade module to upgrade.
---@param costFormula number Cost formula for the upgrade to follow.
---@param valueFormula number Value formula for the upgrade to follow.
function processUpgradeModule.upgrade(x, y, module, costFormula, valueFormula)
    local attributes = {
        ux = module[2],
        uy = module[3],
        width = module[4],
        height = module[5],
        value = module[6],
        cost = module[7],
        level = module[8],
        type = module[9],
        maxLevel = module[10],
        precedingUpgrade = module.precedingUpgrade
    }
    local buttonXY = {257, 3}
    if x >= attributes.ux + buttonXY[1] and x <= attributes.ux + attributes.width - 3 and y >= attributes.uy + buttonXY[2] and y <= attributes.uy + attributes.height - 3 and attributes.level < attributes.maxLevel and attributes.precedingUpgrade ~= false then
        if attributes.type == "round" then
            if player.currencies.currentCopper >= math.floor(attributes.cost) then
                local ub = audio_upgrade_bought:clone()
                ub:setVolume(1 * player.settings.volume^2)
                ub:play()
                player.currencies.currentCopper = player.currencies.currentCopper - math.floor(attributes.cost)
                attributes.level = attributes.level + 1
                attributes.cost = math.floor(costFormula)
                attributes.value = valueFormula
                player.stats.battle.upgradesAcquired = player.stats.battle.upgradesAcquired + 1
                if module == upgradeModules["round"]["VIT"][1] then
                    local hpPercentage = player.tower.currentHealth / player.tower.health
                    player.tower.currentHealth = attributes.value * math.min(hpPercentage, 1)
                elseif module == upgradeModules["round"]["VIT"][6] then
                    local offset = 0
                    if player.tower.meteorAmount > 0 then
                        offset = -1/2 * math.pi + meteors[1].angle
                    end
                    meteors = {}
                    for i=1,attributes.value do
                        createMeteor(((i-1) * (2 * math.pi) / attributes.value) - 0.5 * math.pi + offset)
                    end
                end
            end

        elseif attributes.type == "science" then
            if player.currencies.currentSilver >= math.floor(attributes.cost) then
                local ub = audio_upgrade_bought:clone()
                ub:setVolume(1 * player.settings.volume^2)
                ub:play()
                player.currencies.currentSilver = player.currencies.currentSilver - math.floor(attributes.cost)
                attributes.level = attributes.level + 1
                attributes.cost = math.floor(costFormula)
                attributes.value = valueFormula
                player.stats.save.upgradesAcquired.science = player.stats.save.upgradesAcquired.science + 1
            end
        end
    end
    return attributes.level, attributes.cost, attributes.value
end

processUnlockPanel = {}

--- Draw an unlock panel if the succeeding upgrades are not unlocked.
---@param unlockPanel table The unlock panel to draw.
function processUnlockPanel.draw(unlockPanel)
    local attributes = {
        name = unlockPanel[1],
        ux = unlockPanel[2],
        uy = unlockPanel[3],
        width = unlockPanel[4],
        height = unlockPanel[5],
        upgrade = unlockPanel[6],
        cost = unlockPanel[7]
    }
    love.graphics.setColor(accentColors[player.misc.theme].upgradeModule)
    love.graphics.rectangle("fill", attributes.ux, attributes.uy, attributes.width, attributes.height)
    love.graphics.setColor(0.1, 0.55, 0.98, 1)
    love.graphics.rectangle("line", attributes.ux, attributes.uy, attributes.width, attributes.height)
    love.graphics.setFont(font_Afacad20)
    love.graphics.setColor(1, 1, 1, 1)
    local buttonXY = {attributes.width - 90 - 3, 3}
    love.graphics.printf("Unlock " .. attributes.name .. " upgrades", attributes.ux, attributes.uy + ((attributes.height - buttonXY[2] * 2) / 2) - 11, attributes.width - buttonXY[2], "center")
    if player.currencies.currentElectrum >= attributes.cost then
        love.graphics.setColor(0.05, 0.35, 0.45, 1)
    else
        love.graphics.setColor(0.03, 0.2, 0.25, 1)
    end
    love.graphics.rectangle("fill", attributes.ux + buttonXY[1], attributes.uy + buttonXY[2], attributes.width - buttonXY[1] - 3, attributes.height - buttonXY[2] * 2)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle("line", attributes.ux + buttonXY[1], attributes.uy + buttonXY[2], attributes.width - buttonXY[1] - 3, attributes.height - buttonXY[2] * 2)
    love.graphics.draw(img_currency_electrum, attributes.ux + buttonXY[1] + 4, attributes.uy + (attributes.height - buttonXY[2] * 2 - 15) / 2, 0, 20/32)
    if player.currencies.currentElectrum >= attributes.cost then
        love.graphics.setColor(1, 1, 1, 1)
    else
        love.graphics.setColor(1, 0.5, 0.5, 1)
    end
    love.graphics.print(attributes.cost, attributes.ux + buttonXY[1] + 24, attributes.uy + ((attributes.height - buttonXY[2] * 2) / 2) - 11)
end

--- Check if any unlock panel is clicked. and unlock the corresponding upgrade(s) if the player has enough currency.
---@param x number Mouse cursor position (horizontal).
---@param y number Mouse cursor position (vertical).
---@param unlockPanel table The unlock panel to check for clicks.
function processUnlockPanel.clickCheck(x, y, unlockPanel)
    local attributes = {
        ux = unlockPanel[2],
        uy = unlockPanel[3],
        width = unlockPanel[4],
        height = unlockPanel[5],
        upgrade = unlockPanel[6],
        cost = unlockPanel[7]
    }
    --[[ Upgrade unlock ]]--
    local buttonXY = {attributes.width - 90 - 3, 3}
    if x >= attributes.ux + buttonXY[1] and x <= attributes.ux + attributes.width - 3 and y >= attributes.uy + buttonXY[2] and y <= attributes.uy + attributes.height - 3 and player.currencies.currentElectrum >= attributes.cost and not attributes.upgrade and unlockPanelsPressed == 0 then
        player.currencies.currentElectrum = player.currencies.currentElectrum - attributes.cost
        unlockPanelsPressed = unlockPanelsPressed + 1
        attributes.upgrade = true
    end
    return attributes.upgrade
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
        findClosestEnemyInRange(960, 540, player.tower.range)
        projectile.angle = math.atan2(findClosestEnemyInRange(960, 540, player.tower.range)[enemyIndex].y - 540 + enemyOffsets[findClosestEnemyInRange(960, 540, player.tower.range)[enemyIndex].type], findClosestEnemyInRange(960, 540, player.tower.range)[enemyIndex].x - 960 + enemyOffsets[findClosestEnemyInRange(960, 540, player.tower.range)[enemyIndex].type])
        projectilesCreated = projectilesCreated + 1
    end
    table.insert(projectilesOnField, projectile)
    player.stats.battle.projectilesFired = player.stats.battle.projectilesFired + projectilesCreated
    player.stats.save.projectilesFired = player.stats.save.projectilesFired + projectilesCreated
end

--- Create an enemy and place it on the game field.
---@param hp number The amount of health points the enemy has.
---@param speed number The speed at which the enemy moves on the game field.
---@param attackSpeed number How fast the enemy attacks (times per second).
---@param attackDamage number The damage the enemy deals when attacking.
function createEnemy(hp, speed, attackSpeed, attackDamage)
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
function findClosestEnemyInRange(x, y, range)

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
function drawSentryBossbar()
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
function drawCenturionBossbar()
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

--- Kill the specified enemy by adding its drops to the player's resources, removing the enemy from the game field and creating some kill particles.
---@param s number The enemy to be killed.
function killEnemy(s, damageSource)
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
    for i=1,particleAmount[ke.type] * settings_particleMultipliers[player.settings.particleMultiplier] or 0 do
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
function damageEnemy(s, damage, crit, superCrit, damageSource)
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
        killEnemy(s, damageSource)
    end
end

--- Update enemy spawn rate, spawn cap, attack damage, spawn chances, health and speed, together with the wave cooldown.
---@param difficulty number The difficulty which the enemy stats update to.
---@param wave number The wave which the enemy stats update to.
function updateEnemyStats(difficulty, wave)
    local waveCooldowns = {6, 5, 4, 3.5, 3}
    enemyAttributes = {}
    enemyAttributes.spawn = {}
    local pendingEnemies = 0
    local tankSpawnChance = 0
    local swiftSpawnChance = 0
    local exploderSpawnChance = 0
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
            drawSentryBossbar()
        elseif centurionAlive then
            drawCenturionBossbar()
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
        love.graphics.printf(string.format("%s (x%.2f)", settings_particleMultiplierNames[player.settings.particleMultiplier], settings_particleMultipliers[player.settings.particleMultiplier]), 710, 330, 500, "center")
        if player.settings.particleMultiplier > 1 then
            love.graphics.draw(img_button_arrowLeft, 820, 332)
        end
        if player.settings.particleMultiplier < 8 then
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
                    if findClosestEnemyInRange(960, 540, player.tower.range)[2] ~= nil then
                        player.stats.battle.clusterFire.triggered = player.stats.battle.clusterFire.triggered + 1
                        player.stats.save.clusterFire.triggered = player.stats.save.clusterFire.triggered + 1
                    end
                end
                if findClosestEnemyInRange(960, 540, player.tower.range)[1] then
                    timers.projectile = 0
                    if targetAmount == 1 then
                        local f = audio_tower_fire:clone()
                        f:setVolume(1 * player.settings.volume^2)
                        f:play()
                    end
                end
                for i=1,targetAmount do
                    if findClosestEnemyInRange(960, 540, player.tower.range)[i] then
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
                    createEnemy(enemyAttributes.health, enemyAttributes.speed, 1, enemyAttributes.attackDamage)
                    enemyAttributes.pendingEnemies = enemyAttributes.pendingEnemies - 1
                end
            end
            findClosestEnemyInRange(960, 540, player.tower.range)
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
                    damageEnemy(j, damage, v.isCrit, v.isSupercrit, "projectile")
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
                for i=1,love.math.random(-4, 1) * settings_particleMultipliers[player.settings.particleMultiplier] do
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
                    damageEnemy(i, player.tower.attackDamage * (levelingInfo[5].damage[player.abilities.magmaTouch.level + 1] / 100), false, false, "magmaPool")
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
                    damageEnemy(i, enemyAttributes.attackDamage * 2.5, false, false, "exploder")
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
                for i=1,love.math.random(1, 2) * settings_particleMultipliers[player.settings.particleMultiplier] do
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
                        killEnemy(j, "meteor")
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
                    updateEnemyStats(gameplay.difficulty, gameplay.wave)
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
                for i=#findClosestEnemyInRange(960, 540, player.tower.range),1,-1 do
                    damageEnemy(i, damage, false, false, "disruptWave")
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
        if x >= 820 and x <= 844 and y >= 332 and y <= 356 and player.settings.particleMultiplier > 1 then
            player.settings.particleMultiplier = player.settings.particleMultiplier - 1
        elseif x >= 1076 and x <= 1100 and y >= 332 and y <= 356 and player.settings.particleMultiplier < 8 then
            player.settings.particleMultiplier = player.settings.particleMultiplier + 1
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
            processUpgradeModule.reload()
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