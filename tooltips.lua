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
            love.graphics.printf(desc2, mx + 4, my - height + 20, width, "left")
        end

        function tooltips.hoverCheck(x, y, width, height)
            if mx >= x and mx <= x + width and my >= y and my <= y + height then
                return true
            end
        end

        local roundTooltips = {
            ["ATK"] = {
                {10, 850, 254, 60, 180, 40, "Damage dealt by projectiles.", string.format("Level: %d/%s", player.upgrades.round.attackDamage.level, math.huge), ["precedingUpgrade"] = true}, --Attack Damage Round upgrade tooltip
                {10, 920, 254, 60, 230, 40, "Speed the tower fires projectiles at.", string.format("Level: %d/%d", math.min(player.upgrades.round.attackSpeed.level, 106), 106), ["precedingUpgrade"] = true}, --Attack Speed Round upgrade tooltip
                {10, 990, 254, 60, 280, 40, "Chance to deal increased projectile damage.", string.format("Level: %d/%d", math.min(player.upgrades.round.critChance.level, 101), 101), ["precedingUpgrade"] = player.upgrades.unlocks.crit}, --Critical Chance Round upgrade tooltip
                {370, 850, 254, 60, 400, 40, "How much the projectile damage is multiplied by on critical hits.", string.format("Level: %d/%s", player.upgrades.round.critFactor.level, math.huge), ["precedingUpgrade"] = player.upgrades.unlocks.crit}, --Critical Factor Round upgrade tooltip
                {370, 920, 254, 60, 240, 40, "Maximum enemy detection distance.", string.format("Level: %d/%d", math.min(player.upgrades.round.range.level, 81), 81), ["precedingUpgrade"] = player.upgrades.unlocks.range}, --Critical Factor Round upgrade tooltip
            },

            ["VIT"] = {
                {10, 850, 254, 60, 340, 40, "Maximum amount of true damage the tower can take.", string.format("Level: %d/%s", player.upgrades.round.health.level, math.huge), ["precedingUpgrade"] = true}, --Health Round upgrade tooltip
                {10, 920, 254, 60, 290, 40, "Speed the tower recovers its health over time.", string.format("Level: %d/%s", player.upgrades.round.regeneration.level, math.huge), ["precedingUpgrade"] = true}, --Regeneration Round upgrade tooltip
                {10, 990, 254, 60, 310, 40, "The percentage incoming damage is reduced by.", string.format("Level: %d/%d", math.min(player.upgrades.round.resistance.level, 121), 121), ["precedingUpgrade"] = player.upgrades.unlocks.resistance}, --Resistance Round upgrade tooltip
                {370, 850, 254, 60, 210, 40, "Time between Shield activations.", string.format("Level: %d/%d", math.min(player.upgrades.round.shieldCooldown.level, 126), 126), ["precedingUpgrade"] = player.upgrades.unlocks.shield}, --Shield Cooldown Round upgrade tooltip
                {370, 920, 254, 60, 340, 40, "How long the tower is immune to non-boss attacks for.", string.format("Level: %d/%d", math.min(player.upgrades.round.shieldDuration.level, 111), 111), ["precedingUpgrade"] = player.upgrades.unlocks.shield}, --Shield Duration Round upgrade tooltip
                {370, 990, 254, 60, 500, 40, "Amount of Meteors orbiting around the tower, instantly killing non-boss enemies.", string.format("Level: %d/%d", math.min(player.upgrades.round.meteorAmount.level, 6), 6), ["precedingUpgrade"] = player.upgrades.unlocks.meteor}, --Meteor Amount Round upgrade tooltip
                {730, 850, 254, 60, 260, 40, "How fast Meteors orbit around the tower.", string.format("Level: %d/%d", math.min(player.upgrades.round.meteorRPM.level, 40), 40), ["precedingUpgrade"] = player.upgrades.unlocks.meteor}, --Meteor RPM Round upgrade tooltip
            },

            ["UTL"] = {
                {10, 850, 254, 60, 320, 40, "Amount of Copper earned at the end of each wave.", string.format("Level: %d/%s", player.upgrades.round.copperPerWave.level, math.huge), ["precedingUpgrade"] = true}, --Copper/wave Round upgrade tooltip
                {10, 920, 254, 60, 310, 40, "Amount of Silver earned at the end of each wave.", string.format("Level: %d/%s", player.upgrades.round.silverPerWave.level, math.huge), ["precedingUpgrade"] = true}, --Silver/wave Round upgrade tooltip
                {10, 990, 254, 60, 350, 40, "What incoming Copper from all sources is multiplied by.", string.format("Level: %d/%d", math.min(player.upgrades.round.copperBonus.level, 451), 451), ["precedingUpgrade"] = player.upgrades.unlocks.resourceBonus}, --Copper Bonus Round upgrade tooltip
                {370, 850, 254, 60, 340, 40, "What incoming Silver from all sources is multiplied by.", string.format("Level: %d/%d", math.min(player.upgrades.round.silverBonus.level, 301), 301), ["precedingUpgrade"] = player.upgrades.unlocks.resourceBonus}, --Silver Bonus Round upgrade tooltip
            }
            
        }
        function tooltips.displayRound()
            for i,v in ipairs(roundTooltips[roundUpgradeSection]) do
                if tooltips.hoverCheck(roundTooltips[roundUpgradeSection][i][1], roundTooltips[roundUpgradeSection][i][2], roundTooltips[roundUpgradeSection][i][3], roundTooltips[roundUpgradeSection][i][4]) and roundTooltips[roundUpgradeSection][i]["precedingUpgrade"] then
                    tooltips.appearance(roundTooltips[roundUpgradeSection][i][5], roundTooltips[roundUpgradeSection][i][6], roundTooltips[roundUpgradeSection][i][7], roundTooltips[roundUpgradeSection][i][8])
                end
            end
        end

        local hubTooltips = {
            {245, 240, 254, 60, 180, 40, "Damage dealt by projectiles.", string.format("Level: %d/%s", player.upgrades.science.attackDamage.level, math.huge), ["precedingUpgrade"] = true}, --Attack Damage Hub upgrade tooltip
            {605, 240, 254, 60, 230, 40, "Speed the tower fires projectiles at.", string.format("Level: %d/%d", math.min(player.upgrades.science.attackSpeed.level, 106), 106), ["precedingUpgrade"] = true}, --Attack Speed Science upgrade tooltip
            {965, 240, 254, 60, 280, 40, "Chance to deal increased projectile damage.", string.format("Level: %d/%d", math.min(player.upgrades.science.critChance.level, 101), 101), ["precedingUpgrade"] = player.upgrades.unlocks.crit}, --Critical Chance Science upgrade tooltip
            {1325, 240, 254, 60, 400, 40, "How much the projectile damage is multiplied by on critical hits.", string.format("Level: %d/%s", player.upgrades.science.critFactor.level, math.huge), ["precedingUpgrade"] = player.upgrades.unlocks.crit}, --Critical Factor Science upgrade tooltip
            {245, 310, 254, 60, 240, 40, "Maximum enemy detection distance.", string.format("Level: %d/%d", math.min(player.upgrades.science.range.level, 81), 81), ["precedingUpgrade"] = player.upgrades.unlocks.range}, --Critical Factor Science upgrade tooltip
            
            {245, 540, 254, 60, 340, 40, "Maximum amount of true damage the tower can take.", string.format("Level: %d/%s", player.upgrades.science.health.level, math.huge), ["precedingUpgrade"] = true}, --Health Science upgrade tooltip
            {605, 540, 254, 60, 290, 40, "Speed the tower recovers its health over time.", string.format("Level: %d/%s", player.upgrades.science.regeneration.level, math.huge), ["precedingUpgrade"] = true}, --Regeneration Science upgrade tooltip
            {965, 540, 254, 60, 310, 40, "The percentage incoming damage is reduced by.", string.format("Level: %d/%d", math.min(player.upgrades.science.resistance.level, 121), 121), ["precedingUpgrade"] = player.upgrades.unlocks.resistance}, --Resistance Science upgrade tooltip
            {1325, 540, 254, 60, 210, 40, "Time between Shield activations.", string.format("Level: %d/%d", math.min(player.upgrades.science.shieldCooldown.level, 126), 126), ["precedingUpgrade"] = player.upgrades.unlocks.shield}, --Shield Cooldown Science upgrade tooltip
            {245, 610, 254, 60, 340, 40, "How long the tower is immune to non-boss attacks for.", string.format("Level: %d/%d", math.min(player.upgrades.science.shieldDuration.level, 111), 111), ["precedingUpgrade"] = player.upgrades.unlocks.shield}, --Shield Duration Science upgrade tooltip
            {605, 610, 254, 60, 500, 40, "Amount of Meteors orbiting around the tower, instantly killing non-boss enemies.", string.format("Level: %d/%d", math.min(player.upgrades.science.meteorAmount.level, 6), 6), ["precedingUpgrade"] = player.upgrades.unlocks.meteor}, --Meteor Amount Science upgrade tooltip
            {965, 610, 254, 60, 260, 40, "How fast Meteors orbit around the tower.", string.format("Level: %d/%d", math.min(player.upgrades.science.meteorRPM.level, 40), 40), ["precedingUpgrade"] = player.upgrades.unlocks.meteor}, --Meteor RPM Science upgrade tooltip

            {245, 840, 254, 60, 320, 40, "Amount of Copper earned at the end of each wave.", string.format("Level: %d/%s", player.upgrades.science.copperPerWave.level, math.huge), ["precedingUpgrade"] = true}, --Copper/wave Science upgrade tooltip
            {605, 840, 254, 60, 310, 40, "Amount of Silver earned at the end of each wave.", string.format("Level: %d/%s", player.upgrades.science.silverPerWave.level, math.huge), ["precedingUpgrade"] = true}, --Silver/wave Science upgrade tooltip
            {965, 840, 254, 60, 350, 40, "What incoming Copper from all sources is multiplied by.", string.format("Level: %d/%d", math.min(player.upgrades.science.copperBonus.level, 451), 451), ["precedingUpgrade"] = player.upgrades.unlocks.resourceBonus}, --Copper Bonus Science upgrade tooltip
            {1325, 840, 254, 60, 340, 40, "What incoming Silver from all sources is multiplied by.", string.format("Level: %d/%d", math.min(player.upgrades.science.silverBonus.level, 301), 301), ["precedingUpgrade"] = player.upgrades.unlocks.resourceBonus}, --Silver Bonus Science upgrade tooltip

        }
        function tooltips.displayHub()
            for i,v in ipairs(hubTooltips) do
                if tooltips.hoverCheck(hubTooltips[i][1], hubTooltips[i][2], hubTooltips[i][3], hubTooltips[i][4]) and hubTooltips[i]["precedingUpgrade"] then
                    tooltips.appearance(hubTooltips[i][5], hubTooltips[i][6], hubTooltips[i][7], hubTooltips[i][8])
                end
            end
        end
    end
end