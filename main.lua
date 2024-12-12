function love.load()
    lume = require "lume"
    require "loadGame"
    require "saveGame"
    require "towers"
    require "towerInfo"
    require "upgradeMenu"
    require "particles"
    require "tooltips"
    require "gameOver"
    require "hub"
    require "notations"
    require "abilityObjects"
    hubSection = "Main"
    roundUpgradeSection = "ATK"
    background = "nova"
    --- Reloads all images.
    function assetReload()
        img_background = love.graphics.newImage("assets/background.png")
        img_background_stellar = love.graphics.newImage("assets/background_stellar.png")
        img_background_eclipse = love.graphics.newImage("assets/background_eclipse.png")
        img_background_nova = love.graphics.newImage("assets/background_nova.png")
        img_currency_copper = love.graphics.newImage("assets/currency_copper.png")
        img_currency_silver = love.graphics.newImage("assets/currency_silver.png")
        img_currency_gold = love.graphics.newImage("assets/currency_gold.png")
        img_currency_electrum = love.graphics.newImage("assets/currency_electrum.png")
        img_currency_token = love.graphics.newImage("assets/currency_token.png")
        img_currency_token_big = love.graphics.newImage("assets/currency_token_big.png")
        img_tower_main = love.graphics.newImage("assets/tower_main.png")
        img_tower_main_shielded = love.graphics.newImage("assets/tower_main_shielded.png")
        img_tower_eclipse_sun = love.graphics.newImage("assets/tower_eclipse_sun.png")
        img_tower_eclipse_sun2 = love.graphics.newImage("assets/tower_eclipse_sun2.png")
        img_tower_eclipse_sun2_shielded = love.graphics.newImage("assets/tower_eclipse_sun2_shielded.png")
        img_tower_eclipse_moon = love.graphics.newImage("assets/tower_eclipse_moon.png")
        img_tower_eclipse_moon2 = love.graphics.newImage("assets/tower_eclipse_moon2.png")
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
        img_particle_crystalExplosion = love.graphics.newImage("assets/particle_crystalExplosion.png")
        img_particle_burn = love.graphics.newImage("assets/particle_burn.png")
        img_button_pause = love.graphics.newImage("assets/button_pause.png")
        img_button_arrowLeft = love.graphics.newImage("assets/button_arrowLeft.png")
        img_button_arrowRight = love.graphics.newImage("assets/button_arrowRight.png")
        img_button_arrowLeft_big = love.graphics.newImage("assets/button_arrowLeft_big.png")
        img_button_arrowRight_big = love.graphics.newImage("assets/button_arrowRight_big.png")
        img_button_questionMark = love.graphics.newImage("assets/button_questionMark.png")
        img_meteor = love.graphics.newImage("assets/meteor.png")
        img_particle_meteor = love.graphics.newImage("assets/particle_meteor.png")
        img_crystal = love.graphics.newImage("assets/crystal.png")
        img_crystal_multilayered_l1 = love.graphics.newImage("assets/crystal_multilayered_l1.png")
        img_crystal_multilayered_l2 = love.graphics.newImage("assets/crystal_multilayered_l2.png")
        img_crystal_multilayered_l3 = love.graphics.newImage("assets/crystal_multilayered_l3.png")
        img_crystal_aoe = love.graphics.newImage("assets/crystal_aoe.png")
        img_rainforest = love.graphics.newImage("assets/rainforest.png")
        img_magmaTouch_pool = love.graphics.newImage("assets/magmaTouch_pool.png")
        img_ability_preview_spikedCrystals = love.graphics.newImage("assets/ability_preview_spikedCrystals.png")
        img_ability_preview_scatterFire = love.graphics.newImage("assets/ability_preview_scatterFire.png")
        img_ability_preview_burstFire = love.graphics.newImage("assets/ability_preview_burstFire.png")
        img_ability_preview_rainforest = love.graphics.newImage("assets/ability_preview_rainforest.png")
        img_ability_preview_magmaTouch = love.graphics.newImage("assets/ability_preview_magmaTouch.png")

        audio_enemy_kill = love.audio.newSource("assets/audio/enemy_kill.wav", "static")
        audio_enemy_kill_centurion = love.audio.newSource("assets/audio/enemy_kill_centurion.wav", "static")
        audio_enemy_kill_sentry = love.audio.newSource("assets/audio/enemy_kill_sentry.wav", "static")
        audio_crystal_explosion = love.audio.newSource("assets/audio/crystal_explode.wav", "static")
        audio_tower_scatterFire__burstFire = love.audio.newSource("assets/audio/tower_scatterFire-burstFire.wav", "static")
        audio_tower_damageTaken = love.audio.newSource("assets/audio/tower_damageTaken.wav", "static")
        audio_tower_damageAbsorbed = love.audio.newSource("assets/audio/tower_damageAbsorbed.wav", "static")
        audio_tower_collapse = love.audio.newSource("assets/audio/tower_collapse.wav", "static")
        audio_tower_fire = love.audio.newSource("assets/audio/tower_fire.wav", "static")
        audio_rainforest_activation = love.audio.newSource("assets/audio/rainforest_activation.wav", "static")
    end
    --- Reloads all fonts.
    function fontReload()
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
        font_AfacadSemiBold24 = love.graphics.newFont("assets/fonts/Afacad Flux/AfacadFlux-SemiBold.ttf", 24)
        font_AfacadSemiBold28 = love.graphics.newFont("assets/fonts/Afacad Flux/AfacadFlux-SemiBold.ttf", 28)
    end
    TOWER_SIZE = 56
    love.graphics.setLineStyle("rough")
    settings_particleMultiplierNames = {"None", "Minimal", "Reduced", "Normal", "Rich", "Fancy", "Fabulous", "Stormful"}
    settings_notationNames = {"kmbt", "e", "alphabet"}
    settings_particleMultipliers = {0, 0.25, 0.75, 1, 1.5, 2, 3, 5}
    difficultyMultipliers = {1, 1.75, 2.5, 3.75}
    assetReload()
    fontReload()
    loadGame()
    resetRoundValues()
    towers.reload()
    processUpgradeModule.reload()
end

function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end

processUpgradeModule = {}

