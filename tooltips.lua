tooltips = {}

function tooltips.general()
    if player.settings.tooltips then
        local mx, my = love.mouse.getPosition()
        function tooltips.appearance(width, height, desc, desc2)
            love.graphics.setColor(0.9, 0.9, 0.9, 1)
            love.graphics.rectangle("fill", mx, my - height - 2, width, height)
            love.graphics.setLineStyle("rough")
            love.graphics.setLineWidth(1)
            love.graphics.setColor(0.15, 0.15, 0.15, 1)
            love.graphics.rectangle("line", mx, my - height - 2, width, height)
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.setFont(font_Vera12)
            love.graphics.printf(desc, mx + 4, my - height, width, "left")
            if desc2 then
                love.graphics.printf(desc2, mx + 4, my - height + 20, width, "left")
            end
        end

        function tooltips.hoverCheck(x, y, width, height)
            if mx >= x and mx <= x + width and my >= y and my <= y + height then
                return true
            end
        end

        local roundTooltips = {
            ["ATK"] = {
                {10, 850, 254, 60, 180, 40, "Damage dealt by projectiles.", string.format("Level: %d (%d+%d)/%s", player.upgrades.round.attackDamage.level, player.upgrades.science.attackDamage.level, player.upgrades.round.attackDamage.level - player.upgrades.science.attackDamage.level, math.huge), ["precedingUpgrade"] = true}, --Attack Damage Round upgrade tooltip
                {10, 920, 254, 60, 230, 40, "Speed the tower fires projectiles at.", string.format("Level: %d (%d+%d)/%d", player.upgrades.round.attackSpeed.level, player.upgrades.science.attackSpeed.level, player.upgrades.round.attackSpeed.level - player.upgrades.science.attackSpeed.level, 106), ["precedingUpgrade"] = true}, --Attack Speed Round upgrade tooltip
                {10, 990, 254, 60, 280, 40, "Chance to deal increased projectile damage.", string.format("Level: %d (%d+%d)/%d", player.upgrades.round.critChance.level, player.upgrades.science.critChance.level, player.upgrades.round.critChance.level - player.upgrades.science.critChance.level, 81), ["precedingUpgrade"] = player.upgrades.unlocks.crit}, --Critical Chance Round upgrade tooltip
                {370, 850, 254, 60, 400, 40, "How much the projectile damage is multiplied by on critical hits.", string.format("Level: %d (%d+%d)/%d", player.upgrades.round.critFactor.level, player.upgrades.science.critFactor.level, player.upgrades.round.critFactor.level - player.upgrades.science.critFactor.level, 181), ["precedingUpgrade"] = player.upgrades.unlocks.crit}, --Critical Factor Round upgrade tooltip
                {370, 920, 254, 60, 240, 40, "Maximum enemy detection distance.", string.format("Level: %d (%d+%d)/%d", player.upgrades.round.range.level, player.upgrades.science.range.level, player.upgrades.round.range.level - player.upgrades.science.range.level, 81), ["precedingUpgrade"] = player.upgrades.unlocks.range}, --Range Round upgrade tooltip
                {370, 990, 254, 60, 310, 40, "Chance to shoot several enemies simultaneously.", string.format("Level: %d (%d+%d)/%d", player.upgrades.round.clusterFireChance.level, player.upgrades.science.clusterFireChance.level, player.upgrades.round.clusterFireChance.level - player.upgrades.science.clusterFireChance.level, 121), ["precedingUpgrade"] = player.upgrades.unlocks.clusterFire}, --Cluster Fire Chance Round upgrade tooltip
                {730, 850, 254, 60, 310, 40, "How many enemies the tower can shoot at once.", string.format("Level: %d (%d+%d)/%d", player.upgrades.round.clusterFireTargets.level, player.upgrades.science.clusterFireTargets.level, player.upgrades.round.clusterFireTargets.level - player.upgrades.science.clusterFireTargets.level, 5), ["precedingUpgrade"] = player.upgrades.unlocks.clusterFire}, --Cluster Fire Targets Round upgrade tooltip
                {730, 920, 254, 60, 430, 40, "Amount of damage dealt via Cluster Fire relative to normal projectiles.", string.format("Level: %d (%d+%d)/%d", player.upgrades.round.clusterFireEfficiency.level, player.upgrades.science.clusterFireEfficiency.level, player.upgrades.round.clusterFireEfficiency.level - player.upgrades.science.clusterFireEfficiency.level, 144), ["precedingUpgrade"] = player.upgrades.unlocks.clusterFire}, --Cluster Fire Efficiency Round upgrade tooltip

            },

            ["VIT"] = {
                {10, 850, 254, 60, 340, 40, "Maximum amount of true damage the tower can take.", string.format("Level: %d (%d+%d)/%s", player.upgrades.round.health.level, player.upgrades.science.health.level, player.upgrades.round.health.level - player.upgrades.science.health.level, math.huge), ["precedingUpgrade"] = true}, --Health Round upgrade tooltip
                {10, 920, 254, 60, 290, 40, "Speed the tower recovers its health over time.", string.format("Level: %d (%d+%d)/%s", player.upgrades.round.regeneration.level, player.upgrades.science.regeneration.level, player.upgrades.round.regeneration.level - player.upgrades.science.regeneration.level, math.huge), ["precedingUpgrade"] = true}, --Regeneration Round upgrade tooltip
                {10, 990, 254, 60, 310, 40, "The percentage incoming damage is reduced by.", string.format("Level: %d (%d+%d)/%d", player.upgrades.round.resistance.level, player.upgrades.science.resistance.level, player.upgrades.round.resistance.level - player.upgrades.science.resistance.level, 101), ["precedingUpgrade"] = player.upgrades.unlocks.resistance}, --Resistance Round upgrade tooltip
                {370, 850, 254, 60, 210, 40, "Time between Shield activations.", string.format("Level: %d (%d+%d)/%d", player.upgrades.round.shieldCooldown.level, player.upgrades.science.shieldCooldown.level, player.upgrades.round.shieldCooldown.level - player.upgrades.science.shieldCooldown.level, 126), ["precedingUpgrade"] = player.upgrades.unlocks.shield}, --Shield Cooldown Round upgrade tooltip
                {370, 920, 254, 60, 340, 40, "How long the tower is immune to non-boss attacks for.", string.format("Level: %d (%d+%d)/%d", player.upgrades.round.shieldDuration.level, player.upgrades.science.shieldDuration.level, player.upgrades.round.shieldDuration.level - player.upgrades.science.shieldDuration.level, 111), ["precedingUpgrade"] = player.upgrades.unlocks.shield}, --Shield Duration Round upgrade tooltip
                {370, 990, 254, 60, 500, 40, "Amount of Meteors orbiting around the tower, instantly killing non-boss enemies.", string.format("Level: %d (%d+%d)/%d", player.upgrades.round.meteorAmount.level, player.upgrades.science.meteorAmount.level, player.upgrades.round.meteorAmount.level - player.upgrades.science.meteorAmount.level, 6), ["precedingUpgrade"] = player.upgrades.unlocks.meteor}, --Meteor Amount Round upgrade tooltip
                {730, 850, 254, 60, 260, 40, "How fast Meteors orbit around the tower.", string.format("Level: %d (%d+%d)/%d", player.upgrades.round.meteorRPM.level, player.upgrades.science.meteorRPM.level, player.upgrades.round.meteorRPM.level - player.upgrades.science.meteorRPM.level, 40), ["precedingUpgrade"] = player.upgrades.unlocks.meteor}, --Meteor RPM Round upgrade tooltip
                {730, 920, 254, 60, 330, 40, "Chance to heal by some damage dealt to an enemy.", string.format("Level: %d (%d+%d)/%d", player.upgrades.round.lifestealChance.level, player.upgrades.science.lifestealChance.level, player.upgrades.round.lifestealChance.level - player.upgrades.science.lifestealChance.level, 41), ["precedingUpgrade"] = player.upgrades.unlocks.lifesteal}, --Lifesteal Chance Round upgrade tooltip
                {730, 990, 254, 60, 340, 40, "Percentage of damage healed upon lifesteal activation.", string.format("Level: %d (%d+%d)/%d", player.upgrades.round.lifestealPercent.level, player.upgrades.science.lifestealPercent.level, player.upgrades.round.lifestealPercent.level - player.upgrades.science.lifestealPercent.level, 76), ["precedingUpgrade"] = player.upgrades.unlocks.lifesteal}, --Lifesteal Percentage Round upgrade tooltip
            },

            ["UTL"] = {
                {10, 850, 254, 60, 320, 40, "Amount of Copper earned at the end of each wave.", string.format("Level: %d (%d+%d)/%s", player.upgrades.round.copperPerWave.level, player.upgrades.science.copperPerWave.level, player.upgrades.round.copperPerWave.level - player.upgrades.science.copperPerWave.level, math.huge), ["precedingUpgrade"] = true}, --Copper/wave Round upgrade tooltip
                {10, 920, 254, 60, 310, 40, "Amount of Silver earned at the end of each wave.", string.format("Level: %d (%d+%d)/%s", player.upgrades.round.silverPerWave.level, player.upgrades.science.silverPerWave.level, player.upgrades.round.silverPerWave.level - player.upgrades.science.silverPerWave.level, math.huge), ["precedingUpgrade"] = true}, --Silver/wave Round upgrade tooltip
                {10, 990, 254, 60, 350, 40, "What incoming Copper from all sources is multiplied by.", string.format("Level: %d (%d+%d)/%d", player.upgrades.round.copperBonus.level, player.upgrades.science.copperBonus.level, player.upgrades.round.copperBonus.level - player.upgrades.science.copperBonus.level, 451), ["precedingUpgrade"] = player.upgrades.unlocks.resourceBonus}, --Copper Bonus Round upgrade tooltip
                {370, 850, 254, 60, 340, 40, "What incoming Silver from all sources is multiplied by.", string.format("Level: %d (%d+%d)/%d", player.upgrades.round.silverBonus.level, player.upgrades.science.silverBonus.level, player.upgrades.round.silverBonus.level - player.upgrades.science.silverBonus.level, 301), ["precedingUpgrade"] = player.upgrades.unlocks.resourceBonus}, --Silver Bonus Round upgrade tooltip
            }
            
        }
        function tooltips.displayRound()
            for i,v in ipairs(roundTooltips[roundUpgradeSection]) do
                if tooltips.hoverCheck(roundTooltips[roundUpgradeSection][i][1], roundTooltips[roundUpgradeSection][i][2], roundTooltips[roundUpgradeSection][i][3], roundTooltips[roundUpgradeSection][i][4]) and roundTooltips[roundUpgradeSection][i]["precedingUpgrade"] then
                    tooltips.appearance(roundTooltips[roundUpgradeSection][i][5], roundTooltips[roundUpgradeSection][i][6], roundTooltips[roundUpgradeSection][i][7], roundTooltips[roundUpgradeSection][i][8])
                end
            end
        end

        local scienceTooltips = {
            {245, 240, 254, 60, 180, 40, "Damage dealt by projectiles.", string.format("Level: %d/%s", player.upgrades.science.attackDamage.level, math.huge), ["precedingUpgrade"] = true}, --Attack Damage Hub upgrade tooltip
            {605, 240, 254, 60, 230, 40, "Speed the tower fires projectiles at.", string.format("Level: %d/%d", math.min(player.upgrades.science.attackSpeed.level, 106), 106), ["precedingUpgrade"] = true}, --Attack Speed Science upgrade tooltip
            {965, 240, 254, 60, 280, 40, "Chance to deal increased projectile damage.", string.format("Level: %d/%d", math.min(player.upgrades.science.critChance.level, 81), 81), ["precedingUpgrade"] = player.upgrades.unlocks.crit}, --Critical Chance Science upgrade tooltip
            {1325, 240, 254, 60, 400, 40, "How much the projectile damage is multiplied by on critical hits.", string.format("Level: %d/%d", math.min(player.upgrades.science.critFactor.level, 181), 181), 181, ["precedingUpgrade"] = player.upgrades.unlocks.crit}, --Critical Factor Science upgrade tooltip
            {245, 310, 254, 60, 240, 40, "Maximum enemy detection distance.", string.format("Level: %d/%d", math.min(player.upgrades.science.range.level, 81), 81), ["precedingUpgrade"] = player.upgrades.unlocks.range}, --Critical Factor Science upgrade tooltip
            {605, 310, 254, 60, 310, 40, "Chance to shoot several enemies simultaneously.", string.format("Level: %d/%d", math.min(player.upgrades.science.clusterFireChance.level, 121), 121), 121, ["precedingUpgrade"] = player.upgrades.unlocks.clusterFire}, --Cluster Fire Chance Science upgrade tooltip
            {965, 310, 254, 60, 310, 40, "How many enemies the tower can shoot at once.", string.format("Level: %d/%d", math.min(player.upgrades.science.clusterFireTargets.level, 5), 5), ["precedingUpgrade"] = player.upgrades.unlocks.clusterFire}, --Cluster Fire Targets Science upgrade tooltip
            {1325, 310, 254, 60, 430, 40, "Amount of damage dealt via Cluster Fire relative to normal projectiles.", string.format("Level: %d/%d", math.min(player.upgrades.science.clusterFireEfficiency.level, 144), 144), 144, ["precedingUpgrade"] = player.upgrades.unlocks.clusterFire}, --Cluster Fire Chance Science upgrade tooltip

            {245, 540, 254, 60, 340, 40, "Maximum amount of true damage the tower can take.", string.format("Level: %d/%s", player.upgrades.science.health.level, math.huge), ["precedingUpgrade"] = true}, --Health Science upgrade tooltip
            {605, 540, 254, 60, 290, 40, "Speed the tower recovers its health over time.", string.format("Level: %d/%s", player.upgrades.science.regeneration.level, math.huge), ["precedingUpgrade"] = true}, --Regeneration Science upgrade tooltip
            {965, 540, 254, 60, 310, 40, "The percentage incoming damage is reduced by.", string.format("Level: %d/%d", math.min(player.upgrades.science.resistance.level, 101), 101), ["precedingUpgrade"] = player.upgrades.unlocks.resistance}, --Resistance Science upgrade tooltip
            {1325, 540, 254, 60, 210, 40, "Time between Shield activations.", string.format("Level: %d/%d", math.min(player.upgrades.science.shieldCooldown.level, 126), 126), ["precedingUpgrade"] = player.upgrades.unlocks.shield}, --Shield Cooldown Science upgrade tooltip
            {245, 610, 254, 60, 340, 40, "How long the tower is immune to non-boss attacks for.", string.format("Level: %d/%d", math.min(player.upgrades.science.shieldDuration.level, 111), 111), ["precedingUpgrade"] = player.upgrades.unlocks.shield}, --Shield Duration Science upgrade tooltip
            {605, 610, 254, 60, 500, 40, "Amount of Meteors orbiting around the tower, instantly killing non-boss enemies.", string.format("Level: %d/%d", math.min(player.upgrades.science.meteorAmount.level, 6), 6), ["precedingUpgrade"] = player.upgrades.unlocks.meteor}, --Meteor Amount Science upgrade tooltip
            {965, 610, 254, 60, 260, 40, "How fast Meteors orbit around the tower.", string.format("Level: %d/%d", math.min(player.upgrades.science.meteorRPM.level, 40), 40), ["precedingUpgrade"] = player.upgrades.unlocks.meteor}, --Meteor RPM Science upgrade tooltip
            {1325, 610, 254, 60, 330, 40, "Chance to heal by some damage dealt to an enemy.", string.format("Level: %d/%d", math.min(player.upgrades.science.lifestealChance.level, 41), 41), ["precedingUpgrade"] = player.upgrades.unlocks.lifesteal}, --Lifesteal Chance Science upgrade tooltip
            {245, 680, 254, 60, 340, 40, "Percentage of damage healed upon lifesteal activation.", string.format("Level: %d/%d", math.min(player.upgrades.science.lifestealPercent.level, 76), 76), ["precedingUpgrade"] = player.upgrades.unlocks.lifesteal}, --Lifesteal Percentage Science upgrade tooltip

            {245, 840, 254, 60, 320, 40, "Amount of Copper earned at the end of each wave.", string.format("Level: %d/%s", player.upgrades.science.copperPerWave.level, math.huge), ["precedingUpgrade"] = true}, --Copper/wave Science upgrade tooltip
            {605, 840, 254, 60, 310, 40, "Amount of Silver earned at the end of each wave.", string.format("Level: %d/%s", player.upgrades.science.silverPerWave.level, math.huge), ["precedingUpgrade"] = true}, --Silver/wave Science upgrade tooltip
            {965, 840, 254, 60, 350, 40, "What incoming Copper from all sources is multiplied by.", string.format("Level: %d/%d", math.min(player.upgrades.science.copperBonus.level, 451), 451), ["precedingUpgrade"] = player.upgrades.unlocks.resourceBonus}, --Copper Bonus Science upgrade tooltip
            {1325, 840, 254, 60, 340, 40, "What incoming Silver from all sources is multiplied by.", string.format("Level: %d/%d", math.min(player.upgrades.science.silverBonus.level, 301), 301), ["precedingUpgrade"] = player.upgrades.unlocks.resourceBonus}, --Silver Bonus Science upgrade tooltip

        }
        function tooltips.displayScience()
            for i,v in ipairs(scienceTooltips) do
                if tooltips.hoverCheck(scienceTooltips[i][1], scienceTooltips[i][2], scienceTooltips[i][3], scienceTooltips[i][4]) and scienceTooltips[i]["precedingUpgrade"] then
                    tooltips.appearance(scienceTooltips[i][5], scienceTooltips[i][6], scienceTooltips[i][7], scienceTooltips[i][8])
                end
            end
        end

        local gameplayInfoTooltips = {
            {748, 330, 20, 20, 40, 19, "Basic"},
            {748, 370, 20, 20, 38, 19, "Tank"},
            {748, 410, 20, 20, 40, 19, "Swift"},
            {748, 450, 20, 20, 50, 19, "Sentry"},
            {748, 490, 20, 20, 68, 19, "Centurion"},
            {748, 530, 20, 20, 62, 19, "Exploder"}
        }

        function tooltips.displayGameplayInfo()
            for i,v in ipairs(gameplayInfoTooltips) do
                if tooltips.hoverCheck(gameplayInfoTooltips[i][1], gameplayInfoTooltips[i][2], gameplayInfoTooltips[i][3], gameplayInfoTooltips[i][4]) then
                    tooltips.appearance(gameplayInfoTooltips[i][5], gameplayInfoTooltips[i][6], gameplayInfoTooltips[i][7], gameplayInfoTooltips[i][8])
                end
            end
        end

        local abilityInfoTooltips = {
            {1040, 205, 24, 24, 390, 48, "Maximum amount of Abilities that can be equipped at once." .. ((player.abilities.maxEquipped + 1 < #equipSlotRequirements) and string.format("\n\nNext Ability slot unlocks after beating Wave %d of Difficulty %d.", equipSlotRequirements[player.abilities.maxEquipped + 1].wave, equipSlotRequirements[player.abilities.maxEquipped + 1].difficulty) or "\n\nAll Ability slots are unlocked!")},
            {810, 253, 204, 54, 215, 46, "Assembling an Ability takes somewhere between " .. string.format("%dm %ds", player.cooldowns.abilityAssembly_min / 60, player.cooldowns.abilityAssembly_min % 60) .. " and " .. string.format("%dm %ds", player.cooldowns.abilityAssembly_max / 60, player.cooldowns.abilityAssembly_max % 60) .. "."},
            {1110, 268, 24, 24, 150, 75, "Class Probabilities:\nD: 60%\nC: 25%\nB: 10%\nA: 5%"}
        }

        function tooltips.displayDiscordTooltip()
            if tooltips.hoverCheck(1710, 31, 80, 62) then
                tooltips.appearance(110, 20, "Join our Discord.")
            end
        end

        function tooltips.displayAbilityInfo()
            for i,v in ipairs(abilityInfoTooltips) do
                if tooltips.hoverCheck(abilityInfoTooltips[i][1], abilityInfoTooltips[i][2], abilityInfoTooltips[i][3], abilityInfoTooltips[i][4]) then
                    tooltips.appearance(abilityInfoTooltips[i][5], abilityInfoTooltips[i][6], abilityInfoTooltips[i][7], abilityInfoTooltips[i][8])
                end
            end
        end

        function tooltips.displayAbilityTags()
            for i,v in pairs(internalAbilities) do
                local freqSuffix = v.tags.condition == "Time" and "s" or (v.tags.condition == "Projectile Fired" or v.tags.condition == "Wave Start") and "%" or ""
                local rowOffset = freqSuffix ~= "" and -16 or 0
                if v.menu and tooltips.hoverCheck(1180, 414 + rowOffset, 24, 24) then
                    local totalTags = ""
                    local totalIncompatibilities = "{"
                    for j,w in pairs(v.tags) do
                        if j == "frequency" or j == "cooldown" or j == "chance" then
                            local addedSuffix = (j == "frequency") and " (guaranteed)" or (j == "cooldown") and "s" or "%"
                            totalTags = totalTags .. j .. ": " .. ((j == "frequency") and "1/" or "") .. w .. addedSuffix .. "\n"
                        elseif j ~= "incompatibilities" then
                            totalTags = totalTags .. j .. ": " .. tostring(w) .. "\n"
                        else
                            for k,x in pairs(w) do
                                totalIncompatibilities = totalIncompatibilities .. x .. (k == #w and "}" or ", ")
                            end
                            totalTags = totalTags .. "Incompatible with: " .. totalIncompatibilities .. "\n"
                        end
                    end
                    tooltips.appearance(250, font_Vera12:getHeight(totalTags) * table.len(v.tags) + 4, totalTags)
                end
            end
        end
    end
end