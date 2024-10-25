tooltips = {}

function tooltips.general()
    if settings_tooltips then
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

        function tooltips.displayRound()
            if roundUpgradeSection == "ATK" then
                if tooltips.hoverCheck(10, 850, 254, 60) then
                    tooltips.appearance(180, 40, "Damage dealt by projectiles.", string.format("Level: %d/%s", upgrade_round_attack_damage_level, math.huge))
                elseif tooltips.hoverCheck(10, 920, 254, 60) then
                    tooltips.appearance(230, 40, "Speed the tower fires projectiles at.", string.format("Level: %d/%d", math.min(upgrade_round_attack_speed_level, 101), 101))
                elseif tooltips.hoverCheck(10, 990, 254, 60) and upgrade_unlock_crit then
                    tooltips.appearance(280, 40, "Chance to deal increased projectile damage.", string.format("Level: %d/%d", math.min(upgrade_round_critChance_level, 101), 101))
                elseif tooltips.hoverCheck(370, 850, 254, 60) and upgrade_unlock_crit then
                    tooltips.appearance(400, 40, "How much the projectile damage is multiplied by on critical hits.", string.format("Level: %d/%s", upgrade_round_critFactor_level, math.huge))
                elseif tooltips.hoverCheck(370, 920, 254, 60) and upgrade_unlock_crit and upgrade_unlock_range then
                    tooltips.appearance(240, 40, "Maximum enemy detection distance.", string.format("Level: %d/%d", math.min(upgrade_round_range_level, 121), 121))
                end
            elseif roundUpgradeSection == "VIT" then
                if tooltips.hoverCheck(10, 850, 254, 60) then
                    tooltips.appearance(340, 40, "Maximum amount of true damage the tower can take.", string.format("Level: %d/%s", upgrade_round_health_level, math.huge))
                elseif tooltips.hoverCheck(10, 920, 254, 60) then
                    tooltips.appearance(290, 40, "Speed the tower recovers its health over time.", string.format("Level: %d/%s", upgrade_round_regeneration_level, math.huge))
                elseif tooltips.hoverCheck(10, 990, 254, 60) and upgrade_unlock_resistance then
                    tooltips.appearance(310, 40, "The percentage incoming damage is reduced by.", string.format("Level: %d/%d", math.min(upgrade_round_resistance_level, 121), 121))
                elseif tooltips.hoverCheck(370, 850, 254, 60) and upgrade_unlock_resistance and upgrade_unlock_shield then
                    tooltips.appearance(210, 40, "Time between Shield activations.", string.format("Level: %d/%d", math.min(upgrade_round_shieldCooldown_level, 126), 126))
                elseif tooltips.hoverCheck(370, 920, 254, 60) and upgrade_unlock_resistance and upgrade_unlock_shield then
                    tooltips.appearance(340, 40, "How long the tower is immune to non-boss attacks for.", string.format("Level: %d/%d", math.min(upgrade_round_shieldDuration_level, 111), 111))
                elseif tooltips.hoverCheck(370, 990, 254, 60) and upgrade_unlock_resistance and upgrade_unlock_shield and upgrade_unlock_meteor then
                    tooltips.appearance(500, 40, "Amount of Meteors orbiting around the tower, instantly killing non-boss enemies.", string.format("Level: %d/%d", math.min(upgrade_round_meteor_amount_level, 6), 6))
                elseif tooltips.hoverCheck(730, 850, 254, 60) and upgrade_unlock_resistance and upgrade_unlock_shield and upgrade_unlock_meteor then
                    tooltips.appearance(260, 40, "How fast Meteors orbit around the tower.", string.format("Level: %d/%d", math.min(upgrade_round_meteor_RPM_level, 40), 40))
                end
            elseif roundUpgradeSection == "UTL" then
                if tooltips.hoverCheck(10, 850, 254, 60) then
                    tooltips.appearance(320, 40, "Amount of Copper earned at the end of each wave.", string.format("Level: %d/%s", upgrade_round_copperPerWave_level, math.huge))
                elseif tooltips.hoverCheck(10, 920, 254, 60) then
                    tooltips.appearance(310, 40, "Amount of Silver earned at the end of each wave.", string.format("Level: %d/%s", upgrade_round_silverPerWave_level, math.huge))
                elseif tooltips.hoverCheck(10, 990, 254, 60) and upgrade_unlock_resourceBonus then
                    tooltips.appearance(350, 40, "What incoming Copper from all sources is multiplied by.", string.format("Level: %d/%d", math.min(upgrade_round_copperBonus_level, 451), 451))
                elseif tooltips.hoverCheck(370, 850, 254, 60) and upgrade_unlock_resourceBonus then
                    tooltips.appearance(340, 40, "What incoming Silver from all sources is multiplied by.", string.format("Level: %d/%d", math.min(upgrade_round_silverBonus_level, 301), 301))
                end
            end
        end

        function tooltips.displayHub()
            if tooltips.hoverCheck(245, 240, 254, 60) then
                tooltips.appearance(180, 40, "Damage dealt by projectiles.", string.format("Level: %d/%s", upgrade_science_attack_damage_level, math.huge))
            elseif tooltips.hoverCheck(605, 240, 254, 60) then
                tooltips.appearance(230, 40, "Speed the tower fires projectiles at.", string.format("Level: %d/%d", math.min(upgrade_science_attack_speed_level, 101), 101))
            elseif tooltips.hoverCheck(965, 240, 254, 60) and upgrade_unlock_crit then
                tooltips.appearance(280, 40, "Chance to deal increased projectile damage.", string.format("Level: %d/%d", math.min(upgrade_science_critChance_level, 101), 101))
            elseif tooltips.hoverCheck(1325, 240, 254, 60) and upgrade_unlock_crit then
                tooltips.appearance(400, 40, "How much the projectile damage is multiplied by on critical hits.", string.format("Level: %d/%s", upgrade_science_critFactor_level, math.huge))
            elseif tooltips.hoverCheck(245, 310, 254, 60) and upgrade_unlock_crit and upgrade_unlock_range then
                tooltips.appearance(240, 40, "Maximum enemy detection distance.", string.format("Level: %d/%d", math.min(upgrade_science_range_level, 61), 61))
            
            elseif tooltips.hoverCheck(245, 540, 254, 60) then
                tooltips.appearance(340, 40, "Maximum amount of true damage the tower can take.", string.format("Level: %d/%s", upgrade_science_health_level, math.huge))
            elseif tooltips.hoverCheck(605, 540, 254, 60) then
                tooltips.appearance(290, 40, "Speed the tower recovers its health over time.", string.format("Level: %d/%s", upgrade_science_regeneration_level, math.huge))
            elseif tooltips.hoverCheck(965, 540, 254, 60) and upgrade_unlock_resistance then
                tooltips.appearance(310, 40, "The percentage incoming damage is reduced by.", string.format("Level: %d/%d", math.min(upgrade_science_resistance_level, 121), 121))
            elseif tooltips.hoverCheck(1325, 540, 254, 60) and upgrade_unlock_resistance and upgrade_unlock_shield then
                tooltips.appearance(210, 40, "Time between Shield activations.", string.format("Level: %d/%d", math.min(upgrade_science_shieldCooldown_level, 126), 126))
            elseif tooltips.hoverCheck(245, 610, 254, 60) and upgrade_unlock_resistance and upgrade_unlock_shield then
                tooltips.appearance(340, 40, "How long the tower is immune to non-boss attacks for.", string.format("Level: %d/%d", math.min(upgrade_science_shieldDuration_level, 111), 111))
            elseif tooltips.hoverCheck(605, 610, 254, 60) and upgrade_unlock_resistance and upgrade_unlock_shield and upgrade_unlock_meteor then
                tooltips.appearance(500, 40, "Amount of Meteors orbiting around the tower, instantly killing non-boss enemies.", string.format("Level: %d/%d", math.min(upgrade_science_meteor_amount_level, 6), 6))
            elseif tooltips.hoverCheck(965, 610, 254, 60) and upgrade_unlock_resistance and upgrade_unlock_shield and upgrade_unlock_meteor then
                tooltips.appearance(260, 40, "How fast Meteors orbit around the tower.", string.format("Level: %d/%d", math.min(upgrade_science_meteor_RPM_level, 40), 40))
            
            elseif tooltips.hoverCheck(245, 840, 254, 60) then
                tooltips.appearance(320, 40, "Amount of Copper earned at the end of each wave.", string.format("Level: %d/%s", upgrade_science_copperPerWave_level, math.huge))
            elseif tooltips.hoverCheck(605, 840, 254, 60) then
                tooltips.appearance(310, 40, "Amount of Silver earned at the end of each wave.", string.format("Level: %d/%s", upgrade_science_silverPerWave_level, math.huge))
            elseif tooltips.hoverCheck(965, 840, 254, 60) and upgrade_unlock_resourceBonus then
                tooltips.appearance(350, 40, "What incoming Copper from all sources is multiplied by.", string.format("Level: %d/%d", math.min(upgrade_science_copperBonus_level, 451), 451))
            elseif tooltips.hoverCheck(1325, 840, 254, 60) and upgrade_unlock_resourceBonus then
                tooltips.appearance(340, 40, "What incoming Silver from all sources is multiplied by.", string.format("Level: %d/%d", math.min(upgrade_science_silverBonus_level, 301), 301))
            end
        end
    end
end