---Simply reloads all Battle/Science upgrade modules and upgrade unlock panels with their respective effects and costs.
function processUpgradeModule.reload()
    upgradeModules = {
        round = {
            ["ATK"] = {
                {"Damage", 10, 850, 350, 60, player.tower.attackDamage, player.upgrades.round.attackDamage.cost, player.upgrades.round.attackDamage.level, "round", math.huge, "precise", nil, nil, ["precedingUpgrade"] = 0}, --Attack Damage Science upgrade
                {"Attack Speed", 10, 920, 350, 60, player.tower.attackSpeed, player.upgrades.round.attackSpeed.cost, player.upgrades.round.attackSpeed.level, "round", 106, "precise2", nil, nil, ["precedingUpgrade"] = 0}, --Attack Speed Science upgrade
                {"Critical Chance", 10, 990, 350, 60, player.tower.critChance, player.upgrades.round.critChance.cost, player.upgrades.round.critChance.level, "round", 101, "precise", nil, "%", ["precedingUpgrade"] = player.upgrades.unlocks.crit}, --Critical Chance Science upgrade
                {"Critical Factor", 370, 850, 350, 60, player.tower.critFactor, player.upgrades.round.critFactor.cost, player.upgrades.round.critFactor.level, "round", math.huge, "precise2", "x", nil, ["precedingUpgrade"] = player.upgrades.unlocks.crit}, --Critical Factor Science upgrade
                {"Range", 370, 920, 350, 60, player.tower.range, player.upgrades.round.range.cost, player.upgrades.round.range.level, "round", 81, "precise", nil, nil, ["precedingUpgrade"] = player.upgrades.unlocks.range}, --Attack Damage Science upgrade
            },

            ["VIT"] = {
                {"Health", 10, 850, 350, 60, player.tower.maxHealth, player.upgrades.round.health.cost, player.upgrades.round.health.level, "round", math.huge, "precise", nil, nil, ["precedingUpgrade"] = 0}, --Health Science Upgrade
                {"Regeneration", 10, 920, 350, 60, player.tower.regeneration, player.upgrades.round.regeneration.cost, player.upgrades.round.regeneration.level, "round", math.huge, "precise2", nil, "/s", ["precedingUpgrade"] = 0}, --Regeneration Science Upgrade
                {"Resistance", 10, 990, 350, 60, player.tower.resistance, player.upgrades.round.resistance.cost, player.upgrades.round.resistance.level, "round", 101, "precise2", nil, "%", ["precedingUpgrade"] = player.upgrades.unlocks.resistance}, --Resistance Science Upgrade
                {"Shield Cooldown", 370, 850, 350, 60, player.tower.shieldCooldown, player.upgrades.round.shieldCooldown.cost, player.upgrades.round.shieldCooldown.level, "round", 126, "precise", nil, "s", ["precedingUpgrade"] = player.upgrades.unlocks.shield}, --Shield Cooldown Science Upgrade
                {"Shield Duration", 370, 920, 350, 60, player.tower.shieldDuration, player.upgrades.round.shieldDuration.cost, player.upgrades.round.shieldDuration.level, "round", 111, "precise2", nil, "s", ["precedingUpgrade"] = player.upgrades.unlocks.shield}, --Shield Duration Science Upgrade
                {"Meteor Amount", 370, 990, 350, 60, player.tower.meteorAmount, player.upgrades.round.meteorAmount.cost, player.upgrades.round.meteorAmount.level, "round", 6, "brief", nil, nil, ["precedingUpgrade"] = player.upgrades.unlocks.meteor}, --Meteor Amount Science Upgrade
                {"Meteor RPM", 730, 850, 350, 60, player.tower.meteorRPM, player.upgrades.round.meteorRPM.cost, player.upgrades.round.meteorRPM.level, "round", 40, "precise2", nil, nil, ["precedingUpgrade"] = player.upgrades.unlocks.meteor}, --Meteor RPM Science Upgrade
            },

            ["UTL"] = {
                {"Copper/wave", 10, 850, 350, 60, player.tower.copperPerWave, player.upgrades.round.copperPerWave.cost, player.upgrades.round.copperPerWave.level, "round", math.huge, "brief", nil, nil, ["precedingUpgrade"] = 0}, --Copper/wave Science Upgrade
                {"Silver/wave", 10, 920, 350, 60, player.tower.silverPerWave, player.upgrades.round.silverPerWave.cost, player.upgrades.round.silverPerWave.level, "round", math.huge, "brief", nil, nil, ["precedingUpgrade"] = 0}, --Silver/wave Science Upgrade
                {"Copper Bonus", 10, 990, 350, 60, player.tower.copperBonus, player.upgrades.round.copperBonus.cost, player.upgrades.round.copperBonus.level, "round", 451, "precise2", "x", nil, ["precedingUpgrade"] = player.upgrades.unlocks.resourceBonus}, --Copper Bonus Science Upgrade
                {"Silver Bonus", 370, 850, 350, 60, player.tower.silverBonus, player.upgrades.round.silverBonus.cost, player.upgrades.round.silverBonus.level, "round", 301, "precise2", "x", nil, ["precedingUpgrade"] = player.upgrades.unlocks.resourceBonus} --Silver Bonus Science Upgrade
            }
        },
        science = {
            ["ATK"] = {
                {"Damage", 245, 240, 350, 60, player.tower.attackDamage, player.upgrades.science.attackDamage.cost, player.upgrades.science.attackDamage.level, "science", math.huge, "precise", nil, nil, ["precedingUpgrade"] = 0}, --Attack Damage Science upgrade
                {"Attack Speed", 605, 240, 350, 60, player.tower.attackSpeed, player.upgrades.science.attackSpeed.cost, player.upgrades.science.attackSpeed.level, "science", 106, "precise2", nil, nil, ["precedingUpgrade"] = 0}, --Attack Speed Science upgrade
                {"Critical Chance", 965, 240, 350, 60, player.tower.critChance, player.upgrades.science.critChance.cost, player.upgrades.science.critChance.level, "science", 101, "precise", nil, "%", ["precedingUpgrade"] = player.upgrades.unlocks.crit, "crit"}, --Critical Chance Science upgrade
                {"Critical Factor", 1325, 240, 350, 60, player.tower.critFactor, player.upgrades.science.critFactor.cost, player.upgrades.science.critFactor.level, "science", math.huge, "precise2", "x", nil, ["precedingUpgrade"] = player.upgrades.unlocks.crit, "crit"}, --Critical Factor Science upgrade
                {"Range", 245, 310, 350, 60, player.tower.range, player.upgrades.science.range.cost, player.upgrades.science.range.level, "science", 61, "precise", nil, nil, ["precedingUpgrade"] = player.upgrades.unlocks.range, "range"}, --Attack Damage Science upgrade
            },

            ["VIT"] = {
                {"Health", 245, 540, 350, 60, player.tower.maxHealth, player.upgrades.science.health.cost, player.upgrades.science.health.level, "science", math.huge, "precise", nil, nil, ["precedingUpgrade"] = 0}, --Health Science Upgrade
                {"Regeneration", 605, 540, 350, 60, player.tower.regeneration, player.upgrades.science.regeneration.cost, player.upgrades.science.regeneration.level, "science", math.huge, "precise2", nil, "/s", ["precedingUpgrade"] = 0}, --Regeneration Science Upgrade
                {"Resistance", 965, 540, 350, 60, player.tower.resistance, player.upgrades.science.resistance.cost, player.upgrades.science.resistance.level, "science", 101, "precise2", nil, "%", ["precedingUpgrade"] = player.upgrades.unlocks.resistance, "resistance"}, --Resistance Science Upgrade
                {"Shield Cooldown", 1325, 540, 350, 60, player.tower.shieldCooldown, player.upgrades.science.shieldCooldown.cost, player.upgrades.science.shieldCooldown.level, "science", 126, "precise", nil, "s", ["precedingUpgrade"] = player.upgrades.unlocks.shield, "shield"}, --Shield Cooldown Science Upgrade
                {"Shield Duration", 245, 610, 350, 60, player.tower.shieldDuration, player.upgrades.science.shieldDuration.cost, player.upgrades.science.shieldDuration.level, "science", 111, "precise2", nil, "s", ["precedingUpgrade"] = player.upgrades.unlocks.shield, "shield"}, --Shield Duration Science Upgrade
                {"Meteor Amount", 605, 610, 350, 60, player.tower.meteorAmount, player.upgrades.science.meteorAmount.cost, player.upgrades.science.meteorAmount.level, "science", 6, "brief", nil, nil, ["precedingUpgrade"] = player.upgrades.unlocks.meteor, "meteor"}, --Meteor Amount Science Upgrade
                {"Meteor RPM", 965, 610, 350, 60, player.tower.meteorRPM, player.upgrades.science.meteorRPM.cost, player.upgrades.science.meteorRPM.level, "science", 40, "precise2", nil, nil, ["precedingUpgrade"] = player.upgrades.unlocks.meteor, "meteor"}, --Meteor RPM Science Upgrade
            },

            ["UTL"] = {
                {"Copper/wave", 245, 840, 350, 60, player.tower.copperPerWave, player.upgrades.science.copperPerWave.cost, player.upgrades.science.copperPerWave.level, "science", math.huge, "brief", nil, nil, ["precedingUpgrade"] = 0}, --Copper/wave Science Upgrade
                {"Silver/wave", 605, 840, 350, 60, player.tower.silverPerWave, player.upgrades.science.silverPerWave.cost, player.upgrades.science.silverPerWave.level, "science", math.huge, "brief", nil, nil, ["precedingUpgrade"] = 0}, --Silver/wave Science Upgrade
                {"Copper Bonus", 965, 840, 350, 60, player.tower.copperBonus, player.upgrades.science.copperBonus.cost, player.upgrades.science.copperBonus.level, "science", 451, "precise2", "x", nil, ["precedingUpgrade"] = player.upgrades.unlocks.resourceBonus, "resourceBonus"}, --Copper Bonus Science Upgrade
                {"Silver Bonus", 1325, 840, 350, 60, player.tower.silverBonus, player.upgrades.science.silverBonus.cost, player.upgrades.science.silverBonus.level, "science", 301, "precise2", "x", nil, ["precedingUpgrade"] = player.upgrades.unlocks.resourceBonus, "resourceBonus"} --Silver Bonus Science Upgrade
            }
        }
    }

    unlockPanels = {
        crit = {"Crit Chance/Factor", 645, 310, 620, 60, player.upgrades.unlocks.crit, 3},
        range = {"Range", 645, 310, 620, 60, player.upgrades.unlocks.range, 4},
        resistance = {"Resistance", 645, 610, 620, 60, player.upgrades.unlocks.resistance, 5},
        shield = {"Shield", 645, 610, 620, 60, player.upgrades.unlocks.shield, 8},
        meteor = {"Meteor", 645, 610, 620, 60, player.upgrades.unlocks.meteor, 12},
        resourceBonus = {"Resource Bonus", 645, 910, 620, 60, player.upgrades.unlocks.resourceBonus, 5}
    }
end

