function inHub_visual()
    if inHub then
        love.graphics.setLineWidth(1)
        love.graphics.setFont(font_Afacad24)
        love.graphics.setLineStyle("smooth")
        love.graphics.setColor(0, 0, 0.2, 1)
        love.graphics.rectangle("fill", 0, 0, 1920, 1080)

        love.graphics.setColor(0.65, 0.5, 0)
        love.graphics.rectangle("fill", 0, 0, 50, 360)
        love.graphics.setColor(1, 1, 1, 1)
        if hubSection == "Main" then
            love.graphics.setColor(1, 0, 0, 1)
        end
        love.graphics.rectangle("line", 51, 1, 100, 40, 4, 4)
        love.graphics.printf("Main", 50, 3, 100, "center")

        love.graphics.setColor(0, 0.65, 0.3)
        love.graphics.rectangle("fill", 0, 360, 50, 360)
        love.graphics.setColor(1, 1, 1, 1)
        if hubSection == "Science" then
            love.graphics.setColor(1, 0, 0, 1)
        end
        love.graphics.rectangle("line", 51, 361, 100, 40, 4, 4)
        love.graphics.printf("Science", 50, 363, 100, "center")

        love.graphics.setColor(0.5, 0, 0.6)
        love.graphics.rectangle("fill", 0, 720, 50, 360)
        love.graphics.setColor(1, 1, 1, 1)
        if hubSection == "Nexus" then
            love.graphics.setColor(1, 0, 0, 1)
        end
        love.graphics.rectangle("line", 51, 721, 100, 40, 4, 4)
        love.graphics.printf("Nexus", 50, 723, 100, "center")

        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setLineWidth(2)
        love.graphics.rectangle("line", 1820, 100, 150, 200, 8, 8)
        love.graphics.setFont(font_Vera16)
        love.graphics.draw(img_currency_silver, 1830, 110)
        love.graphics.printf(string.format("%s", convertToLetterNotation(currentSilver, "brief")), 1864, 117, 100, "left")
        love.graphics.draw(img_currency_gold, 1830, 142)
        love.graphics.printf(string.format("%s", convertToLetterNotation(currentGold, "brief")), 1864, 149, 100, "left")
        love.graphics.draw(img_currency_electrum, 1830, 174)
        love.graphics.printf(string.format("%s", convertToLetterNotation(currentElectrum, "brief")), 1864, 181, 100, "left")
        love.graphics.draw(img_currency_token, 1830, 206)
        love.graphics.printf(string.format("%s", convertToLetterNotation(currentTokens, "brief")), 1864, 213, 100, "left")

        love.graphics.setLineStyle("rough")
        love.graphics.rectangle("line", 1740, 30, 150, 50)
        love.graphics.printf("Save Game", 1740, 45, 150, "center")

        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setLineStyle("smooth")
        love.graphics.setLineWidth(1)

        if hubSection == "Main" then

            love.graphics.setFont(font_AfacadBold48)
            love.graphics.printf("The Hub", 810, 50, 300, "center")
            love.graphics.printf("YOUR TOWER", 810, 250, 300, "center")
            love.graphics.setFont(font_Afacad20)
            love.graphics.printf("View and analyze your tower's initial properties and other statistics.", 760, 120, 400, "center")
            love.graphics.setFont(font_Afacad24)
            love.graphics.printf(string.format("Attack Damage: %s", convertToLetterNotation(tower_value_attack_damage, "precise")), 810, 320, 300, "center")
            love.graphics.printf(string.format("Attack Speed: %.2f", tower_value_attack_speed), 810, 350, 300, "center")
            love.graphics.printf(string.format("Critical Chance: %.2f%%", tower_value_critical_chance), 810, 380, 300, "center")
            love.graphics.printf(string.format("Critical Factor: x%.2f", tower_value_critical_factor), 810, 410, 300, "center")
            love.graphics.printf(string.format("Range: %d", tower_value_range), 810, 440, 300, "center")

            love.graphics.printf(string.format("Health: %s", convertToLetterNotation(tower_value_maxHealth, "precise")), 810, 500, 300, "center")
            love.graphics.printf(string.format("Regeneration: %s/s", convertToLetterNotation(tower_value_healthRegen, "precise")), 810, 530, 300, "center")
            love.graphics.printf(string.format("Damage Resistance: %.2f%%", tower_value_resistance), 810, 560, 300, "center")
            love.graphics.printf(string.format("Shield Cooldown: %.2fs", tower_value_shield_cooldown), 810, 590, 300, "center")
            love.graphics.printf(string.format("Shield Duration: %.2fs", tower_value_shield_duration), 810, 620, 300, "center")
            love.graphics.setFont(font_ViraSansBold28)
            love.graphics.printf(string.format("Level %s", levelNames[gameplay_difficulty]), 810, 740, 300, "center")
            local bestWaves = {d1_best_wave, d2_best_wave, d3_best_wave, d4_best_wave}
            local highestDiffUnlocked = d4_unlocked and 4 or d3_unlocked and 3 or d2_unlocked and 2 or 1
            love.graphics.setFont(font_Afacad24)
            love.graphics.printf(string.format("Best Wave: %s", bestWaves[gameplay_difficulty] or "None"), 810, 780, 300, "center")
            if gameplay_difficulty > 1 then
                love.graphics.draw(img_button_arrowLeft, 840, 746)
            end
            if gameplay_difficulty < highestDiffUnlocked then
                love.graphics.draw(img_button_arrowRight, 1056, 746)
            end
            love.graphics.setColor(0.1, 0.15, 0.5, 1)
            love.graphics.rectangle("fill", 860, 900, 200, 80, 4, 4)
            love.graphics.setColor(0.3, 0.75, 0.85, 1)
            love.graphics.setLineWidth(2)
            love.graphics.rectangle("line", 860, 900, 200, 80, 4, 4)
            love.graphics.setLineWidth(1)
            love.graphics.setFont(font_Afacad28)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.printf("Battle", 780, 920, 360, "center")
            
        elseif hubSection == "Science" then

            --[[ Title and description ]]--
            love.graphics.setLineStyle("rough")
            love.graphics.setFont(font_AfacadBold48)
            love.graphics.printf("Science", 810, 50, 300, "center")
            love.graphics.setFont(font_Afacad20)
            love.graphics.printf("Upgrade your tower's initial properties and unlock new upgrades to push your limits even further.", 760, 120, 400, "center")

            --[[ Attack Damage Science upgrade ]]--
            drawUpgradeModule("Damage", 645, 240, tower_value_attack_damage, upgrade_science_attack_damage_cost, upgrade_science_attack_damage_level, "science", math.huge, "precise", nil, nil)

            --[[ Attack Speed Science upgrade ]]--
            drawUpgradeModule("Attack Speed", 965, 240, tower_value_attack_speed, upgrade_science_attack_speed_cost, upgrade_science_attack_speed_level, "science", 101, "precise2", nil, nil)

            if upgrade_unlock_crit then

                --[[ Crit Chance Science upgrade ]]--
                drawUpgradeModule("Critical Chance", 645, 310, tower_value_critical_chance, upgrade_science_critChance_cost, upgrade_science_critChance_level, "science", 101, "precise", nil, "%")

                --[[ Crit Factor Science upgrade ]]--
                drawUpgradeModule("Critical Factor", 965, 310, tower_value_critical_factor, upgrade_science_critFactor_cost, upgrade_science_critFactor_level, "science", math.huge, "precise2", "x", nil)
            else

                --[[ Display an "Unlock" panel if Crit Chance/Factor upgrades are not unlocked ]]
                love.graphics.setColor(0, 0.1, 0.2, 1)
                love.graphics.rectangle("fill", 645, 310, 620, 60)
                love.graphics.setColor(0.1, 0.55, 0.98, 1)
                love.graphics.rectangle("line", 645, 310, 620, 60)
                love.graphics.setFont(font_Afacad20)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.printf("Unlock Crit Chance/Factor upgrades", 645, 325, 620, "center")
                love.graphics.setColor(0.05, 0.35, 0.45, 1)
                love.graphics.rectangle("fill", 1182, 313, 80, 54)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.rectangle("line", 1182, 313, 80, 54)
                love.graphics.draw(img_currency_electrum, 1186, 328, 0, 20/32)
                love.graphics.print("3", 1205, 325)
            end

            if upgrade_unlock_crit and upgrade_unlock_range then

                --[[ Range Science upgrade ]]--
                drawUpgradeModule("Range", 645, 380, tower_value_range, upgrade_science_range_cost, upgrade_science_range_level, "science", 41, "brief", nil, nil)

            elseif upgrade_unlock_crit and not upgrade_unlock_range then

                --[[ Display an "Unlock" panel if the Range upgrade are not unlocked ]]
                love.graphics.setColor(0, 0.1, 0.2, 1)
                love.graphics.rectangle("fill", 645, 380, 300, 60)
                love.graphics.setColor(0.1, 0.55, 0.98, 1)
                love.graphics.rectangle("line", 645, 380, 300, 60)
                love.graphics.setFont(font_Afacad20)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.printf("Unlock Range upgrade", 645, 395, 217, "center")
                love.graphics.setColor(0.05, 0.35, 0.45, 1)
                love.graphics.rectangle("fill", 862, 383, 80, 54)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.rectangle("line", 862, 383, 80, 54)
                love.graphics.draw(img_currency_electrum, 866, 398, 0, 20/32)
                love.graphics.print("4", 885, 395)
            end

            --[[ Health Science upgrade ]]--
            drawUpgradeModule("Health", 645, 540, tower_value_maxHealth, upgrade_science_health_cost, upgrade_science_health_level, "science", math.huge, "precise", nil, nil)

            --[[ Regeneration Science upgrade ]]--
            drawUpgradeModule("Regeneration", 965, 540, tower_value_healthRegen, upgrade_science_regeneration_cost, upgrade_science_regeneration_level, "science", math.huge, "precise2", nil, "/s")

            if upgrade_unlock_resistance then

                --[[ Resistance Science upgrade ]]--
                drawUpgradeModule("Resistance", 645, 610, tower_value_resistance, upgrade_science_resistance_cost, upgrade_science_resistance_level, "science", 201, "precise", nil, "%")

            else

                --[[ Display an "Unlock" panel if the Resistance upgrade are not unlocked ]]
                love.graphics.setColor(0, 0.1, 0.2, 1)
                love.graphics.rectangle("fill", 645, 610, 300, 60)
                love.graphics.setColor(0.1, 0.55, 0.98, 1)
                love.graphics.rectangle("line", 645, 610, 300, 60)
                love.graphics.setFont(font_Afacad20)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.printf("Unlock Resistance upgrade", 645, 625, 217, "center")
                love.graphics.setColor(0.05, 0.35, 0.45, 1)
                love.graphics.rectangle("fill", 862, 613, 80, 54)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.rectangle("line", 862, 613, 80, 54)
                love.graphics.draw(img_currency_electrum, 866, 628, 0, 20/32)
                love.graphics.print("6", 885, 625)
            end

            if upgrade_unlock_resistance and upgrade_unlock_shield then

                --[[ Shield Cooldown Science upgrade ]]--
                drawUpgradeModule("Shield Cooldown", 965, 610, tower_value_shield_cooldown, upgrade_science_shieldCooldown_cost, upgrade_science_shieldCooldown_level, "science", 126, "precise", nil, "s")

                --[[ Shield Duration Science upgrade ]]--
                drawUpgradeModule("Shield Duration", 645, 680, tower_value_shield_duration, upgrade_science_shieldDuration_cost, upgrade_science_shieldDuration_level, "science", 111, "precise2", nil, "s")

            elseif upgrade_unlock_resistance and not upgrade_unlock_shield then

                --[[ Display an "Unlock" panel if Shield Cooldown/Duration upgrades are not unlocked ]]--
                love.graphics.setColor(0, 0.1, 0.2, 1)
                love.graphics.rectangle("fill", 645, 680, 620, 60)
                love.graphics.setColor(0.1, 0.55, 0.98, 1)
                love.graphics.rectangle("line", 645, 680, 620, 60)
                love.graphics.setFont(font_Afacad20)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.printf("Unlock Shield Cooldown/Duration upgrades", 645, 695, 620, "center")
                love.graphics.setColor(0.05, 0.35, 0.45, 1)
                love.graphics.rectangle("fill", 1182, 683, 80, 54)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.rectangle("line", 1182, 683, 80, 54)
                love.graphics.draw(img_currency_electrum, 1186, 698, 0, 20/32)
                love.graphics.print("9", 1205, 695)
            end

            if upgrade_unlock_resistance and upgrade_unlock_shield and upgrade_unlock_meteor then

                --[[ Meteor Amount Science upgrade ]]--
                drawUpgradeModule("Meteor Amount", 965, 680, tower_value_meteor_amount, upgrade_science_meteor_amount_cost, upgrade_science_meteor_amount_level, "science", 6, "brief", nil, nil)

                --[[ Meteor RPM Science upgrade ]]--
                drawUpgradeModule("Meteor RPM", 645, 750, tower_value_meteor_RPM, upgrade_science_meteor_RPM_cost, upgrade_science_meteor_RPM_level, "science", 40, "precise2", nil, nil)

            elseif upgrade_unlock_resistance and upgrade_unlock_shield and not upgrade_unlock_meteor then
                --[[ Display an "Unlock" panel if Meteor upgrades are not unlocked ]]
                love.graphics.setColor(0, 0.1, 0.2, 1)
                love.graphics.rectangle("fill", 645, 750, 620, 60)
                love.graphics.setColor(0.1, 0.55, 0.98, 1)
                love.graphics.rectangle("line", 645, 750, 620, 60)
                love.graphics.setFont(font_Afacad20)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.printf("Unlock Meteor upgrades", 645, 765, 620, "center")
                love.graphics.setColor(0.05, 0.35, 0.45, 1)
                love.graphics.rectangle("fill", 1182, 753, 80, 54)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.rectangle("line", 1182, 753, 80, 54)
                love.graphics.draw(img_currency_electrum, 1186, 768, 0, 20/32)
                love.graphics.print("15", 1205, 765)
            end

            --[[ Copper/wave Science upgrade ]]--
            drawUpgradeModule("Copper/wave", 645, 840, gameplay_copperPerWave, upgrade_science_copperPerWave_cost, upgrade_science_copperPerWave_level, "science", math.huge, "brief", nil, nil)

            --[[ Silver/wave Science upgrade ]]--
            drawUpgradeModule("Silver/wave", 965, 840, gameplay_silverPerWave, upgrade_science_silverPerWave_cost, upgrade_science_silverPerWave_level, "science", math.huge, "brief", nil, nil)

            if upgrade_unlock_resourceBonus then

                --[[ Copper Bonus Science upgrade ]]--
                drawUpgradeModule("Copper Bonus", 645, 910, gameplay_copperBonus, upgrade_science_copperBonus_cost, upgrade_science_copperBonus_level, "science", 451, "precise2", "x", nil)

                --[[ Silver Bonus Science upgrade ]]--
                drawUpgradeModule("Silver Bonus", 965, 910, gameplay_silverBonus, upgrade_science_silverBonus_cost, upgrade_science_silverBonus_level, "science", 301, "precise2", "x", nil)

            else

                --[[ Display an "Unlock" panel if Resource Bonus upgrades are not unlocked ]]
                love.graphics.setColor(0, 0.1, 0.2, 1)
                love.graphics.rectangle("fill", 645, 910, 620, 60)
                love.graphics.setColor(0.1, 0.55, 0.98, 1)
                love.graphics.rectangle("line", 645, 910, 620, 60)
                love.graphics.setFont(font_Afacad20)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.printf("Unlock Resource Bonus upgrades", 645, 925, 620, "center")
                love.graphics.setColor(0.05, 0.35, 0.45, 1)
                love.graphics.rectangle("fill", 1182, 913, 80, 54)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.rectangle("line", 1182, 913, 80, 54)
                love.graphics.draw(img_currency_electrum, 1186, 928, 0, 20/32)
                love.graphics.print("5", 1205, 925)

            end

        elseif hubSection == "Nexus" then

            --[[ Title and description ]]--
            love.graphics.setLineStyle("smooth")
            love.graphics.setLineWidth(2)
            love.graphics.setFont(font_AfacadBold48)
            love.graphics.printf("Nexus", 810, 50, 300, "center")
            love.graphics.setFont(font_Afacad20)
            love.graphics.printf("Unlock unique abilities and get powerful stat buffs.", 760, 120, 400, "center")

            --[[ Electrum sub-menu ]]--
            love.graphics.rectangle("line", 1670, 100, 150, 200, 3, 3)
            love.graphics.draw(img_currency_silver, 1680, 110)
            love.graphics.draw(img_currency_gold, 1779, 110)
            love.graphics.setFont(font_Vera16)
            love.graphics.print("40", 1685, 140)
            love.graphics.print("4", 1790, 140)
            love.graphics.line(1696, 160, 1745, 190)
            love.graphics.line(1795, 160, 1745, 190)
            love.graphics.line(1745, 190, 1745, 200)
            love.graphics.draw(img_currency_electrum, 1729, 200)
            love.graphics.print("1", 1740, 230)
            love.graphics.rectangle("line", 1675, 265, 140, 30)
            love.graphics.setFont(font_Afacad20)
            love.graphics.printf("Alloy (8s)", 1675, 265, 140, "center")

            if electrumAlloying then
                love.graphics.setColor(1, 0, 0, 1)
                love.graphics.rectangle("fill", 1675, 254, 140, 8)
                love.graphics.setColor(0, 1, 0, 1)
                love.graphics.rectangle("fill", 1675, 254, (timer_untilElectrum / 8) * 140, 8)
            end

            --[[ Token sub-menu ]]--
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.rectangle("line", 1470, 100, 200, 200, 3, 3)
            love.graphics.setFont(font_AfacadBold20)
            love.graphics.printf("Claim your tokens!", 1470, 110, 200, "center")
            love.graphics.draw(img_currency_token_big, 1538, 136)
            love.graphics.setFont(font_VeraBold18)
            love.graphics.printf("15", 1520, 200, 100, "center")
            love.graphics.rectangle("line", 1475, 265, 190, 30)
            love.graphics.setFont(font_Afacad20)
            if not tokensOnCooldown then
                love.graphics.printf("Claim", 1475, 265, 190, "center")
            else
                love.graphics.printf(string.format("%dm %ds", (tokenCooldown - timer_untilTokens) / 60, (tokenCooldown - timer_untilTokens) % 60), 1475, 265, 190, "center")
            end
            if tokensOnCooldown then
                love.graphics.setColor(1, 0, 0, 1)
                love.graphics.rectangle("fill", 1475, 254, 190, 8)
                love.graphics.setColor(0, 1, 0, 1)
                love.graphics.rectangle("fill", 1475, 254, (timer_untilTokens / tokenCooldown) * 190, 8)
            end

            --[[ Buff sub-menu ]]--
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.rectangle("line", 650, 250, 150, 200, 4, 4)
            love.graphics.printf("Attack Damage", 650, 250, 150, "center")
            love.graphics.printf(string.format("x%.2f", upgrade_nexus_attack_damage_buff), 650, 280, 150, "center")
            love.graphics.setColor(0.6, 0.45, 0.25, 1)
            love.graphics.rectangle("fill", 655, 405, 140, 40)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.setLineStyle("rough")
            love.graphics.setLineWidth(1)
            love.graphics.rectangle("line", 655, 405, 140, 40)
            love.graphics.setFont(font_Afacad24)
            if upgrade_nexus_attack_damage_level < 41 then
                love.graphics.draw(img_currency_token, 660, 410)
                love.graphics.print(upgrade_nexus_attack_damage_cost, 692, 409)
            else
                love.graphics.printf("Max", 655, 409, 140, "center")
            end

            love.graphics.setFont(font_Afacad20)
            love.graphics.setLineStyle("smooth")
            love.graphics.setLineWidth(2)
            love.graphics.rectangle("line", 810, 250, 150, 200, 4, 4)
            love.graphics.printf("Attack Speed", 810, 250, 150, "center")
            love.graphics.printf(string.format("x%.2f", upgrade_nexus_attack_speed_buff), 810, 280, 150, "center")
            love.graphics.setColor(0.6, 0.45, 0.25, 1)
            love.graphics.rectangle("fill", 815, 405, 140, 40)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.setLineStyle("rough")
            love.graphics.setLineWidth(1)
            love.graphics.rectangle("line", 815, 405, 140, 40)
            love.graphics.setFont(font_Afacad24)
            if upgrade_nexus_attack_speed_level < 26 then
                love.graphics.draw(img_currency_token, 820, 410)
                love.graphics.print(upgrade_nexus_attack_speed_cost, 852, 409)
            else
                love.graphics.printf("Max", 815, 409, 140, "center")
            end

            love.graphics.setFont(font_Afacad20)
            love.graphics.setLineStyle("smooth")
            love.graphics.setLineWidth(2)
            love.graphics.rectangle("line", 970, 250, 150, 200, 4, 4)
            love.graphics.printf("Health", 970, 250, 150, "center")
            love.graphics.printf(string.format("x%.2f", upgrade_nexus_health_buff), 970, 280, 150, "center")
            love.graphics.setColor(0.6, 0.45, 0.25, 1)
            love.graphics.rectangle("fill", 975, 405, 140, 40)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.setLineStyle("rough")
            love.graphics.setLineWidth(1)
            love.graphics.rectangle("line", 975, 405, 140, 40)
            love.graphics.setFont(font_Afacad24)
            if upgrade_nexus_health_level < 41 then
                love.graphics.draw(img_currency_token, 980, 410)
                love.graphics.print(upgrade_nexus_health_cost, 1012, 409)
            else
                love.graphics.printf("Max", 975, 409, 140, "center")
            end

            love.graphics.setFont(font_Afacad20)
            love.graphics.setLineStyle("smooth")
            love.graphics.setLineWidth(2)
            love.graphics.rectangle("line", 1130, 250, 150, 200, 4, 4)
            love.graphics.printf("Regeneration", 1130, 250, 150, "center")
            love.graphics.printf(string.format("x%.2f", upgrade_nexus_regeneration_buff), 1130, 280, 150, "center")
            love.graphics.setColor(0.6, 0.45, 0.25, 1)
            love.graphics.rectangle("fill", 1135, 405, 140, 40)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.setLineStyle("rough")
            love.graphics.setLineWidth(1)
            love.graphics.rectangle("line", 1135, 405, 140, 40)
            love.graphics.setFont(font_Afacad24)
            if upgrade_nexus_regeneration_level < 41 then
                love.graphics.draw(img_currency_token, 1140, 410)
                love.graphics.print(upgrade_nexus_regeneration_cost, 1172, 409)
            else
                love.graphics.printf("Max", 1135, 409, 140, "center")
            end

            love.graphics.setFont(font_AfacadBold32)
            love.graphics.printf("Unique abilities", 810, 500, 300, "center")

            love.graphics.setFont(font_Afacad20)
            love.graphics.setLineStyle("smooth")
            love.graphics.setLineWidth(2)
            love.graphics.rectangle("line", 650, 550, 630, 150, 4, 4)
            love.graphics.setFont(font_AfacadBold24)
            love.graphics.printf("Wave Skip", 650, 550, 630, "center")
            love.graphics.setColor(0.6, 0.45, 0.25, 1)
            love.graphics.rectangle("fill", 1155, 590, 120, 105)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.setLineStyle("rough")
            love.graphics.setLineWidth(1)
            love.graphics.rectangle("line", 1155, 590, 120, 105)
            love.graphics.setFont(font_Afacad24)
            if ability_unlock_waveSkip then
                love.graphics.setFont(font_Afacad20)
                love.graphics.printf("Chance +2%", 1155, 590, 120, "center")
                if ability_waveSkip_chance_level < 16 then
                    love.graphics.draw(img_currency_electrum, 1195, 632, 0, 20/32)
                    love.graphics.setFont(font_Afacad24)
                    love.graphics.print(convertToLetterNotation(ability_waveSkip_chance_cost, "brief"), 1214, 625)
                else
                    love.graphics.setFont(font_Afacad24)
                    love.graphics.printf("Max", 1155, 625, 120, "center")
                end
            else
                love.graphics.printf("Unlock", 1155, 590, 120, "center")
                love.graphics.draw(img_currency_electrum, 1190, 632, 0, 20/32)
                love.graphics.print("20", 1209, 625)
            end
            love.graphics.setFont(font_Afacad20)
            love.graphics.printf(string.format("There is a %d%% chance of skipping a wave and immediately advancing to the next wave.", ability_waveSkip_chance), 655, 600, 400, "left")
        end
    end
