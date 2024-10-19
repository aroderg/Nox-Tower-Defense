function drawUpgradeMenu()
    if upgradeMenu then
        love.graphics.setLineStyle("smooth")
        love.graphics.setLineWidth(3)
        love.graphics.setColor(0.106, 0.11, 0.22, 1)
        love.graphics.rectangle("fill", 860, 750, 200, 52)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.rectangle("line", 860, 750, 200, 52, 2, 2)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf("Upgrades", 860, 767, 200, "center")
        love.graphics.setLineStyle("rough")
        love.graphics.setLineWidth(1)
        love.graphics.setColor(0, 0, 0, 0.8)
        love.graphics.rectangle("fill", 0, 800, 1920, 280)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setFont(font_VeraBold24)
        love.graphics.print("Upgrades", 10, 810)
        love.graphics.setFont(font_Afacad24)

        if roundUpgradeSection == "ATK" then
            love.graphics.setColor(1, 0, 0, 1)
        end
        love.graphics.setLineStyle("smooth")
        love.graphics.rectangle("line", 1789, 801, 100, 40, 4, 4)
        love.graphics.printf("ATK", 1789, 803, 100, "center")
        love.graphics.setColor(0.8, 0.35, 0, 1)
        love.graphics.rectangle("fill", 1890, 800, 30, 93)
        love.graphics.setColor(1, 1, 1, 1)

        if roundUpgradeSection == "VIT" then
            love.graphics.setColor(1, 0, 0, 1)
        end
        love.graphics.setLineStyle("smooth")
        love.graphics.rectangle("line", 1789, 894, 100, 40, 4, 4)
        love.graphics.printf("VIT", 1789, 896, 100, "center")
        love.graphics.setColor(0, 0.7, 0.8, 1)
        love.graphics.rectangle("fill", 1890, 893, 30, 93)
        love.graphics.setColor(1, 1, 1, 1)

        if roundUpgradeSection == "UTL" then
            love.graphics.setColor(1, 0, 0, 1)
        end
        love.graphics.setLineStyle("smooth")
        love.graphics.rectangle("line", 1789, 987, 100, 40, 4, 4)
        love.graphics.printf("UTL", 1789, 989, 100, "center")
        love.graphics.setColor(0, 0.8, 0.4, 1)
        love.graphics.rectangle("fill", 1890, 986, 30, 93)

        love.graphics.setLineStyle("rough")
        if roundUpgradeSection == "ATK" then
            love.graphics.setColor(0.8, 0.35, 0, 1)
            love.graphics.setFont(font_VeraBold18)
            love.graphics.print("(ATK)", 145, 816)

            --[[ Attack Damage upgrade ]]--
            drawUpgradeModule("Damage", 10, 850, tower_value_attack_damage, upgrade_round_attack_damage_cost, upgrade_round_attack_damage_cost, "round", math.huge, "precise", nil, nil)

            --[[ Attack Speed upgrade ]]--
            drawUpgradeModule("Attack Speed", 10, 920, tower_value_attack_speed, upgrade_round_attack_speed_cost, upgrade_round_attack_speed_level, "round", 101, "precise2", nil, nil)

            if upgrade_unlock_crit then
                --[[ Crit Chance upgrade ]]--
                drawUpgradeModule("Critical Chance", 10, 990, tower_value_critical_chance, upgrade_round_critChance_cost, upgrade_round_critChance_level, "round", 101, "precise", nil, "%")

                --[[ Crit Factor upgrade ]]--
                drawUpgradeModule("Critical Factor", 330, 850, tower_value_critical_factor, upgrade_round_critFactor_cost, upgrade_round_critFactor_level, "round", math.huge, "precise2", "x", nil)
            end

            if upgrade_unlock_crit and upgrade_unlock_range then
                --[[ Range upgrade ]]--
                drawUpgradeModule("Range", 330, 920, tower_value_range, upgrade_round_range_cost, upgrade_round_range_level, "round", 41, "brief", nil, nil)
            end
        elseif roundUpgradeSection == "VIT" then
            love.graphics.setColor(0, 0.7, 0.8, 1)
            love.graphics.setFont(font_VeraBold18)
            love.graphics.print("(VIT)", 145, 816)

            --[[ Health upgrade ]]--
            drawUpgradeModule("Health", 10, 850, tower_value_maxHealth, upgrade_round_health_cost, upgrade_round_health_level, "round", math.huge, "precise", nil, nil)

            --[[ Regeneration upgrade ]]--
            drawUpgradeModule("Regeneration", 10, 920, tower_value_healthRegen, upgrade_round_regeneration_cost, upgrade_round_regeneration_level, "round", math.huge, "precise2", nil, "/s")

            if upgrade_unlock_resistance then
                --[[ Resistance upgrade ]]--
                drawUpgradeModule("Resistance", 10, 990, tower_value_resistance, upgrade_round_resistance_cost, upgrade_round_resistance_level, "round", 201, "precise", nil, "%")
            end

            if upgrade_unlock_resistance and upgrade_unlock_shield then
                --[[ Shield Cooldown upgrade ]]--
                drawUpgradeModule("Shield Cooldown", 330, 850, tower_value_shield_cooldown, upgrade_round_shieldCooldown_cost, upgrade_round_shieldCooldown_level, "round", 126, "precise", nil, "s")

                --[[ Shield Duration upgrade ]]--
                drawUpgradeModule("Shield Duration", 330, 920, tower_value_shield_duration, upgrade_round_shieldDuration_cost, upgrade_round_shieldDuration_level, "round", 111, "precise2", nil, "s")

            end

            if upgrade_unlock_resistance and upgrade_unlock_shield and upgrade_unlock_meteor then
                
                --[[ Meteor Amount upgrade ]]--
                drawUpgradeModule("Meteor Amount", 330, 990, tower_value_meteor_amount, upgrade_round_meteor_amount_cost, upgrade_round_meteor_amount_level, "round", 6, "brief", nil, nil)

                --[[ Meteor RPM upgrade ]]--
                drawUpgradeModule("Meteor RPM", 650, 850, tower_value_meteor_RPM, upgrade_round_meteor_RPM_cost, upgrade_round_meteor_RPM_level, "round", 40, "precise2", nil, nil)
            end

        elseif roundUpgradeSection == "UTL" then
            love.graphics.setColor(0, 0.8, 0.4, 1)
            love.graphics.setFont(font_VeraBold18)
            love.graphics.print("(UTL)", 145, 816)

            --[[ Copper/wave upgrade ]]--
            drawUpgradeModule("Copper/wave", 10, 850, gameplay_copperPerWave, upgrade_round_copperPerWave_cost, upgrade_round_copperPerWave_level, "round", math.huge, "brief", nil, nil)

            --[[ Silver/wave upgrade ]]--
            drawUpgradeModule("Silver/wave", 10, 920, gameplay_silverPerWave, upgrade_round_silverPerWave_cost, upgrade_round_silverPerWave_level, "round", math.huge, "brief", nil, nil)

            if upgrade_unlock_resourceBonus then

                --[[ Copper Bonus upgrade ]]--
                drawUpgradeModule("Copper Bonus", 10, 990, gameplay_copperBonus, upgrade_round_copperBonus_cost, upgrade_round_copperBonus_level, "round", 451, "precise2", "x", nil)

                --[[ Silver Bonus upgrade ]]--
                drawUpgradeModule("Silver Bonus", 330, 850, gameplay_silverBonus, upgrade_round_silverBonus_cost, upgrade_round_silverBonus_level, "round", 301, "precise2", "x", nil)

            end
        end

        love.graphics.setColor(1, 1, 1, 1)
    else
        love.graphics.setLineStyle("smooth")
        love.graphics.setLineWidth(3)
        love.graphics.setColor(0.106, 0.11, 0.22, 1)
        love.graphics.rectangle("fill", 860, 1030, 200, 52)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.rectangle("line", 860, 1030, 200, 52, 2, 2)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf("Upgrades", 860, 1047, 200, "center")
        love.graphics.setLineStyle("rough")
        love.graphics.setLineWidth(1)
    end