---Reload Battle/Science upgrade costs and values (effects) based on their level and whether you're in the Hub or in a Battle.
---@param x number Battle upgrade level.
---@param z number Science upgrade level.
function reloadFormulae(x, z)
    z = z or 1
    local upgradeModuleFormulae = {
        round = {
            ATK = {
                {(0.2 * ((z - x + 1)^2) + 0.4 * (z - x + 1) + 0.4) / ((z - x + 1)^0.2) + 1, ((0.25 * z - 0.25)^3 + 4 + z) * player.upgrades.nexus.attackDamage.value}, --Attack Damage Round upgrade
                {5 * ((z - x + 1)^math.log(((z - x + 1) + 10) / 10)), (math.min(0.8 + 0.04 * (z - 1), 5)) * player.upgrades.nexus.attackSpeed.value}, --Attack Speed Round upgrade
                {((z - x) / 2)^2 + 5.75, math.min(0.3 * (z - 1), 15)}, --Critical Chance Round upgrade
                {0.1 * ((z - x)^2) + (z - x) + 0.9, math.min(1 + 0.05 * (z - 1), 10)}, --Critical Factor Round upgrade
                {((z - x)^2 + 5 * (z - x)) / 6 + 2 * (z - x) + 5/3, math.min(240 + 2 * (z - 1), 400)}, --Range Round upgrade
            },

            VIT = {
                {(0.2 * ((z - x + 1)^2) + 0.4 * (z - x + 1) + 0.4) / ((z - x + 1)^(1/6)) + 1.95, ((0.3 * z - 0.3)^3.75 + 14.6 + 0.4 * z) * player.upgrades.nexus.health.value}, --Health Round upgrade
                {(z - x + 1)^1.5 + 3, (((0.8 * z - 0.8)^2.5) / 50) * player.upgrades.nexus.regeneration.value}, --Regeneration Round upgrade
                {(z - x) * math.sqrt(z - x) + 4, math.min(0.75 * (z - 1), 75)}, --Resistance Round upgrade
                {(z - x)^(math.log(z - x, 10) / 1.2) + 3, math.max(120 - 0.6 * (z - 1), 45)}, --Shield Cooldown Round upgrade
                {(z - x)^(math.log(z - x) / 2.5) + 2, math.min(0.05 * (z - 1) + 0.5, 6)}, --Shield Duration upgrade
                {(12 * (z - x + 1))^2 + 56, math.min(z - 1, 5)}, --Meteor Amount Round upgrade
                {4 * ((z - x + 1)^2) + 16, math.min(0.15 * z + 0.25, 6.25)}, --Meteor RPM Round upgrade

            },

            UTL = {
                {(z - x + 1) * ((z - x + 1) + 1) / 2 + 9, 6 * (z - 1)}, --Copper/wave Round upgrade
                {((z - x + 1) + 2)^2 + 1, 3 * (z - 1)}, --Silver/wave Round upgrade
                {(0.2 * (z - x))^2 + 2 * (z - x) + 3.96, math.min(1 + 0.02 * (z - 1), 10)}, --Copper Bonus Round upgrade
                {0.4 * (z - x)^1.6 + 6.6, math.min(1 + 0.01 * (z - 1), 4)} --Silver Bonus Round upgrade
            }
        },
        science = {
            ATK = {
                {0.4 * x^2 + 2.6, ((0.25 * x - 0.25)^3 + 4 + x) * player.upgrades.nexus.attackDamage.value}, --Attack Damage Science upgrade
                {8^((x - 1) / 20) + 3 * x + 4, (math.min(0.8 + 0.04 * (x - 1), 5)) * player.upgrades.nexus.attackSpeed.value}, --Attack Speed Science upgrade
                {(x / 2)^2 + 4 * x + 1.75, math.min(0.3 * (x - 1), 15)}, --Critical Chance Science Upgrade
                {0.2 * (x^2) + 1.8, math.min(1 + 0.05 * (x - 1), 10)}, --Critical Factor Science upgrade
                {(x^2 + 5 * x) / 3 + 2 * x + 4, math.min(240 + 2 * (x - 1), 400)}, --Range Science upgrade
            },

            VIT = {
                {0.6 * x^2 + 3.4, ((0.3 * x - 0.3)^3.75 + 14.6 + 0.4 * x) * player.upgrades.nexus.health.value}, --Health Science upgrade
                {x^1.75 + 2 * x + 3, (((0.8 * x - 0.8)^2.5) / 50) * player.upgrades.nexus.regeneration.value}, --Regeneration Science upgrade
                {x * math.sqrt(2 * x) + 3 - math.sqrt(2), math.min(0.75 * (x - 1), 75)}, --Resistance Science Upgrade
                {x^(math.log(x, 10)) + 3, math.max(120 - 0.6 * (x - 1), 42)}, --Shield Cooldown Science upgrade
                {(x)^(math.log(x) / 2) + 3, math.min(0.05 * (x - 1) + 0.5, 6)}, --Shield Duration upgrade
                {(16 * x)^2 + 144, math.min(x - 1, 5)}, --Meteor Amount Science upgrade
                {(3 * x)^2 + 41, math.min(0.15 * x + 0.25, 6.25)}, --Meteor RPM Science upgrade

            },

            UTL = {
                {(x^2 + x + 1) * 3 + 11, 6 * (x - 1)}, --Copper/wave Science Upgrade
                {((8 * x) / 5)^2 + 27.44, 3 * (x - 1)}, --Silver/wave Science Upgrade
                {(0.4 * (x - 1))^1.9 + 8, math.min(1 + 0.02 * (x - 1), 10)}, --Copper Bonus Science Upgrade
                {0.4 * x^2 + x + 8.6, math.min(1 + 0.01 * (x - 1), 4)} --Silver Bonus Science Upgrade
            }
        }
    }
    return upgradeModuleFormulae
end

---Draw an upgrade module, work for both Battle and Science upgrades.
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
        love.graphics.setColor(0, 0.1, 0.2, 1)
        love.graphics.rectangle("fill", attributes.ux, attributes.uy, attributes.width, attributes.height)
        love.graphics.setColor(0.1, 0.55, 0.98, 1)
        love.graphics.rectangle("line", attributes.ux, attributes.uy, attributes.width, attributes.height)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setFont(font_Afacad20)
        local buttonXY = {attributes.width - 90 - 3, 3}
        if module == upgradeModules["round"]["ATK"][5] or module == upgradeModules["science"]["ATK"][5] then
            love.graphics.print(string.format("%s: %s%s%s", attributes.name or "Upgrade Name", attributes.prefix or "", notations.convertToLetterNotation(attributes.value / 20, attributes.precision), attributes.suffix or ""), attributes.ux + 5, attributes.uy + ((attributes.height - buttonXY[2] * 2) / 2) - 11)
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
                love.graphics.draw(img_currency_copper, attributes.ux + buttonXY[1] + 4, attributes.uy + (attributes.height - buttonXY[2] * 2 - 15) / 2, 0, 20/32)
                if player.currencies.currentCopper >= attributes.cost then
                    love.graphics.setColor(1, 1, 1, 1)
                else
                    love.graphics.setColor(1, 0.5, 0.5, 1)
                end
            else
                love.graphics.draw(img_currency_silver, attributes.ux + buttonXY[1] + 4, attributes.uy + (attributes.height - buttonXY[2] * 2 - 15) / 2, 0, 20/32)
                if player.currencies.currentSilver >= attributes.cost then
                    love.graphics.setColor(1, 1, 1, 1)
                else
                    love.graphics.setColor(1, 0.5, 0.5, 1)
                end
            end
            love.graphics.print(string.format("%s", notations.convertToLetterNotation(attributes.cost, "brief")), attributes.ux + buttonXY[1] + 24, attributes.uy + ((attributes.height - buttonXY[2] * 2) / 2) - 11)
        else
            love.graphics.printf("Max", attributes.ux + buttonXY[1], attributes.uy + ((attributes.height - buttonXY[2] * 2) / 2) - 12, attributes.width - buttonXY[1] - 3, "center")
        end
    end
end