end

function inHub_mouse(x, y)
    if inHub then
        
        --[[ Process mouse clicks on sidebar, go to different sections based on the button pressed ]]--
        if x >= 0 and x <= 50 and y >= 0 and y <= 360 then
            hubSection = "Main"
        end
        if x >= 0 and x <= 50 and y >= 360 and y <= 720 then
            hubSection = "Science"
        end
        if x >= 0 and x <= 50 and y >= 720 and y <= 1080 then
            hubSection = "Nexus"
        end
        if x >= 1740 and x <= 1890 and y >= 30 and y <= 80 then
            saveGame()
        end
        
        --[[ Exit Hub and go to battle ]]--
        if hubSection == "Main" then
            if x >= 860 and x <= 1060 and y >= 900 and y <= 980 then
                inHub = false
                resetRoundValues()
                gameOver = false
                paused = false
                gameSpeed = 1
            end
            if x >= 840 and x <= 864 and y >= 746 and y <= 770 and gameplay_difficulty > 1 then
                gameplay_difficulty = gameplay_difficulty - 1
                
            elseif x >= 1056 and x <= 1080 and y >= 746 and y <= 770 and gameplay_difficulty < 4 then
                gameplay_difficulty = gameplay_difficulty + 1
            end

        elseif hubSection == "Science" then

            --[[ Attack Damage Science upgrade ]]--
            if x >= 862 and x <= 942 and y >= 243 and y <= 297 then
                if currentSilver >= upgrade_science_attack_damage_cost then
                    currentSilver = currentSilver - upgrade_science_attack_damage_cost
                    upgrade_science_attack_damage_level = upgrade_science_attack_damage_level + 1
                    upgrade_science_attack_damage_cost = math.floor(0.4 * upgrade_science_attack_damage_level^2 + 2.6)
                    tower_value_attack_damage = ((0.2 * upgrade_science_attack_damage_level - 0.2)^2.75 + 2.2 + upgrade_science_attack_damage_level) * upgrade_nexus_attack_damage_buff
                end
            end

            --[[ Attack Speed Science upgrade ]]--
            if x >= 1182 and x <= 1262 and y >= 243 and y <= 297 then
                if currentSilver >= upgrade_science_attack_speed_cost and upgrade_science_attack_speed_level < 101 then
                    currentSilver = currentSilver - upgrade_science_attack_speed_cost
                    upgrade_science_attack_speed_level = upgrade_science_attack_speed_level + 1
                    upgrade_science_attack_speed_cost = math.floor(8^((upgrade_science_attack_speed_level - 1) / 20) + 3 * upgrade_science_attack_speed_level + 4)
                    tower_value_attack_speed = (math.min(0.5 + 0.04 * (upgrade_science_attack_speed_level - 1), 4.5)) * upgrade_nexus_attack_speed_buff
                end
            end

            if upgrade_unlock_crit then

                --[[ Crit Chance Science upgrade ]]--
                if x >= 862 and x <= 942 and y >= 313 and y <= 367 then
                    if currentSilver >= upgrade_science_critChance_cost and upgrade_science_critChance_level < 101 then
                        currentSilver = currentSilver - upgrade_science_critChance_cost
                        upgrade_science_critChance_level = upgrade_science_critChance_level + 1
                        upgrade_science_critChance_cost = math.floor((upgrade_science_critChance_level / 2)^2 + 4 * upgrade_science_critChance_level + 1.75)
                        tower_value_critical_chance = math.min((upgrade_science_critChance_level - 1) / 2, 50)
                    end
                end

                --[[ Crit Factor Science upgrade ]]--
                if x >= 1182 and x <= 1262 and y >= 313 and y <= 367 then
                    if currentSilver >= upgrade_science_critFactor_cost then
                        currentSilver = currentSilver - upgrade_science_critFactor_cost
                        upgrade_science_critFactor_level = upgrade_science_critFactor_level + 1
                        upgrade_science_critFactor_cost = math.floor(0.2 * (upgrade_science_critFactor_level^2) + 1.8)
                        tower_value_critical_factor = 1 + ((upgrade_science_critFactor_level - 1) / 20)
                    end
                end
            else

                --[[ Crit Chance/Factor upgrade unlock ]]--
                if x >= 1182 and x <= 1262 and y >= 313 and y <= 367 then
                    if currentElectrum >= 3 then
                        currentElectrum = currentElectrum - 3
                        upgrade_unlock_crit = true
                    end
                end
            end

            if upgrade_unlock_crit and upgrade_unlock_range then

                --[[ Range Science upgrade ]]--
                if x >= 862 and x <= 942 and y >= 383 and y <= 437 then
                    if currentSilver >= upgrade_science_range_cost and upgrade_science_range_level < 41 then
                        currentSilver = currentSilver - upgrade_science_range_cost
                        upgrade_science_range_level = upgrade_science_range_level + 1
                        upgrade_science_range_cost = math.floor((upgrade_science_range_level^2 + 5 * upgrade_science_range_level) / 3 + 2 * upgrade_science_range_level + 4)
                        tower_value_range = math.min(240 + 3 * (upgrade_science_range_level - 1), 360)
                    end
                end

            elseif upgrade_unlock_crit and not upgrade_unlock_range then

                --[[ Range upgrade unlock ]]--
                if x >= 862 and x <= 942 and y >= 383 and y <= 437 then
                    if currentElectrum >= 4 then
                        currentElectrum = currentElectrum - 4
                        upgrade_unlock_range = true
                    end
                end
            end

            --[[ Health Science upgrade ]]--
            if x >= 862 and x <= 942 and y >= 543 and y <= 597 then
                if currentSilver >= upgrade_science_health_cost then
                    currentSilver = currentSilver - upgrade_science_health_cost
                    upgrade_science_health_level = upgrade_science_health_level + 1
                    upgrade_science_health_cost = math.floor(0.6 * upgrade_science_health_level^2 + 3.4)
                    tower_value_maxHealth = ((0.2 * upgrade_science_health_level - 0.2)^3.75 + 4 + upgrade_science_health_level) * upgrade_nexus_health_buff
                end
            end

            --[[ Regeneration Science upgrade ]]--
            if x >= 1182 and x <= 1262 and y >= 543 and y <= 597 then
                if currentSilver >= upgrade_science_regeneration_cost then
                    currentSilver = currentSilver - upgrade_science_regeneration_cost
                    upgrade_science_regeneration_level = upgrade_science_regeneration_level + 1
                    upgrade_science_regeneration_cost = math.floor(upgrade_science_regeneration_level^1.75 + 2 * upgrade_science_regeneration_level + 3)
                    tower_value_healthRegen = (((2 * upgrade_science_regeneration_level + 1)^2) / 50 - 0.18) * upgrade_nexus_regeneration_buff
                end
            end

            if upgrade_unlock_resistance then

                --[[ Resistance Science upgrade ]]--
                if x >= 862 and x <= 942 and y >= 613 and y <= 667 then
                    if currentSilver >= upgrade_science_resistance_cost and upgrade_science_resistance_level < 201 then
                        currentSilver = currentSilver - upgrade_science_resistance_cost
                        upgrade_science_resistance_level = upgrade_science_resistance_level + 1
                        upgrade_science_resistance_cost = math.floor(upgrade_science_resistance_level * math.sqrt(2 * upgrade_science_resistance_level) + 3 - math.sqrt(2))
                        tower_value_resistance = math.min(0.4 * (upgrade_science_resistance_level - 1), 80)
                    end
                end
            else

                --[[ Resistance upgrade unlock ]]--
                if x >= 862 and x <= 942 and y >= 613 and y <= 667 then
                    if currentElectrum >= 6 then
                        currentElectrum = currentElectrum - 6
                        upgrade_unlock_resistance = true
                    end
                end
            end

            if upgrade_unlock_resistance and upgrade_unlock_shield then

                --[[ Shield Cooldown Science upgrade ]]--
                if x >= 1182 and x <= 1262 and y >= 613 and y <= 667 then
                    if currentSilver >= upgrade_science_shieldCooldown_cost and upgrade_science_shieldCooldown_level < 126 then
                        currentSilver = currentSilver - upgrade_science_shieldCooldown_cost
                        upgrade_science_shieldCooldown_level = upgrade_science_shieldCooldown_level + 1
                        upgrade_science_shieldCooldown_cost = math.floor(upgrade_science_shieldCooldown_level^(math.log(upgrade_science_shieldCooldown_level, 10)) + 3)
                        tower_value_shield_cooldown = math.max(120 - 0.6 * (upgrade_science_shieldCooldown_level - 1), 42)
                    end
                end

                --[[ Shield Duration Science upgrade ]]--
                if x >= 862 and x <= 942 and y >= 683 and y <= 737 then
                    if currentSilver >= upgrade_science_shieldDuration_cost and upgrade_science_shieldDuration_level < 111 then
                        currentSilver = currentSilver - upgrade_science_shieldDuration_cost
                        upgrade_science_shieldDuration_level = upgrade_science_shieldDuration_level + 1
                        upgrade_science_shieldDuration_cost = math.floor((upgrade_science_shieldDuration_level)^(math.log(upgrade_science_shieldDuration_level) / 2) + 3)
                        tower_value_shield_duration = math.min(0.05 * (upgrade_science_shieldDuration_level - 1) + 0.5, 6)
                    end
                end

            elseif upgrade_unlock_resistance and not upgrade_unlock_shield then

                --[[ Shield Cooldown/Duration upgrade unlock ]]--
                if x >= 1182 and x <= 1262 and y >= 683 and y <= 737 then
                    if currentElectrum >= 9 then
                        currentElectrum = currentElectrum - 9
                        upgrade_unlock_shield = true
                    end
                end
            end

            if upgrade_unlock_resistance and upgrade_unlock_shield and upgrade_unlock_meteor then
                
                --[[ Meteor Amount Science upgrade ]]--
                if x >= 1182 and x <= 1262 and y >= 683 and y <= 737 then
                    if currentSilver >= upgrade_science_meteor_amount_cost and upgrade_science_meteor_amount_level < 6 then
                        currentSilver = currentSilver - upgrade_science_meteor_amount_cost
                        upgrade_science_meteor_amount_level = upgrade_science_meteor_amount_level + 1
                        upgrade_science_meteor_amount_cost = math.floor((16 * upgrade_science_meteor_amount_level)^2 + 144)
                        tower_value_meteor_amount = math.min(upgrade_science_meteor_amount_level - 1, 5)
                    end
                end

                --[[ Meteor RPM Science upgrade ]]--
                if x >= 862 and x <= 942 and y >= 753 and y <= 807 then
                    if currentSilver >= upgrade_science_meteor_RPM_cost and upgrade_science_meteor_RPM_level < 40 then
                        currentSilver = currentSilver - upgrade_science_meteor_RPM_cost
                        upgrade_science_meteor_RPM_level = upgrade_science_meteor_RPM_level + 1
                        upgrade_science_meteor_RPM_cost = math.floor((3 * upgrade_science_meteor_RPM_level)^2 + 41)
                        tower_value_meteor_RPM = math.min(0.15 * upgrade_science_meteor_RPM_level + 0.25, 6.25)
                    end
                end

            elseif upgrade_unlock_resistance and upgrade_unlock_shield and not upgrade_unlock_meteor then
                
                --love.graphics.rectangle("fill", 1182, 753, 80, 54)
                if x >= 1182 and x <= 1262 and y >= 753 and y <= 807 then
                    if currentElectrum >= 15 then
                        currentElectrum = currentElectrum - 15
                        upgrade_unlock_meteor = true
                    end
                end

            end

            --[[ Copper/wave Science upgrade ]]--
            if x >= 862 and x <= 942 and y >= 843 and y <= 897 then
                if currentSilver >= upgrade_science_copperPerWave_cost then
                    currentSilver = currentSilver - upgrade_science_copperPerWave_cost
                    upgrade_science_copperPerWave_level = upgrade_science_copperPerWave_level + 1
                    upgrade_science_copperPerWave_cost = math.floor((upgrade_science_copperPerWave_level^2 + upgrade_science_copperPerWave_level + 1) * 3 + 11)
                    gameplay_copperPerWave = 4 * (upgrade_science_copperPerWave_level - 1)
                end
            end

            --[[ Silver/wave Science upgrade ]]--
            if x >= 1182 and x <= 1262 and y >= 843 and y <= 897 then
                if currentSilver >= upgrade_science_silverPerWave_cost then
                    currentSilver = currentSilver - upgrade_science_silverPerWave_cost
                    upgrade_science_silverPerWave_level = upgrade_science_silverPerWave_level + 1
                    upgrade_science_silverPerWave_cost = math.floor(((8 * upgrade_science_silverPerWave_level) / 5)^2 + 27.44)
                    gameplay_silverPerWave = 3 * (upgrade_science_silverPerWave_level - 1)
                end
            end

            if upgrade_unlock_resourceBonus then

                --[[ Copper Bonus Science upgrade ]]--
                if x >= 862 and x <= 942 and y >= 913 and y <= 967 then
                    if currentSilver >= upgrade_science_copperBonus_cost and upgrade_science_copperBonus_level < 451 then
                        currentSilver = currentSilver - upgrade_science_copperBonus_cost
                        upgrade_science_copperBonus_level = upgrade_science_copperBonus_level + 1
                        upgrade_science_copperBonus_cost = math.floor((0.4 * (upgrade_science_copperBonus_level - 1))^1.9 + 8)
                        gameplay_copperBonus = math.min(1 + 0.02 * (upgrade_science_copperBonus_level - 1), 10)
                    end
                end

                --[[ Silver Bonus Science upgrade ]]--
                if x >= 1182 and x <= 1262 and y >= 913 and y <= 967 then
                    if currentSilver >= upgrade_science_silverBonus_cost and upgrade_science_silverBonus_level < 301 then
                        currentSilver = currentSilver - upgrade_science_silverBonus_cost
                        upgrade_science_silverBonus_level = upgrade_science_silverBonus_level + 1
                        upgrade_science_silverBonus_cost = math.floor(0.4 * upgrade_science_silverBonus_level^2 + upgrade_science_silverBonus_level + 8.6)
                        gameplay_silverBonus = math.min(1 + 0.01 * (upgrade_science_silverBonus_level - 1), 4)
                    end
                end

            else

                --[[ Resource Bonus upgrade unlock ]]--
                if x >= 1182 and x <= 1262 and y >= 913 and y <= 967 then
                    if currentElectrum >= 5 then
                        currentElectrum = currentElectrum - 5
                        upgrade_unlock_resourceBonus = true
                    end
                end
            end

        elseif hubSection == "Nexus" then
            --[[ If in Nexus, clicking the Alloy button starts the Electrum alloying process after spending 40 Silver and 4 Gold ]]--
            if x >= 1675 and x <= 1815 and y >= 265 and y <= 295 then
                if currentSilver >= 40 and currentGold >= 4 and not electrumAlloying then
                    timer_untilElectrum = 0
                    electrumAlloying = true
                    currentSilver = currentSilver - 40
                    currentGold = currentGold - 4
                end
            end

            --[[ Claiming tokens ]]--
            if x >= 1475 and x <= 1665 and y >= 265 and y <= 295 then
                if not tokensOnCooldown then
                    currentTokens = currentTokens + 15
                    timer_untilTokens = 0
                    tokensOnCooldown = true
                end
            end

            --[[ Attack Damage stat buff ]]--
            if x >= 655 and x <= 795 and y >= 405 and y <= 445 then
                if currentTokens >= upgrade_nexus_attack_damage_cost and upgrade_nexus_attack_damage_level < 41 then
                    currentTokens = currentTokens - upgrade_nexus_attack_damage_cost
                    upgrade_nexus_attack_damage_level = upgrade_nexus_attack_damage_level + 1
                    upgrade_nexus_attack_damage_cost = 50 + ((upgrade_nexus_attack_damage_level * (upgrade_nexus_attack_damage_level - 1)) / 2) * 10
                    upgrade_nexus_attack_damage_buff = math.min(1 + (upgrade_nexus_attack_damage_level - 1) * 10/100, 5)
                    tower_value_attack_damage = ((0.2 * upgrade_science_attack_damage_level - 0.2)^2.75 + 2.2 + upgrade_science_attack_damage_level) * upgrade_nexus_attack_damage_buff
                end
            end

            --[[ Attack Speed stat buff ]]--
            if x >= 815 and x <= 955 and y >= 405 and y <= 445 then
                if currentTokens >= upgrade_nexus_attack_speed_cost and upgrade_nexus_attack_speed_level < 26 then
                    currentTokens = currentTokens - upgrade_nexus_attack_speed_cost
                    upgrade_nexus_attack_speed_level = upgrade_nexus_attack_speed_level + 1
                    upgrade_nexus_attack_speed_cost = 50 + ((upgrade_nexus_attack_speed_level * (upgrade_nexus_attack_speed_level - 1)) / 2) * 10
                    upgrade_nexus_attack_speed_buff = math.min(1 + (upgrade_nexus_attack_speed_level - 1) * 4/100, 2)
                    tower_value_attack_speed = (math.min(0.5 + 0.04 * (upgrade_science_attack_speed_level - 1), 4.5)) * upgrade_nexus_attack_speed_buff
                end
            end

            --[[ Health stat buff ]]--
            if x >= 975 and x <= 1115 and y >= 405 and y <= 445 then
                if currentTokens >= upgrade_nexus_health_cost and upgrade_nexus_health_level < 41 then
                    currentTokens = currentTokens - upgrade_nexus_health_cost
                    upgrade_nexus_health_level = upgrade_nexus_health_level + 1
                    upgrade_nexus_health_cost = 50 + ((upgrade_nexus_health_level * (upgrade_nexus_health_level - 1)) / 2) * 10
                    upgrade_nexus_health_buff = math.min(1 + (upgrade_nexus_health_level - 1) * 10/100, 5)
                    tower_value_maxHealth = ((0.2 * upgrade_science_health_level - 0.2)^3.75 + 4 + upgrade_science_health_level) * upgrade_nexus_health_buff
                end
            end

            --[[ Regeneration stat buff ]]--
            if x >= 1135 and x <= 1275 and y >= 405 and y <= 445 then
                if currentTokens >= upgrade_nexus_regeneration_cost and upgrade_nexus_regeneration_level < 41 then
                    currentTokens = currentTokens - upgrade_nexus_regeneration_cost
                    upgrade_nexus_regeneration_level = upgrade_nexus_regeneration_level + 1
                    upgrade_nexus_regeneration_cost = 50 + ((upgrade_nexus_regeneration_level * (upgrade_nexus_regeneration_level - 1)) / 2) * 10
                    upgrade_nexus_regeneration_buff = math.min(1 + (upgrade_nexus_regeneration_level - 1) * 10/100, 5)
                    tower_value_healthRegen = (((2 * upgrade_science_regeneration_level + 1)^2) / 50 - 0.18) * upgrade_nexus_regeneration_buff
                end
            end

            if x >= 1155 and x <= 1275 and y >= 590 and y <= 695 then
                if ability_unlock_waveSkip then
                    if currentElectrum >= ability_waveSkip_chance_cost and ability_waveSkip_chance_level < 16 then
                        currentElectrum = currentElectrum - ability_waveSkip_chance_cost
                        ability_waveSkip_chance_level = ability_waveSkip_chance_level + 1
                        ability_waveSkip_chance_cost = (ability_waveSkip_chance_level * (ability_waveSkip_chance_level - 1)) / 2 + 4
                        ability_waveSkip_chance = 2 * ability_waveSkip_chance_level + 3
                    end
                elseif not ability_unlock_waveSkip then
                    if currentElectrum >= 20 then
                        currentElectrum = currentElectrum - 20
                        ability_unlock_waveSkip = true
                        ability_waveSkip_chance_cost = (ability_waveSkip_chance_level * (ability_waveSkip_chance_level - 1)) / 2 + 4
                        ability_waveSkip_chance = 5
                    end
                end
            end
        end
    end
end