end

function upgradeMenu_mouse(x, y)
    if upgradeMenu then
        if roundUpgradeSection == "ATK" then
            --[[ Attack Damage ]]--
            if x >= 227 and x <= 307 and y >= 853 and y <= 907 then
                if currentCopper >= upgrade_round_attack_damage_cost then
                    currentCopper = currentCopper - upgrade_round_attack_damage_cost
                    upgrade_round_attack_damage_level = upgrade_round_attack_damage_level + 1
                    upgrade_round_attack_damage_cost = math.floor((0.2 * ((upgrade_round_attack_damage_level - upgrade_science_attack_damage_level + 1)^2) + 0.4 * (upgrade_round_attack_damage_level - upgrade_science_attack_damage_level + 1) + 0.4) / ((upgrade_round_attack_damage_level - upgrade_science_attack_damage_level + 1)^0.2) + 1)
                    tower_value_attack_damage = ((0.2 * upgrade_round_attack_damage_level - 0.2)^2.75 + 2.2 + upgrade_round_attack_damage_level) * upgrade_nexus_attack_damage_buff
                end
            end

            --[[ Attack Speed ]]--
            if x >= 227 and x <= 307 and y >= 923 and y <= 977 then
                if currentCopper >= upgrade_round_attack_speed_cost and upgrade_round_attack_speed_level < 101 then
                    currentCopper = currentCopper - upgrade_round_attack_speed_cost
                    upgrade_round_attack_speed_level = upgrade_round_attack_speed_level + 1
                    upgrade_round_attack_speed_cost = math.floor(5 * ((upgrade_round_attack_speed_level - upgrade_science_attack_speed_level + 1)^math.log(((upgrade_round_attack_speed_level - upgrade_science_attack_speed_level + 1) + 10) / 10)))
                    tower_value_attack_speed = (math.min(0.5 + 0.04 * (upgrade_round_attack_speed_level - 1), 4.5)) * upgrade_nexus_attack_speed_buff
                end
            end

            if upgrade_unlock_crit then
                --[[ Crit Chance ]]--
                if x >= 227 and x <= 307 and y >= 993 and y <= 1047 then
                    if currentCopper >= upgrade_round_critChance_cost and upgrade_round_critChance_level < 101 then
                        currentCopper = currentCopper - upgrade_round_critChance_cost
                        upgrade_round_critChance_level = upgrade_round_critChance_level + 1
                        upgrade_round_critChance_cost = math.floor(((upgrade_round_critChance_level - upgrade_science_critChance_level) / 2)^2 + 5.75)
                        tower_value_critical_chance = math.min((upgrade_round_critChance_level - 1) / 2, 50)
                    end
                end

                --[[ Crit Factor ]]--
                if x >= 547 and x <= 627 and y >= 853 and y <= 907 then
                    if currentCopper >= upgrade_round_critFactor_cost then
                        currentCopper = currentCopper - upgrade_round_critFactor_cost
                        upgrade_round_critFactor_level = upgrade_round_critFactor_level + 1
                        upgrade_round_critFactor_cost = math.floor(0.1 * ((upgrade_round_critFactor_level - upgrade_science_critFactor_level)^2) + (upgrade_round_critFactor_level - upgrade_science_critFactor_level) + 0.9)
                        tower_value_critical_factor = 1 + ((upgrade_round_critFactor_level - 1) / 20)
                    end
                end
            end

            if upgrade_unlock_crit and upgrade_unlock_range then
                --[[ Range ]]--
                if x >= 547 and x <= 627 and y >= 923 and y <= 977 then
                    if currentCopper >= upgrade_round_range_cost and upgrade_round_range_level < 41 then
                        currentCopper = currentCopper - upgrade_round_range_cost
                        upgrade_round_range_level = upgrade_round_range_level + 1
                        upgrade_round_range_cost = math.floor(((upgrade_round_range_level - upgrade_science_range_level)^2 + 5 * (upgrade_round_range_level - upgrade_science_range_level)) / 6 + 2 * (upgrade_round_range_level - upgrade_science_range_level) + 5/3)
                        tower_value_range = math.min(240 + 3 * (upgrade_round_range_level - 1), 360)
                    end
                end
            end
        
        elseif roundUpgradeSection == "VIT" then
            --[[ Health ]]--
            if x >= 227 and x <= 307 and y >= 853 and y <= 907 then
                if currentCopper >= upgrade_round_health_cost then
                    currentCopper = currentCopper - upgrade_round_health_cost
                    upgrade_round_health_level = upgrade_round_health_level + 1
                    upgrade_round_health_cost = math.floor((0.2 * ((upgrade_round_health_level - upgrade_science_health_level + 1)^2) + 0.4 * (upgrade_round_health_level - upgrade_science_health_level + 1) + 0.4) / ((upgrade_round_health_level - upgrade_science_health_level + 1)^(1/6)) + 1.95)
                    local hpPercentage = tower_value_currentHealth / tower_value_maxHealth
                    tower_value_maxHealth = ((0.2 * upgrade_round_health_level - 0.2)^3.75 + 4 + upgrade_round_health_level) * upgrade_nexus_health_buff
                    tower_value_currentHealth = tower_value_maxHealth * hpPercentage
                end
            end

            --[[ Health Regeneration ]]--
            if x >= 227 and x <= 307 and y >= 923 and y <= 977 then
                if currentCopper >= upgrade_round_regeneration_cost then
                    currentCopper = currentCopper - upgrade_round_regeneration_cost
                    upgrade_round_regeneration_level = upgrade_round_regeneration_level + 1
                    upgrade_round_regeneration_cost = math.floor((upgrade_round_regeneration_level - upgrade_science_regeneration_level + 1)^1.5 + 3)
                    tower_value_healthRegen = (((2 * upgrade_round_regeneration_level + 1)^2) / 50 - 0.18) * upgrade_nexus_regeneration_buff
                end
            end

            if upgrade_unlock_resistance then
                --[[ Resistance ]]--
                if x >= 227 and x <= 307 and y >= 993 and y <= 1047 then
                    if currentCopper >= upgrade_round_resistance_cost and upgrade_round_resistance_level < 201 then
                        currentCopper = currentCopper - upgrade_round_resistance_cost
                        upgrade_round_resistance_level = upgrade_round_resistance_level + 1
                        upgrade_round_resistance_cost = math.floor((upgrade_round_resistance_level - upgrade_science_resistance_level) * math.sqrt(upgrade_round_resistance_level - upgrade_science_resistance_level) + 4)
                        tower_value_resistance = math.min(0.4 * (upgrade_round_resistance_level - 1), 80)
                    end
                end
            end

            if upgrade_unlock_resistance and upgrade_unlock_shield then
                --[[ Shield Cooldown ]]--
                if x >= 547 and x <= 627 and y >= 853 and y <= 907 then
                    if currentCopper >= upgrade_round_shieldCooldown_cost and upgrade_round_shieldCooldown_level < 116 then
                        currentCopper = currentCopper - upgrade_round_shieldCooldown_cost
                        upgrade_round_shieldCooldown_level = upgrade_round_shieldCooldown_level + 1
                        upgrade_round_shieldCooldown_cost = math.floor((upgrade_round_shieldCooldown_level - upgrade_science_shieldCooldown_level)^(math.log(upgrade_round_shieldCooldown_level - upgrade_science_shieldCooldown_level, 10) / 1.2) + 3)
                        tower_value_shield_cooldown = math.max(120 - 0.6 * (upgrade_round_shieldCooldown_level - 1), 45)
                    end
                end
                --[[ Shield Duration ]]--
                if x >= 547 and x <= 627 and y >= 923 and y <= 977 then
                    if currentCopper >= upgrade_round_shieldDuration_cost and upgrade_round_shieldDuration_level < 111 then
                        currentCopper = currentCopper - upgrade_round_shieldDuration_cost
                        upgrade_round_shieldDuration_level = upgrade_round_shieldDuration_level + 1
                        upgrade_round_shieldDuration_cost = math.floor((upgrade_round_shieldDuration_level - upgrade_science_shieldDuration_level)^(math.log(upgrade_round_shieldDuration_level - upgrade_science_shieldDuration_level) / 2.5) + 2)
                        tower_value_shield_duration = math.min(0.05 * (upgrade_round_shieldDuration_level - 1) + 0.5, 6)
                    end
                end
            end

            if upgrade_unlock_resistance and upgrade_unlock_shield and upgrade_unlock_meteor then
                --[[ Meteor Amount ]]--
                if x >= 547 and x <= 627 and y >= 993 and y <= 1047 then
                    if currentCopper >= upgrade_round_meteor_amount_cost and upgrade_round_meteor_amount_level < 6 then
                        currentCopper = currentCopper - upgrade_round_meteor_amount_cost
                        upgrade_round_meteor_amount_level = upgrade_round_meteor_amount_level + 1
                        upgrade_round_meteor_amount_cost = math.floor((12 * ((upgrade_round_meteor_amount_level - upgrade_science_meteor_amount_level) + 1))^2 + 56)
                        tower_value_meteor_amount = math.min(upgrade_round_meteor_amount_level - 1, 5)
                        local offset = 0
                        if tower_value_meteor_amount > 1 then
                            offset = -1/2 * math.pi + meteors[1].angle
                        end
                        meteorInitialAngles = {(0 * (2 * math.pi) / tower_value_meteor_amount) - 0.5 * math.pi,
                            (1 * (2 * math.pi) / tower_value_meteor_amount) - 0.5 * math.pi,
                            (2 * (2 * math.pi) / tower_value_meteor_amount) - 0.5 * math.pi,
                            (3 * (2 * math.pi) / tower_value_meteor_amount) - 0.5 * math.pi,
                            (4 * (2 * math.pi) / tower_value_meteor_amount) - 0.5 * math.pi
                        }
                        meteors = {}
                        for i=1,tower_value_meteor_amount do
                            createMeteor(meteorInitialAngles[i] + offset)
                        end
                    end
                end
                --[[ Meteor RPM ]]--
                if x >= 867 and x <= 947 and y >= 853 and y <= 907 then
                    if currentCopper >= upgrade_round_meteor_RPM_cost and upgrade_round_meteor_RPM_level < 40 then
                        currentCopper = currentCopper - upgrade_round_meteor_RPM_cost
                        upgrade_round_meteor_RPM_level = upgrade_round_meteor_RPM_level + 1
                        upgrade_round_meteor_RPM_cost = math.floor(4 * ((upgrade_round_meteor_RPM_level - upgrade_science_meteor_RPM_level)^2) + 16)
                        tower_value_meteor_RPM = math.min(0.15 * upgrade_round_meteor_RPM_level + 0.25, 6.25)
                    end
                end
            end

        elseif roundUpgradeSection == "UTL" then
            --[[ Copper/wave ]]--
            if x >= 227 and x <= 307 and y >= 853 and y <= 907 then
                if currentCopper >= upgrade_round_copperPerWave_cost then
                    currentCopper = currentCopper - upgrade_round_copperPerWave_cost
                    upgrade_round_copperPerWave_level = upgrade_round_copperPerWave_level + 1
                    upgrade_round_copperPerWave_cost = math.floor((upgrade_round_copperPerWave_level - upgrade_science_copperPerWave_level + 1) * ((upgrade_round_copperPerWave_level - upgrade_science_copperPerWave_level + 1) + 1) / 2 + 9)
                    gameplay_copperPerWave = 4 * (upgrade_round_copperPerWave_level - 1)
                end
            end

            --[[ Silver/wave ]]--
            if x >= 227 and x <= 307 and y >= 923 and y <= 977 then
                if currentCopper >= upgrade_round_silverPerWave_cost then
                    currentCopper = currentCopper - upgrade_round_silverPerWave_cost
                    upgrade_round_silverPerWave_level = upgrade_round_silverPerWave_level + 1
                    upgrade_round_silverPerWave_cost = math.floor(((upgrade_round_silverPerWave_level - upgrade_science_silverPerWave_level + 1) + 2)^2 + 1)
                    gameplay_silverPerWave = 3 * (upgrade_round_silverPerWave_level - 1)
                end
            end

            if upgrade_unlock_resourceBonus then

                --[[ Copper Bonus ]]--
                if x >= 227 and x <= 307 and y >= 993 and y <= 1047 then
                    if currentCopper >= upgrade_round_copperBonus_cost and upgrade_round_copperBonus_level < 451 then
                        currentCopper = currentCopper - upgrade_round_copperBonus_cost
                        upgrade_round_copperBonus_level = upgrade_round_copperBonus_level + 1
                        upgrade_round_copperBonus_cost = math.floor((0.2 * (upgrade_round_copperBonus_level - upgrade_science_copperBonus_level))^2 + 2 * (upgrade_round_copperBonus_level - upgrade_science_copperBonus_level) + 3.96)
                        gameplay_copperBonus = math.min(1 + 0.02 * (upgrade_round_copperBonus_level - 1), 10)
                    end
                end

                --[[ Silver Bonus ]]--
                if x >= 547 and x <= 627 and y >= 853 and y <= 907 then
                    if currentCopper >= upgrade_round_silverBonus_cost and upgrade_round_silverBonus_level < 301 then
                        currentCopper = currentCopper - upgrade_round_silverBonus_cost
                        upgrade_round_silverBonus_level = upgrade_round_silverBonus_level + 1
                        upgrade_round_silverBonus_cost = (0.4 * (upgrade_round_silverBonus_level - upgrade_science_silverBonus_level)^1.6 + 6.6)
                        gameplay_silverBonus = math.min(1 + 0.01 * (upgrade_round_silverBonus_level - 1), 4)
                    end
                end
            end
        end

        if x >= 1890 and x <= 1920 and y >= 800 and y <= 893 then
            roundUpgradeSection = "ATK"
        elseif x >= 1890 and x <= 1920 and y >= 893 and y <= 986 then
            roundUpgradeSection = "VIT"
        elseif x >= 1890 and x <= 1920 and y >= 986 and y <= 1079 then
            roundUpgradeSection = "UTL"
        end
    end
end