---Levels up an upgrade if the player has enough currency.
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
                player.currencies.currentCopper = player.currencies.currentCopper - math.floor(attributes.cost)
                attributes.level = attributes.level + 1
                attributes.cost = math.floor(costFormula)
                attributes.value = valueFormula
                player.stats.battle.upgradesAcquired = player.stats.battle.upgradesAcquired + 1
                if module == upgradeModules["round"]["VIT"][1] then
                    local hpPercentage = player.tower.currentHealth / player.tower.maxHealth
                    player.tower.currentHealth = attributes.value * hpPercentage
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
    love.graphics.setColor(0, 0.1, 0.2, 1)
    love.graphics.rectangle("fill", attributes.ux, attributes.uy, attributes.width, attributes.height)
    love.graphics.setColor(0.1, 0.55, 0.98, 1)
    love.graphics.rectangle("line", attributes.ux, attributes.uy, attributes.width, attributes.height)
    love.graphics.setFont(font_Afacad20)
    love.graphics.setColor(1, 1, 1, 1)
    local buttonXY = {attributes.width - 90 - 3, 3}
    love.graphics.printf("Unlock " .. attributes.name .. " upgrades", attributes.ux, attributes.uy + ((attributes.height - buttonXY[2] * 2) / 2) - 11, attributes.width - buttonXY[2], "center")
    love.graphics.setColor(0.05, 0.35, 0.45, 1)
    love.graphics.rectangle("fill", attributes.ux + buttonXY[1], attributes.uy + buttonXY[2], attributes.width - buttonXY[1] - 3, attributes.height - buttonXY[2] * 2)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle("line", attributes.ux + buttonXY[1], attributes.uy + buttonXY[2], attributes.width - buttonXY[1] - 3, attributes.height - buttonXY[2] * 2)
    love.graphics.draw(img_currency_electrum, attributes.ux + buttonXY[1] + 4, attributes.uy + (attributes.height - buttonXY[2] * 2 - 15) / 2, 0, 20/32)
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
function createProjectile(x, y, speed, scatterFire, burstFire)
    local projectilesCreated = 0
    projectile = {}
    projectile.x = x
    projectile.y = y
    projectile.speed = speed
    if player.upgrades.unlocks.crit then
        local isCrit = love.math.random(0, 10000) / 100
        if isCrit <= player.tower.critChance then
            projectile.isCrit = true
        else
            projectile.isCrit = false
        end
    end
    if scatterFire then
        projectile.scatterFire = true
        projectile.angle = love.math.random(0, 2 * math.pi * 10000) / 10000
        projectilesCreated = projectilesCreated + 1
    elseif burstFire then
        projectile.burstFire = true
        projectile.angle = love.math.random(0, 2 * math.pi * 10000) / 10000
        projectilesCreated = projectilesCreated + 1
    else
        findClosestEnemyInRange()
        local offsets = {
            basic = 10,
            tank = 16,
            swift = 8,
            sentry = 22,
            centurion = 30,
            }
        projectile.angle = math.atan2(closestEnemies[1].y - 540 + offsets[closestEnemies[1].type], closestEnemies[1].x - 960 + offsets[closestEnemies[1].type])
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
    local typeChoose = love.math.random(0, 10000) / 100
    if enemyAttributes.pendingEnemies ~= 0 then
        if typeChoose <= enemyAttributes.spawn.tank then
            enemy.type = "tank"
        elseif typeChoose > enemyAttributes.spawn.tank and typeChoose <= (enemyAttributes.spawn.tank + enemyAttributes.spawn.swift) then
            enemy.type = "swift"
        elseif typeChoose > (enemyAttributes.spawn.tank + enemyAttributes.spawn.swift) then
            enemy.type = "basic"
        end
    end

    enemy.burningTime = 0
    enemy.burningUntilDamage = 1

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
    end

    --[[ Set offsets to be half of the enemy's width/height ]]--
    local offsets = {
                    basic = 12,
                    tank = 16,
                    swift = 10,
                    sentry = 24,
                    centurion = 32,
            }

    local attempts = 0
    enemy.x = love.math.random(-202 - offsets[enemy.type] * 2, 2118 + offsets[enemy.type] * 2)
    enemy.y = love.math.random(-202 - offsets[enemy.type] * 2, 1278 + offsets[enemy.type] * 2)
    while enemy.x - offsets[enemy.type] * 2 > 0 or enemy.x + offsets[enemy.type] * 2 < 1920 and enemy.y - offsets[enemy.type] * 2 > 0 or enemy.y + offsets[enemy.type] * 2 < 1080 do
        attempts = attempts + 1
        enemy.x = love.math.random(-202 - offsets[enemy.type] * 2, 2118 + offsets[enemy.type] * 2)
        enemy.y = love.math.random(-202 - offsets[enemy.type] * 2, 1278 + offsets[enemy.type] * 2)
        if enemy.x + offsets[enemy.type] * 2 < 0 or enemy.x - offsets[enemy.type] * 2 > 1920 or enemy.y + offsets[enemy.type] * 2 < 0 or enemy.y - offsets[enemy.type] * 2 > 1080 then
            break
        end
    end
    enemy.timer_untilAttack = 0
    table.insert(enemiesOnField, enemy)
end

--- Find the closest enemy within the tower range, returns nil if no enemies are within the tower range.
function findClosestEnemyInRange()
    local offsets = {
        basic = 12,
        tank = 18,
        swift = 10,
        sentry = 24,
        centurion = 32,
        }

    table.sort(enemiesOnField, function(a, b)
        return math.dist(960, 540, a.x + offsets[a.type], a.y + offsets[a.type]) < math.dist(960, 540, b.x + offsets[b.type], b.y + offsets[b.type])
    end)
    local enemiesSorted = {}
    for i,v in ipairs(enemiesOnField) do
        if math.dist(960, 540, v.x + offsets[v.type], v.y + offsets[v.type]) < player.tower.range then
            table.insert(enemiesSorted, v)
        end
    end
    closestEnemies = enemiesSorted
    return closestEnemies
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
    misc.copperBuffer = misc.copperBuffer + (player.tower.copperBonus % 1) * player.tower.copperPerWave * wavesSkipped
    player.currencies.currentCopper = player.currencies.currentCopper + math.floor(player.tower.copperBonus) * player.tower.copperPerWave * wavesSkipped
    if misc.copperBuffer >= 1 then
        player.currencies.currentCopper = player.currencies.currentCopper + math.floor(misc.copperBuffer)
        misc.copperBuffer = misc.copperBuffer - math.floor(misc.copperBuffer)
    end
    local newCopperAmount = player.currencies.currentCopper
    local copperEarned = newCopperAmount - oldCopperAmount
    player.stats.battle.copperEarned = player.stats.battle.copperEarned + copperEarned

    local oldSilverAmount = player.currencies.currentSilver
    misc.silverBuffer = misc.silverBuffer + (player.tower.silverBonus % 1) * player.tower.silverPerWave * wavesSkipped
    player.currencies.currentSilver = player.currencies.currentSilver + math.floor(player.tower.silverBonus) * player.tower.silverPerWave * wavesSkipped
    if misc.silverBuffer >= 1 then
        player.currencies.currentSilver = player.currencies.currentSilver + math.floor(misc.silverBuffer)
        misc.silverBuffer = misc.silverBuffer - math.floor(misc.silverBuffer)
    end
    local newSilverAmount = player.currencies.currentSilver
    local silverEarned = newSilverAmount - oldSilverAmount
    player.stats.battle.silverEarned = player.stats.battle.silverEarned + silverEarned

    if wavesSkipped > 0 then
        waveSkipMessage = true
    end
    player.stats.battle.wavesSkipped = player.stats.battle.wavesSkipped + wavesSkipped
    player.stats.save.wavesSkipped = player.stats.save.wavesSkipped + wavesSkipped
    timers.waveSkip = 0
end

--- Kill the specified enemy by adding its drops to the player's resources, removing the enemy from the game field and creating some kill particles.
---@param s table The enemy to be killed.
function killEnemy(s)
    local ke = enemiesOnField[s]
    local offsets = {
        basic = 10,
        tank = 16,
        swift = 8,
        sentry = 22,
        centurion = 30,
        }
    local copper = {
        basic = 1,
        tank = 4,
        swift = 4,
        sentry = 25,
        centurion = 80
        }

    local silver = {
        basic = 0,
        tank = 1,
        swift = 1,
        sentry = 10,
        centurion = 50
        }
        
    local gold = {
        basic = 0,
        tank = 0,
        swift = 0,
        sentry = 1,
        centurion = 15
        }

    local particleAmount = {
        basic = 8,
        tank = 12,
        swift = 12,
        sentry = 24,
        centurion = 32
        }
    for i=1,particleAmount[ke.type] * settings_particleMultipliers[player.settings.particleMultiplier] or 0 do
        createKillParticle(ke.x + offsets[ke.type], ke.y + offsets[ke.type], ke.type)
    end

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
    misc.silverBuffer = misc.silverBuffer + (player.tower.silverBonus % 1) * silver[ke.type]
    player.currencies.currentSilver = player.currencies.currentSilver + math.floor(player.tower.silverBonus) * silver[ke.type]
    if misc.silverBuffer >= 1 then
        player.currencies.currentSilver = player.currencies.currentSilver + math.floor(misc.silverBuffer)
        misc.silverBuffer = misc.silverBuffer - math.floor(misc.silverBuffer)
    end
    local newSilverAmount = player.currencies.currentSilver
    local silverEarned = newSilverAmount - oldSilverAmount
    player.stats.battle.silverEarned = player.stats.battle.silverEarned + silverEarned

    player.currencies.currentGold = player.currencies.currentGold + gold[ke.type]
    player.stats.battle.goldEarned = player.stats.battle.goldEarned + gold[ke.type]
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
    else
        local m = audio_enemy_kill:clone()
        m:setVolume(1 * player.settings.volume^2)
        m:play()
    end
    player.stats.wave.enemiesKilled = player.stats.wave.enemiesKilled + 1
    player.stats.battle.enemiesKilled = player.stats.battle.enemiesKilled + 1
    player.stats.save.enemiesKilled = player.stats.save.enemiesKilled + 1
    table.remove(enemiesOnField, s)
end

--- Damage an enemy and create a Hit text particle.
---@param s table The enemy to be damaged.
---@param damage number Amount of damage to deal to the enemy.
---@param crit boolean Whether this hit is a Critical one or not.
function damageEnemy(s, damage, crit)
    local de = enemiesOnField[s]
    createHitTextParticle(de.x, de.y, notations.convertToLetterNotation(math.min(de.currentHP, damage), "precise"), de.type, crit)
    player.stats.battle.damageDealt = player.stats.battle.damageDealt + math.min(damage, de.currentHP)
    player.stats.save.damageDealt = player.stats.save.damageDealt + math.min(damage, de.currentHP)
    de.currentHP = de.currentHP - damage
    if de.type == "sentry" then
        sentryCurrentHP = de.currentHP
    elseif type == "centurion" then
        centurionCurrentHP = de.currentHP
    end
    if de.currentHP <= 0 then
        killEnemy(s, de.x, de.y, de.type)
    end
end

--- Update enemy spawn rate, spawn cap, attack damage, spawn chances, health and speed, together with the wave cooldown.
---@param difficulty number The difficulty which the enemy stats update to.
---@param wave number The wave which the enemy stats update to.
function updateEnemyStats(difficulty, wave)
    local waveCooldowns = {6, 5, 4, 3.5}
    enemyAttributes = {}
    enemyAttributes.spawn = {}
    local pendingEnemies = 0
    local tankSpawnChance = 0
    local swiftSpawnChance = 0
    if difficulty == 1 then
        --[[ Set stats for Level 0 enemies ]]--
        enemyAttributes.spawnRate = 0.5 + (math.floor(0.3 * math.sqrt(0.1 * wave) * 10) / 10)
        pendingEnemies = 5 + math.floor(math.sqrt(6 * wave))
        enemyAttributes.health = (1.95 + ((1.25 * wave)^2.5 / 20)) * (1.2^(math.floor(wave / 100)))
        enemyAttributes.attackDamage = (0.875 + (wave^2.25 / 40) + 0.1 * wave^2) * (1.1^math.floor(wave / 100))
        enemyAttributes.speed = 60
        tankSpawnChance = math.min(math.floor(math.log(wave^2, 10) * 100) / 100, 4)
        swiftSpawnChance = math.min(math.floor(math.log(wave^3, 10) * 100) / 100, 6)
    elseif difficulty == 2 then
        --[[ Set stats for Level α enemies ]]--
        enemyAttributes.spawnRate = 0.9 + (math.floor(0.12 * math.sqrt(wave) * 10)) / 10
        pendingEnemies = 7 + math.floor(3 * math.sqrt(1.2 * wave))
        enemyAttributes.health = (245.9 + (2 * wave)^2 + (wave^3 / 10)) * (1.26^(math.floor(wave / 100)))
        enemyAttributes.attackDamage = (70.98 + 9 * wave + (wave^3 / 50)) * (1.13^math.floor(wave / 100))
        enemyAttributes.speed = 68
        tankSpawnChance = math.min(math.floor((math.log(wave^5, 10))^0.75 * 100) / 100, 6)
        swiftSpawnChance = math.min(math.floor(math.log(wave^3.75, 10) * 100) / 100, 8)
    elseif difficulty == 3 then
        --[[ Set stats for Level β enemies ]]--
        enemyAttributes.spawnRate = 1.3 + (math.floor((0.2 * wave) / (math.sqrt(1.75 * wave))) * 10) / 10
        pendingEnemies = 10 + 2 * math.floor((math.sqrt(17 * wave)) / 2)
        enemyAttributes.health = (15574.9 + (15 * wave)^2 + 200 * wave + (wave^3.15 / 10)) * (1.32^(math.floor(wave / 100)))
        enemyAttributes.attackDamage = (2063.95 + (6 * wave)^2 + 400 * wave + (wave^2.75 / 20)) * (1.16^math.floor(wave / 100))
        enemyAttributes.speed = 76
        tankSpawnChance = math.min(math.floor((math.sqrt(2.5 * wave - 2.5)^0.8) * 100) / 100, 10)
        swiftSpawnChance = math.min(math.floor((math.sqrt(2 * wave - 2) - math.log(wave^3, 10)) * 100) / 100, 12.5)
    elseif difficulty == 4 then
        --[[ Set stats for Level γ enemies ]]--
        enemyAttributes.spawnRate = 1.8 + (math.floor(math.sqrt(0.04 * wave) * 10)) / 10
        pendingEnemies = 14 + 2 * math.floor((3 * math.sqrt(2.75 * wave)) / 2)
        enemyAttributes.health = (779119.5 + (144.5 * wave)^2 + (2.5 * wave^4.2 / 10)) * (1.38^(math.floor(wave / 100)))
        enemyAttributes.attackDamage = (43499.8 + 4000 * wave + (wave^3.75 / 5)) * (1.19^math.floor(wave / 100))
        enemyAttributes.speed = 84
        tankSpawnChance = math.min(math.floor((math.sqrt(4 * wave - 4)^0.85) * 100) / 100, 14)
        swiftSpawnChance = math.min(math.floor((math.sqrt(2 * wave - 2)^1.05) * 100) / 100, 18)
    end
    player.timers.nextWave = 0
    gameplay.waveCooldown = waveCooldowns[gameplay.difficulty]
    player.stats.wave.enemiesKilled = 0
    enemyAttributes.pendingEnemies = pendingEnemies
    enemyAttributes.waveCap = pendingEnemies
    enemyAttributes.spawn.tank = tankSpawnChance
    enemyAttributes.spawn.swift = swiftSpawnChance
    enemyAttributes.spawn.basic = 100 - (tankSpawnChance + swiftSpawnChance)
end

function love.draw()
    tooltips.general()
    if player.location == "round" then
        if background == "main" then
            love.graphics.draw(img_background_main, 0, 0)
        elseif background == "stellar" then
            love.graphics.draw(img_background_stellar, 0, 0)
        elseif background == "eclipse" then
            love.graphics.draw(img_background_eclipse, 0, 0)
        elseif background == "nova" then
            love.graphics.draw(img_background_nova, 0, 0)
        end
        love.graphics.setLineWidth(2)
        love.graphics.setLineStyle("smooth")
        love.graphics.setColor(1, 1, 1, 0.5)
        love.graphics.ellipse("line", 960, 540, player.tower.range, player.tower.range)
        love.graphics.setColor(1, 1, 1, 1)
        if rainforestActive then
            love.graphics.draw(img_rainforest, 960 - player.tower.range + 1, 540 - player.tower.range + 1, 0, (player.tower.range * 2 + 36) / 1080)
        end
        love.graphics.setColor(1, 1, 0, 0.4)
        love.graphics.setLineWidth(1.5)
        love.graphics.ellipse("line", 960, 540, TOWER_SIZE, TOWER_SIZE)
        love.graphics.setLineStyle("rough")
        love.graphics.setFont(font_Vera16)
        towers.eclipse2()
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
        for i,v in ipairs(magmaPools) do
            love.graphics.draw(img_magmaTouch_pool, v.x, v.y)
        end
        particles.render.burn()
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
            }
            love.graphics.draw(enemyAssets[v.type], x, y)
            local offsets = {
                basic = 10,
                tank = 16,
                swift = 8,
                sentry = 22,
                centurion = 30,
                }
            if rainforestActive and math.dist(v.x + offsets[v.type] + 2, v.y + offsets[v.type] + 2, 960, 540) <= player.tower.range then
                love.graphics.setColor(0.4, 0.65, 0.1, 0.5)
                love.graphics.ellipse("line", x + offsets[v.type] + 2, y + offsets[v.type] + 2, 14, 14)
                love.graphics.setColor(1, 1, 1, 1)
            end
        end
        --[[ Print currency balances for Copper, Silver and Gold ]]--
        love.graphics.draw(img_currency_copper, 16, 16)
        love.graphics.printf(string.format("%s", notations.convertToLetterNotation(player.currencies.currentCopper, "brief")), 50, 23, 100, "left")
        love.graphics.draw(img_currency_silver, 16, 48)
        love.graphics.printf(string.format("%s", notations.convertToLetterNotation(player.currencies.currentSilver, "brief")), 50, 55, 100, "left")
        love.graphics.draw(img_currency_gold, 16, 80)
        love.graphics.printf(string.format("%s", notations.convertToLetterNotation(player.currencies.currentGold, "brief")), 50, 87, 100, "left")
        for i,v in ipairs(projectilesOnField) do
            love.graphics.draw(img_tower_projectile, v.x, v.y)
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
        love.graphics.setColor(1, 1, 1, 1)
        if sentryAlive then
            drawSentryBossbar()
        elseif centurionAlive then
            drawCenturionBossbar()
        end
        if waveSkipMessage and player.settings.waveSkipMessages then
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.setFont(font_Afacad20)
            if not player.menu.upgrades then
                love.graphics.printf({{1, 1, 1, 1}, "Skipped ", {0.35, 1, 0.75, 1}, string.format("%d ", wavesSkipped), {1, 1, 1, 1}, "wave", {1, 1, 1, 1}, string.format("%s!", wavesSkipped > 1 and "s" or "")}, 1690, 920, 220, "center")
            else
                love.graphics.printf({{1, 1, 1, 1}, "Skipped ", {0.35, 1, 0.75, 1}, string.format("%d ", wavesSkipped), {1, 1, 1, 1}, "wave", {1, 1, 1, 1}, string.format("%s!", wavesSkipped > 1 and "s" or "")}, 1690, 690, 220, "center")
            end
        end
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(img_button_pause, 1870, 10)
        love.graphics.setLineWidth(2)
        love.graphics.rectangle("line", 1870, 10, 40, 40, 2, 2)
        if #collapseParticles == 0 and player.tower.currentHealth <= 0 then
            menu_display_gameOver()
        end
        if player.menu.gameplayInfo then
            love.graphics.setLineWidth(1)
            love.graphics.setColor(0, 0, 0, 0.5)
            love.graphics.rectangle("fill", 0, 0, 1920, 1080)
            love.graphics.setColor(0.2, 0, 0.35, 1)
            love.graphics.rectangle("fill", 710, 240, 500, 600, 2, 2)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.rectangle("line", 710, 240, 500, 600, 2, 2)
            love.graphics.setFont(font_AfacadBold24)
            love.graphics.printf(string.format("Gameplay Info - Wave %d", gameplay.wave), 710, 243, 500, "center")
            love.graphics.setFont(font_AfacadBold20)
            local columnCenters = {760, 860, 960, 1060, 1160}
            local rowCenters = {290, 340, 390, 440, 490, 540}
            local wrapWidth = 200
            local enemySize = {24, 36, 20, 48, 64}
            local enemyStats = {
                {"Enemy", "Health", "Damage", "Speed", "Chance"},
                {img_enemy_basic, img_enemy_tank, img_enemy_swift, img_enemy_sentry, img_enemy_centurion},
                {enemyAttributes.health, enemyAttributes.health * 5, enemyAttributes.health * 0.75, enemyAttributes.health * (10 + math.floor((gameplay.wave - 10) / 10) * 2.5), enemyAttributes.health * 256},
                {enemyAttributes.attackDamage, enemyAttributes.attackDamage * 1.2, enemyAttributes.attackDamage, enemyAttributes.attackDamage * 4, enemyAttributes.attackDamage * 10},
                {enemyAttributes.speed / 20, enemyAttributes.speed * 0.8 / 20, enemyAttributes.speed * 2 / 20, enemyAttributes.speed * 0.6 / 20, enemyAttributes.speed * 0.5 / 20},
                {enemyAttributes.spawn.basic, enemyAttributes.spawn.tank, enemyAttributes.spawn.swift, gameplay.wave % 10 == 0 and gameplay.wave % 100 ~= 0 and 100 or 0, gameplay.wave % 100 == 0 and 100 or 0},
            }
            for i=1,#enemyStats[1] do
                love.graphics.printf(enemyStats[1][i], columnCenters[i] - wrapWidth / 2, rowCenters[1], wrapWidth, "center")
            end
            for i=1,#enemyStats[2] do
                love.graphics.draw(enemyStats[2][i], columnCenters[1] - 13, rowCenters[i+1], 0, 24 / enemySize[i])
            end
            love.graphics.setFont(font_Afacad20)
            for i=1,3 do
                for j=1,#enemyStats[2] do
                    love.graphics.printf(notations.convertToLetterNotation(enemyStats[i+2][j], "precise"), columnCenters[i+1] - wrapWidth / 2, rowCenters[j+1] - 2, wrapWidth, "center")
                end
            end
            for i=1,#enemyStats[2] do
                love.graphics.printf(string.format("%.1f%%", enemyStats[6][i]), columnCenters[5] - wrapWidth / 2, rowCenters[i+1] - 2, wrapWidth, "center")
            end
            love.graphics.printf({{1, 1, 1, 1}, "Enemy spawn cap: ", {1, 0.8, 0.5, 1}, string.format("%d", enemyAttributes.waveCap)}, 710, 760, 500, "center")
            love.graphics.printf({{1, 1, 1, 1}, "Enemy spawn rate: ", {1, 0.8, 0.5, 1}, string.format("%.1f", enemyAttributes.spawnRate)}, 710, 800, 500, "center")
            love.graphics.draw(img_button_arrowRight_big, 1210, 522)
            tooltips.displayGameplayInfo()
        end
        if player.menu.battleStats then
            love.graphics.setLineWidth(1)
            love.graphics.setLineStyle("smooth")
            love.graphics.setColor(0, 0, 0, 0.5)
            love.graphics.rectangle("fill", 0, 0, 1920, 1080)
            love.graphics.setColor(0.2, 0, 0.35, 1)
            love.graphics.rectangle("fill", 710, 240, 500, 600, 2, 2)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.rectangle("line", 710, 240, 500, 600, 2, 2)
            love.graphics.setFont(font_AfacadBold24)
            love.graphics.printf("Player Stats - Battle", 710, 243, 500, "center")
            love.graphics.draw(img_button_arrowLeft_big, 674, 522)
            local rowCenters = {290, 320, 350, 380, 410, 440, 470, 500, 530, 560}
            local statNames = {"Battle Time", "Enemies Killed", "Damage Taken", "Damage Dealt", "Copper Earned", "Silver Earned", "Damage Absorbed", "Waves Skipped", "Projectiles Fired", "Upgrades Acquired"}
            local statVars = {player.stats.battle.time, {player.stats.battle.enemiesKilled, "brief"}, {player.stats.battle.damageTaken, "precise"}, {player.stats.battle.damageDealt, "precise"}, {player.stats.battle.copperEarned, "brief"}, {player.stats.battle.silverEarned, "brief"}, {player.stats.battle.shieldDamageAbsorb, "precise"}, {player.stats.battle.wavesSkipped, "brief"}, {player.stats.battle.projectilesFired, "brief"}, {player.stats.battle.upgradesAcquired, "brief"}}
            for i=1,#statNames do
                love.graphics.setFont(font_Afacad20)
                love.graphics.printf(statNames[i], 810, rowCenters[i], 200, "left")
                love.graphics.setFont(font_AfacadBold20)
                if i ~= 1 then
                    love.graphics.printf({{0, 1 - i / 50, 0.8 + i / 250, 1}, string.format("%s", notations.convertToLetterNotation(statVars[i][1], statVars[i][2]))}, 910, rowCenters[i], 200, "right")    
                else
                    love.graphics.printf({{0, 1 - i / 50, 0.8 + i / 250, 1}, string.format("%dm %ds", statVars[i] / 60, statVars[i] % 60)}, 910, rowCenters[i], 200, "right")    
                end
            end
        end
        if player.menu.paused then
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
            love.graphics.rectangle("line", 890, 530, 140, 40, 2, 2)
            love.graphics.setFont(font_Afacad24)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.printf("Settings", 870, 532, 180, "center")

            love.graphics.setColor(0.1, 0.15, 0.5, 1)
            love.graphics.rectangle("fill", 810, 610, 140, 60)
            love.graphics.setColor(0.3, 0.75, 0.85, 1)
            love.graphics.setLineWidth(2)
            love.graphics.rectangle("line", 810, 610, 140, 60, 2, 2)
            love.graphics.setFont(font_Afacad24)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.printf("Back to game", 810, 622, 140, "center")

            love.graphics.setColor(0.1, 0.15, 0.5, 1)
            love.graphics.rectangle("fill", 970, 610, 140, 60)
            love.graphics.setColor(0.3, 0.75, 0.85, 1)
            love.graphics.setLineWidth(2)
            love.graphics.rectangle("line", 970, 610, 140, 60, 2, 2)
            love.graphics.setFont(font_Afacad24)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.setColor(1, 0.2, 0.25, 1)
            love.graphics.printf("End Battle", 970, 622, 140, "center")

            if player.menu.settings then
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
                elseif not player.settings.waveSkipMessages then
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
                elseif not player.settings.tooltips then
                    love.graphics.draw(img_button_arrowRight, 1076, 572)
                end

                love.graphics.setFont(font_AfacadBold24)
                love.graphics.printf("Volume", 710, 620, 500, "center")
                love.graphics.setFont(font_Afacad20)
                love.graphics.printf(math.floor(player.settings.volume * 100) .. "%", 710, 650, 500, "center")
                love.graphics.setColor(1, 0, 0, 1)
                love.graphics.rectangle("fill", 835, 680, 250, 12)
                love.graphics.setColor(0, 1, 0, 1)
                love.graphics.rectangle("fill", 835, 680, 250 * (math.floor(player.settings.volume * 100) / 100), 12)

                love.graphics.setColor(0.1, 0.15, 0.5, 1)
                love.graphics.rectangle("fill", 910, 780, 100, 40, 2, 2)
                love.graphics.setColor(0.3, 0.75, 0.85, 1)
                love.graphics.setLineWidth(2)
                love.graphics.rectangle("line", 910, 780, 100, 40, 2, 2)
                love.graphics.setFont(font_Afacad24)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.printf("Back", 910, 782, 100, "center")
            end
        end
    elseif player.location == "hub" then
        inHub_visual()
        if hubSection == "Science" then
            tooltips.displayHub()
        end
        if player.menu.saveStats then
            love.graphics.setLineWidth(1)
            love.graphics.setLineStyle("smooth")
            love.graphics.setColor(0, 0, 0, 0.5)
            love.graphics.rectangle("fill", 0, 0, 1920, 1080)
            love.graphics.setColor(0.2, 0, 0.35, 1)
            love.graphics.rectangle("fill", 710, 240, 500, 600, 2, 2)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.rectangle("line", 710, 240, 500, 600, 2, 2)
            love.graphics.setFont(font_AfacadBold24)
            love.graphics.printf("Player Stats - Savefile", 710, 243, 500, "center")
            local rowCenters = {290, 320, 350, 380, 410, 440, 470, 500}
            local statNames = {"Enemies Killed", "Damage Dealt", "Silver Earned", "Waves Skipped", "Projectiles Fired", "Science Upgrades", "Nexus Upgrades", "Waves Defeated"}
            local statVars = {{player.stats.save.enemiesKilled, "brief"}, {player.stats.save.damageDealt, "precise"}, {player.stats.save.silverEarned, "brief"}, {player.stats.save.wavesSkipped, "brief"}, {player.stats.save.projectilesFired, "brief"}, {player.stats.save.upgradesAcquired.science, "brief"}, {player.stats.save.upgradesAcquired.nexus, "brief"}, {player.stats.save.wavesBeaten, "brief"}}
            for i=1,#statNames do
                love.graphics.setFont(font_Afacad20)
                love.graphics.printf(statNames[i], 810, rowCenters[i], 200, "left")
                love.graphics.setFont(font_AfacadBold20)
                love.graphics.printf({{0.8 + i / 250, 0.5 - i / 50, 0.1, 1}, string.format("%s", notations.convertToLetterNotation(statVars[i][1], statVars[i][2]))}, 910, rowCenters[i], 200, "right")    
            end
        end
    end
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(font_Afacad16)
    love.graphics.printf("v" .. gameVersionSemantic .. " - " .. love.timer.getFPS() .. "fps", 1743, 0, 120, "right")
end

function love.update(dt)
    if player.location == "round" then
        --[[ Automatically shoot the closest enemy in range ]]--
        if player.tower.currentHealth > 0 then
            if not player.menu.paused then
                towers.eclipse2(true, dt)
            end
            if timers.projectile < 1 / player.tower.attackSpeed then
                timers.projectile = timers.projectile + dt * gameplay.gameSpeed
            else
                if closestEnemies[1] ~= nil then
                    timers.projectile = 0
                    local scatterFireChance = love.math.random(0, 10000) / 100
                    local burstFireChance = love.math.random(0, 10000) / 100
                    createProjectile(957, 537, 500, false, false)
                    local tf = audio_tower_fire:clone()
                    tf:setVolume(1 * player.settings.volume^2)
                    tf:play()
                    if scatterFireChance <= levelingInfo[2].frequency[player.abilities.scatterFire.level + 1] and player.abilities.scatterFire.unlocked and player.abilities.scatterFire.equipped then
                        local sx = love.math.random(50, 1870)
                        local sy = love.math.random(50, 1030)
                        local sf = audio_tower_scatterFire__burstFire:clone()
                        sf:setVolume(1 * player.settings.volume^2)
                        sf:play()
                        for i=1,levelingInfo[2].quantity[player.abilities.scatterFire.level + 1] do
                            createProjectile(sx, sy, 500, true, false)
                        end
                    end
                    if burstFireChance <= levelingInfo[3].frequency[player.abilities.burstFire.level + 1] and player.abilities.burstFire.unlocked and player.abilities.burstFire.equipped then
                        local bf = audio_tower_scatterFire__burstFire:clone()
                        bf:setVolume(1 * player.settings.volume^2)
                        bf:play()
                        for i=1,levelingInfo[3].quantity[player.abilities.burstFire.level + 1] do
                            createProjectile(957, 537, 500, false, true)
                        end
                    end
                end
            end
            --[[ Spawn an enemy once the enemy spawn timer goes off ]]--
            if timers.enemy < 1 / enemyAttributes.spawnRate then
                timers.enemy = timers.enemy + dt * gameplay.gameSpeed
            else
                timers.enemy = 0
                if enemyAttributes.pendingEnemies > 0 then
                    createEnemy(enemyAttributes.health, enemyAttributes.speed, 1, enemyAttributes.attackDamage)
                    enemyAttributes.pendingEnemies = enemyAttributes.pendingEnemies - 1
                end
            end
            findClosestEnemyInRange()
        end
        --[[ Move projectiles depending on their angle ]]--
        for i,v in ipairs(projectilesOnField) do
            v.x = v.x + math.cos(v.angle) * v.speed * dt * gameplay.gameSpeed
            v.y = v.y + math.sin(v.angle) * v.speed * dt * gameplay.gameSpeed
            if math.dist(960, 540, v.x + 3, v.y + 3) > player.tower.range and not v.scatterFire then
                table.remove(projectilesOnField, i)
            elseif v.x + 3 < -10 and v.x + 3 > 1930 and v.y + 3 < -10 and v.y + 3 > 1090 and v.scatterFire then
                table.remove(projectilesOnField, i)
            end
            for j,w in ipairs(enemiesOnField) do
                local size = {
                    basic = 22,
                    tank = 34,
                    swift = 16,
                    sentry = 46,
                    centurion = 62,
                    }
                if v.x > w.x + 2 and v.x < w.x + size[w.type] and v.y > w.y + 2 and v.y < w.y + size[w.type] then
                    table.remove(projectilesOnField, i)
                    --[[ If the projectile deals crit damage, deal more damage based on Critical Factor ]]--
                    local critFactor = v.isCrit and player.tower.critFactor or 1
                    local damage = player.tower.attackDamage * critFactor
                    damageEnemy(j, damage, v.isCrit)
                    closestEnemies = {}
                    break
                end
            end
        end

        for i,v in ipairs(enemiesOnField) do
            local offsets = {
                basic = 10,
                tank = 16,
                swift = 8,
                sentry = 22,
                centurion = 30,
                }

            local stopDistance = {
                basic = TOWER_SIZE + 10,
                tank = TOWER_SIZE + 16,
                swift = TOWER_SIZE + 8,
                sentry = TOWER_SIZE + 22,
                centurion = TOWER_SIZE + 30
                }
            local rainforestMultiplier = rainforestActive and 1 - levelingInfo[4].density[player.abilities.rainforest.level + 1] / 100 or 1
            if v.burningTime > 0 and gameplay.gameSpeed > 0 then
                for i=1,love.math.random(-4, 1) * settings_particleMultipliers[player.settings.particleMultiplier] do
                    createBurnParticle(v.x + 2, v.y + 2)
                end
            end
            if v.timer_untilAttack < (1 / v.attackSpeed) / rainforestMultiplier then
                v.timer_untilAttack = v.timer_untilAttack + dt * gameplay.gameSpeed
            else
                --[[ If an enemy is close enough, start attacking the tower ]]--
                if math.dist(v.x + offsets[v.type] + 2, v.y + offsets[v.type] + 2, 960, 540) < stopDistance[v.type] + 1 and player.tower.currentHealth > 0 then
                    v.timer_untilAttack = 0
                    local damageReduction = not v.resistanceIgnore and 1 - player.tower.resistance / 100 or 1
                    local da = audio_tower_damageAbsorbed:clone()
                    local dk = audio_tower_damageTaken:clone()
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
                end
            end
            --[[ Move each enemy towards the central tower if it is further than the specified distance ]]--

            if math.dist(v.x + offsets[v.type] + 2, v.y + offsets[v.type] + 2, 960, 540) > stopDistance[v.type] then
                local hyperloopMultiplier = math.dist(v.x + offsets[v.type] + 2, v.y + offsets[v.type] + 2, 960, 540) > player.tower.range and 1 + player.modifiers.hyperloop.value / 100 or 1
                local rainforestMultiplier = (rainforestActive and math.dist(v.x + offsets[v.type] + 2, v.y + offsets[v.type] + 2, 960, 540) <= player.tower.range) and 1 - levelingInfo[4].density[player.abilities.rainforest.level + 1] / 100 or 1
                v.angle = math.atan2(540 - v.y - 2 - offsets[v.type], 960 - v.x - 2 - offsets[v.type])
                v.x = v.x + math.cos(v.angle) * v.speed * dt * gameplay.gameSpeed * hyperloopMultiplier * rainforestMultiplier
                v.y = v.y + math.sin(v.angle) * v.speed * dt * gameplay.gameSpeed * hyperloopMultiplier * rainforestMultiplier
            end
            --[[ Regenerate 1% of Centurion health per second ]]
            if v.type == "centurion" and player.tower.currentHealth > 0 then
                if v.currentHP < v.maxHP then
                    v.currentHP = math.min(v.currentHP + v.maxHP * (0.01 * dt * gameplay.gameSpeed), v.maxHP)
                    centurionCurrentHP = v.currentHP
                end
            end
            if player.abilities.magmaTouch.unlocked and player.abilities.magmaTouch.equipped then
                if v.burningTime > 0 then
                    v.burningTime = v.burningTime - dt * gameplay.gameSpeed
                    v.burningUntilDamage = v.burningUntilDamage - dt * gameplay.gameSpeed
                end
                if v.burningUntilDamage < 0 then
                    damageEnemy(i, player.tower.attackDamage * (levelingInfo[5].damage[player.abilities.magmaTouch.level + 1] / 100))
                    v.burningUntilDamage = 1
                end
            end
        end

        for i,v in ipairs(meteors) do
            --[[ Orbit Meteors around the tower ]]--
            local potentialParticlePos = {
                {960 + (player.tower.range + 40 + love.math.random(-14, 14)) * math.cos(v.angle - 0.024 * math.pi), 540 + (player.tower.range + 40 + love.math.random(-14, 14)) * math.sin(v.angle - 0.024 * math.pi)},
                {960 + (player.tower.range + 40 + love.math.random(-14, 14)) * math.cos(v.angle - 0.018 * math.pi), 540 + (player.tower.range + 40 + love.math.random(-14, 14)) * math.sin(v.angle - 0.018 * math.pi)}
            }
            v.angle = v.angle + (player.tower.meteorRPM * (2 * math.pi)) / 60 * dt * gameplay.gameSpeed
            v.x = 960 + (player.tower.range + 40) * math.cos(v.angle)
            v.y = 540 + (player.tower.range + 40) * math.sin(v.angle)
            if v.timer_particle < v.particleFreq then
                v.timer_particle = v.timer_particle + dt * gameplay.gameSpeed
            else
                for i=1,love.math.random(1, 2) * settings_particleMultipliers[player.settings.particleMultiplier] do
                    createMeteorParticle(love.math.random(potentialParticlePos[1][1], potentialParticlePos[2][1]), love.math.random(potentialParticlePos[1][2], potentialParticlePos[2][2]))
                end
                v.timer_particle = 0
            end
            local size = {
                basic = 22,
                tank = 34,
                swift = 16,
                sentry = 46,
                centurion = 62,
                }
            for j,w in ipairs(enemiesOnField) do
                if v.x + 13 > w.x + 2 and v.x - 13 < w.x + size[w.type] and v.y + 13 > w.y + 2 and v.y - 13 < w.y + size[w.type] and player.tower.currentHealth > 0 then
                    if w.type == "basic" or w.type == "tank" or w.type == "swift" then
                        killEnemy(j)
                        closestEnemies[1] = nil
                    end
                end
            end
        end

        for i,v in ipairs(spikedCrystals) do
            local size = {
                basic = 22,
                tank = 34,
                swift = 16,
                sentry = 46,
                centurion = 62,
            }

            local offsets = {
                basic = 10,
                tank = 16,
                swift = 8,
                sentry = 22,
                centurion = 30,
            }
            v.timer_lifespan = v.timer_lifespan + dt * gameplay.gameSpeed
            if v.state == "exploding" then
                audio_crystal_explosion:setVolume(1 * player.settings.volume^2)
                audio_crystal_explosion:play()
                if v.timer_explosion < v.timer_explosionDuration then
                    v.timer_explosion = v.timer_explosion + dt * gameplay.gameSpeed
                else
                    for i=1,8*settings_particleMultipliers[player.settings.particleMultiplier] do
                        createCrystalExplosionParticle(v.x + 11, v.y + 11)
                    end
                    table.remove(spikedCrystals, i)
                end
            end
            for j,w in ipairs(enemiesOnField) do
                if v.x + 20 > w.x + 2 and v.x + 2 < w.x + size[w.type] and v.y + 20 > w.y + 2 and v.y + 2 < w.y + size[w.type] and player.tower.currentHealth > 0 and v.state == "alive" and math.dist(v.x + 11, v.y + 11, w.x + offsets[w.type], w.y + offsets[w.type]) < 64 then
                    local damage = player.tower.attackDamage * (levelingInfo[1].damage[player.abilities.spikedCrystals.level + 1] / 100)
                    damageEnemy(j, damage)
                    v.state = "exploding"
                end
            end
        end

        for i,v in ipairs(magmaPools) do
            local size = {
                basic = 22,
                tank = 34,
                swift = 16,
                sentry = 46,
                centurion = 62,
            }

            local offsets = {
                basic = 10,
                tank = 16,
                swift = 8,
                sentry = 22,
                centurion = 30,
            }
            for j,w in ipairs(enemiesOnField) do
                if math.dist(v.x + 18, v.y + 18, w.x + size[w.type] / 2, w.y + size[w.type] / 2) < 16 + size[w.type] / 2 then
                    table.remove(magmaPools, i)
                    damageEnemy(j, player.tower.attackDamage * (levelingInfo[5].damage[player.abilities.magmaTouch.level + 1] / 100))
                    w.burningTime = 4.025
                end
            end
        end

        --[[ If no enemies on field are present and the wave enemy cap is reached, wait a few seconds before advancing to the next wave ]]--
        if player.tower.currentHealth > 0 then
            if #enemiesOnField == 0 and enemyAttributes.pendingEnemies <= 0 then
                if timers.nextWave < gameplay.waveCooldown then
                    timers.nextWave = timers.nextWave + dt * gameplay.gameSpeed
                else
                    wavesSkipped = 0
                    timers.nextWave = 0

                    local oldCopperAmount = player.currencies.currentCopper
                    misc.copperBuffer = misc.copperBuffer + (player.tower.copperBonus % 1) * player.tower.copperPerWave
                    player.currencies.currentCopper = player.currencies.currentCopper + math.floor(player.tower.copperBonus) * player.tower.copperPerWave
                    if misc.copperBuffer >= 1 then
                        player.currencies.currentCopper = player.currencies.currentCopper + math.floor(misc.copperBuffer)
                        misc.copperBuffer = misc.copperBuffer - math.floor(misc.copperBuffer)
                    end
                    local newCopperAmount = player.currencies.currentCopper
                    local copperEarned = newCopperAmount - oldCopperAmount
                    player.stats.battle.copperEarned = player.stats.battle.copperEarned + copperEarned

                    local oldSilverAmount = player.currencies.currentSilver
                    misc.silverBuffer = misc.silverBuffer + (player.tower.silverBonus % 1) * player.tower.silverPerWave * difficultyMultipliers[gameplay.difficulty]
                    player.currencies.currentSilver = player.currencies.currentSilver + math.floor(player.tower.silverBonus) * player.tower.silverPerWave * difficultyMultipliers[gameplay.difficulty]
                    if misc.silverBuffer >= 1 then
                        player.currencies.currentSilver = player.currencies.currentSilver + math.floor(misc.silverBuffer)
                        misc.silverBuffer = misc.silverBuffer - math.floor(misc.silverBuffer)
                    end
                    local newSilverAmount = player.currencies.currentSilver
                    local silverEarned = newSilverAmount - oldSilverAmount
                    player.stats.battle.silverEarned = player.stats.battle.silverEarned + silverEarned
                    player.stats.save.silverEarned = player.stats.save.silverEarned + silverEarned

                    gameplay.wave = gameplay.wave + 1
                    player.stats.save.wavesBeaten = player.stats.save.wavesBeaten + 1
                    local waveSkip = love.math.random(0, 10000) / 100
                    while waveSkip <= player.modifiers.waveSkip.value do
                        wavesSkipped = wavesSkipped + 1
                        local waveSkip = love.math.random(0, 10000) / 100
                        if waveSkip > player.modifiers.waveSkip.value then
                            break
                        end
                    end
                    skipWave(wavesSkipped)
                    updateEnemyStats(gameplay.difficulty, gameplay.wave)
                end
            end
        end

        --[[ Regenerate health every frame, cap at max health if regeneration overflows ]]--
        if player.tower.currentHealth < player.tower.maxHealth and player.tower.currentHealth > 0 then
            player.tower.currentHealth = math.min(player.tower.currentHealth + player.tower.regeneration * dt * gameplay.gameSpeed, player.tower.maxHealth)
        end

        if player.settings.waveSkipMessages and waveSkipMessage then
            if timers.waveSkip < 3 then
                timers.waveSkip = timers.waveSkip + dt
            else
                timers.waveSkip = 0
                waveSkipMessage = false
            end
        end

        if player.upgrades.unlocks.shield then
            --[[ Count time until Shield activation, activate Shield for a specified time when cooldown ends (only if Shield upgrades are unlocked) ]]--
            if not shieldActive then
                if timers.shieldActivation < player.tower.shieldCooldown then
                    timers.shieldActivation = timers.shieldActivation + dt * gameplay.gameSpeed
                else
                    timers.shieldActivation = 0
                    shieldActive = true
                end
            elseif shieldActive then
                if timers.shieldActive < player.tower.shieldDuration then
                    timers.shieldActive = timers.shieldActive + dt * gameplay.gameSpeed
                else
                    timers.shieldActive = 0
                    shieldActive = false
                end
            end
        end

        checkIfTowerCollapsed()
        updateParticles(dt)
        player.stats.battle.time = player.stats.battle.time + dt * gameplay.gameSpeed

        if player.abilities.spikedCrystals.unlocked and player.abilities.spikedCrystals.equipped then
            if timers.crystal < levelingInfo[1].frequency[player.abilities.spikedCrystals.level + 1] then
                timers.crystal = timers.crystal + dt * gameplay.gameSpeed
            else
                timers.crystal = 0
                for i=1,math.max(levelingInfo[1].quantity[player.abilities.spikedCrystals.level + 1] - #spikedCrystals, 0) do
                    spawnCrystal()
                end
            end
        end

        if player.abilities.rainforest.unlocked and player.abilities.rainforest.equipped then
            if gameplay.wave >= 20 then
                rainforestActive = (gameplay.wave % 10 <= 4) and true or false
            end
        end

        if player.abilities.magmaTouch.unlocked and player.abilities.magmaTouch.equipped then
            if timers.magmaPool < levelingInfo[5].frequency[player.abilities.magmaTouch.level + 1] then
                timers.magmaPool = timers.magmaPool + dt * gameplay.gameSpeed
            else
                if #magmaPools < 20 then
                    timers.magmaPool = 0
                    spawnMagmaPool()
                end
            end
        end

        if love.mouse.isDown(1) then
            local mcx, mcy = love.mouse.getPosition()
            if player.menu.settings then
                if mcx >= 835 and mcx <= 1085 and mcy >= 680 and mcy <= 692 then
                    player.settings.volume = (mcx - 835) / 250
                end
            end
        end

    elseif player.location == "hub" then
        player.abilities.equipped = 0
        for i=1,#internalAbilities do
            if internalAbilities[i].equipped then
                player.abilities.equipped = player.abilities.equipped + 1
            end
        end
    end
    --[[ Set a timer for alloying Electrum, add 1 Electrum when the timer runs out ]]--
    if not player.canClaim.electrum then
        if player.timers.electrum < player.cooldowns.electrum then
            player.timers.electrum = player.timers.electrum + dt * gameplay.gameSpeed
        else
            player.timers.electrum = 0
            player.canClaim.electrum = true
            player.currencies.currentElectrum = player.currencies.currentElectrum + 1
        end
    end
    if not player.canClaim.tokens then
        if player.timers.tokens < player.cooldowns.tokens then
            player.timers.tokens = player.timers.tokens + dt * gameplay.gameSpeed
        else
            player.timers.tokens = 0
            player.canClaim.tokens = true
        end
    end
    if not player.canClaim.ability and player.misc.abilityAssembling then
        if player.timers.abilityAssembly < player.cooldowns.abilityAssembly_current then
            player.timers.abilityAssembly = player.timers.abilityAssembly + dt * gameplay.gameSpeed
        else
            player.timers.abilityAssembly = player.cooldowns.abilityAssembly_current
            player.canClaim.ability = true
        end
    end
end

function love.mousepressed(x, y)

    upgradeMenu_mouse(x, y)

    if player.tower.currentHealth > 0 then
        --[[ Open/close upgrade menu ]]--
        if x >= 860 and x <= 1060 and y >= 1030 and y <= 1080 and not player.menu.upgrades and not player.menu.paused and not player.menu.gameplayInfo and not player.menu.battleStats then
            player.menu.upgrades = true
        elseif x >= 860 and x <= 1060 and y >= 750 and y <= 800 and player.menu.upgrades and not player.menu.paused and not player.menu.gameplayInfo and not player.menu.battleStats then
            player.menu.upgrades = false
        end

        if x >= 1870 and x <= 1910 and y >= 10 and y <= 50 and not player.menu.paused and not player.menu.gameplayInfo and not player.menu.battleStats then
            gameplay.gameSpeed = 0
            player.menu.paused = true
        end

        if x >= 810 and x <= 950 and y >= 610 and y <= 670 and player.menu.paused and not player.menu.settings and not player.menu.gameplayInfo and not player.menu.battleStats then
            gameplay.gameSpeed = player.maxGameSpeed
            player.menu.paused = false
        elseif x >= 970 and x <= 1110 and y >= 610 and y <= 670 and player.menu.paused and not player.menu.settings and not player.menu.gameplayInfo and not player.menu.battleStats then
            gameplay.gameSpeed = player.maxGameSpeed
            player.menu.paused = false
            player.tower.currentHealth = 0
        elseif x >= 890 and x <= 1150 and y >= 530 and y <= 570 and player.menu.paused and not player.menu.settings and not player.menu.gameplayInfo and not player.menu.battleStats then
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

        if x >= 910 and x <= 1010 and y >= 780 and y <= 820 then
            player.menu.settings = false
        end
    end

    if player.menu.gameplayInfo then
        if x >= 1210 and x <= 1246 and y >= 522 and y <= 558 then
            player.menu.gameplayInfo = false
            player.menu.battleStats = true
        end
    elseif player.menu.battleStats then
        if x >= 674 and x <= 710 and y >= 522 and y <= 558 then
            player.menu.gameplayInfo = true
            player.menu.battleStats = false
        end
    end

    --[[ If the "To Hub" button is pressed at the end screen, go to Hub ]]--
    if gameOver and #collapseParticles == 0 and player.location == "round" and not player.menu.gameplayInfo and not player.menu.battleStats then
        if x >= 870 and x <= 1050 and y >= 760 and y <= 820 then
            player.menu.upgrades = false
            player.location = "hub"
            gameplay.gameSpeed = player.maxGameSpeed
            player.menu.paused = false
            hubSection = "Main"
            resetRoundValues()
            processUpgradeModule.reload()
        end
    end

    inHub_mouse(x, y)
end

function love.keypressed(key)
    if key == "escape" then
        saveGame()
        love.event.quit()
    end
    if key == "tab" and not player.menu.paused then
        if player.location == "round" then
            if not player.menu.battleStats then
                player.menu.gameplayInfo = not player.menu.gameplayInfo
                gameplay.gameSpeed = player.menu.gameplayInfo and 0 or player.maxGameSpeed
            else
                player.menu.gameplayInfo = false
                player.menu.battleStats = false
                gameplay.gameSpeed = player.menu.gameplayInfo and 0 or player.maxGameSpeed
            end
        elseif player.location == "hub" then
            player.menu.saveStats = not player.menu.saveStats
        end
    end
    if player.location == "round" and key == "g" then
        spawnMagmaPool()
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