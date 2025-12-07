upgradeModuleFuncs = {}
unlockPanelFuncs = {}

---Simply reloads all Battle/Science upgrade modules and upgrade unlock panels with their respective effects and costs.
function upgradeModuleFuncs.load()
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
function upgradeModuleFuncs.reloadFormulae(x, z)
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
function upgradeModuleFuncs.draw(module)
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
function upgradeModuleFuncs.upgrade(x, y, module, costFormula, valueFormula)
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

--- Draw an unlock panel if the succeeding upgrades are not unlocked.
---@param unlockPanel table The unlock panel to draw.
function unlockPanelFuncs.draw(unlockPanel)
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
function unlockPanelFuncs.clickCheck(x, y, unlockPanel)
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