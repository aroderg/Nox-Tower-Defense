function inHub_visual()
    if player.location == "hub" then
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
        love.graphics.rectangle("line", 51, 1, 100, 40, 2, 2)
        love.graphics.printf("Main", 50, 3, 100, "center")

        love.graphics.setColor(0, 0.65, 0.3)
        love.graphics.rectangle("fill", 0, 360, 50, 360)
        love.graphics.setColor(1, 1, 1, 1)
        if hubSection == "Science" then
            love.graphics.setColor(1, 0, 0, 1)
        end
        love.graphics.rectangle("line", 51, 361, 100, 40, 2, 2)
        love.graphics.printf("Science", 50, 363, 100, "center")

        love.graphics.setColor(0.5, 0, 0.6)
        love.graphics.rectangle("fill", 0, 720, 50, 360)
        love.graphics.setColor(1, 1, 1, 1)
        if hubSection == "Nexus" then
            love.graphics.setColor(1, 0, 0, 1)
        end
        love.graphics.rectangle("line", 51, 721, 100, 40, 2, 2)
        love.graphics.printf("Nexus", 50, 723, 100, "center")

        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setLineWidth(2)
        love.graphics.rectangle("line", 1800, 100, 150, 200, 4, 4)
        love.graphics.setFont(font_Vera16)
        love.graphics.draw(img_currency_silver, 1810, 110)
        love.graphics.printf(string.format("%s", notations.convertToLetterNotation(player.currencies.currentSilver, "brief")), 1844, 117, 100, "left")
        love.graphics.draw(img_currency_gold, 1810, 142)
        love.graphics.printf(string.format("%s", notations.convertToLetterNotation(player.currencies.currentGold, "brief")), 1844, 149, 100, "left")
        love.graphics.draw(img_currency_electrum, 1810, 174)
        love.graphics.printf(string.format("%s", notations.convertToLetterNotation(player.currencies.currentElectrum, "brief")), 1844, 181, 100, "left")
        love.graphics.draw(img_currency_token, 1810, 206)
        love.graphics.printf(string.format("%s", notations.convertToLetterNotation(player.currencies.currentTokens, "brief")), 1844, 213, 100, "left")

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
            love.graphics.printf(string.format("Attack Damage: %s", notations.convertToLetterNotation(player.tower.attackDamage, "precise")), 810, 320, 300, "center")
            love.graphics.printf(string.format("Attack Speed: %.2f", player.tower.attackSpeed), 810, 350, 300, "center")
            love.graphics.printf(string.format("Critical Chance: %.1f%%", player.tower.critChance), 810, 380, 300, "center")
            love.graphics.printf(string.format("Critical Factor: x%.2f", player.tower.critFactor), 810, 410, 300, "center")
            love.graphics.printf(string.format("Range: %.1f", player.tower.range / 20), 810, 440, 300, "center")

            love.graphics.printf(string.format("Health: %s", notations.convertToLetterNotation(player.tower.maxHealth, "precise")), 810, 500, 300, "center")
            love.graphics.printf(string.format("Regeneration: %s/s", notations.convertToLetterNotation(player.tower.regeneration, "precise2")), 810, 530, 300, "center")
            love.graphics.printf(string.format("Damage Resistance: %.2f%%", player.tower.resistance), 810, 560, 300, "center")
            love.graphics.printf(string.format("Shield Cooldown: %.1fs", player.tower.shieldCooldown), 810, 590, 300, "center")
            love.graphics.printf(string.format("Shield Duration: %.2fs", player.tower.shieldDuration), 810, 620, 300, "center")
            love.graphics.setFont(font_ViraSansBold28)
            love.graphics.printf(string.format("Level %s", levelNames[player.difficulty.difficulty]), 810, 740, 300, "center")
            local bestWaves = {player.bestWaves.d1, player.bestWaves.d2, player.bestWaves.d3, player.bestWaves.d4}
            local highestDiffUnlocked = player.difficulty.unlocks.d4 and 4 or player.difficulty.unlocks.d3 and 3 or player.difficulty.unlocks.d2 and 2 or 1
            love.graphics.setFont(font_Afacad24)
            love.graphics.printf(string.format("Best Wave: %s", bestWaves[player.difficulty.difficulty] or "None"), 810, 780, 300, "center")
            if player.difficulty.difficulty > 1 then
                love.graphics.draw(img_button_arrowLeft, 840, 746)
            end
            if player.difficulty.difficulty < highestDiffUnlocked then
                love.graphics.draw(img_button_arrowRight, 1056, 746)
            end
            love.graphics.setColor(0.1, 0.15, 0.5, 1)
            love.graphics.rectangle("fill", 860, 900, 200, 80, 3, 3)
            love.graphics.setColor(0.3, 0.75, 0.85, 1)
            love.graphics.setLineWidth(2)
            love.graphics.rectangle("line", 860, 900, 200, 80, 3, 3)
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

            processUpgradeModule.reload()

            local sectionTable = {"ATK", "VIT", "UTL"}
            for i,v in ipairs(sectionTable) do
                local section = sectionTable[i]
                
                for j,w in ipairs(upgradeModules["science"][section]) do
                    if upgradeModules["science"][section][j]["precedingUpgrade"] ~= false then
                        processUpgradeModule.draw(upgradeModules["science"][section][j])
                    else
                        processUnlockPanel.draw(unlockPanels[upgradeModules["science"][section][j][14]])
                        break
                    end
                end
            end

        elseif hubSection == "Nexus" then

            --[[ Title and description ]]--
            love.graphics.setLineStyle("smooth")
            love.graphics.setLineWidth(2)
            love.graphics.setFont(font_AfacadBold48)
            love.graphics.printf("Nexus", 810, 50, 300, "center")
            love.graphics.setFont(font_Afacad20)
            love.graphics.printf("Unlock unique modifiers and get powerful stat buffs.", 760, 120, 400, "center")

            --[[ Electrum sub-menu ]]--
            love.graphics.rectangle("line", 1650, 100, 150, 200, 4, 4)
            love.graphics.draw(img_currency_silver, 1660, 110)
            love.graphics.draw(img_currency_gold, 1759, 110)
            love.graphics.setFont(font_Vera16)
            love.graphics.printf("400", 1655, 140, 40, "center")
            love.graphics.printf("2", 1755, 140, 40, "center")
            love.graphics.line(1676, 160, 1725, 190)
            love.graphics.line(1775, 160, 1725, 190)
            love.graphics.line(1725, 190, 1725, 200)
            love.graphics.draw(img_currency_electrum, 1709, 200)
            love.graphics.print("1", 1720, 230)
            love.graphics.rectangle("line", 1655, 265, 140, 30)
            love.graphics.setFont(font_Afacad20)
            love.graphics.printf("Alloy (24s)", 1655, 265, 140, "center")

            if not player.canClaim.electrum then
                love.graphics.setColor(1, 0, 0, 1)
                love.graphics.rectangle("fill", 1655, 254, 140, 8)
                love.graphics.setColor(0, 1, 0, 1)
                love.graphics.rectangle("fill", 1655, 254, (player.timers.electrum / player.cooldowns.electrum) * 140, 8)
            end

            --[[ Token sub-menu ]]--
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.rectangle("line", 1450, 100, 200, 200, 4, 4)
            love.graphics.setFont(font_AfacadBold20)
            love.graphics.printf("Claim your tokens!", 1450, 110, 200, "center")
            love.graphics.draw(img_currency_token_big, 1518, 136)
            love.graphics.setFont(font_VeraBold18)
            love.graphics.printf("15", 1500, 200, 100, "center")
            love.graphics.rectangle("line", 1455, 265, 190, 30)
            love.graphics.setFont(font_Afacad20)
            if player.canClaim.tokens then
                love.graphics.printf("Claim", 1455, 265, 190, "center")
            else
                love.graphics.printf(string.format("%dm %ds", (player.cooldowns.tokens - player.timers.tokens) / 60, (player.cooldowns.tokens - player.timers.tokens) % 60), 1455, 265, 190, "center")
            end
            if not player.canClaim.tokens then
                love.graphics.setColor(1, 0, 0, 1)
                love.graphics.rectangle("fill", 1455, 254, 190, 8)
                love.graphics.setColor(0, 1, 0, 1)
                love.graphics.rectangle("fill", 1455, 254, (player.timers.tokens / player.cooldowns.tokens) * 190, 8)
            end

            --[[ Buff sub-menu ]]--
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.rectangle("line", 650, 250, 150, 200, 4, 4)
            love.graphics.printf("Attack Damage", 650, 250, 150, "center")
            love.graphics.printf(string.format("x%.2f", player.upgrades.nexus.attackDamage.value), 650, 280, 150, "center")
            love.graphics.setColor(0.6, 0.45, 0.25, 1)
            love.graphics.rectangle("fill", 655, 405, 140, 40)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.setLineStyle("rough")
            love.graphics.setLineWidth(1)
            love.graphics.rectangle("line", 655, 405, 140, 40)
            love.graphics.setFont(font_Afacad24)
            if player.upgrades.nexus.attackDamage.level < 41 then
                love.graphics.draw(img_currency_token, 660, 410)
                love.graphics.print(player.upgrades.nexus.attackDamage.cost, 692, 409)
            else
                love.graphics.printf("Max", 655, 409, 140, "center")
            end

            love.graphics.setFont(font_Afacad20)
            love.graphics.setLineStyle("smooth")
            love.graphics.setLineWidth(2)
            love.graphics.rectangle("line", 810, 250, 150, 200, 4, 4)
            love.graphics.printf("Attack Speed", 810, 250, 150, "center")
            love.graphics.printf(string.format("x%.2f", player.upgrades.nexus.attackSpeed.value), 810, 280, 150, "center")
            love.graphics.setColor(0.6, 0.45, 0.25, 1)
            love.graphics.rectangle("fill", 815, 405, 140, 40)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.setLineStyle("rough")
            love.graphics.setLineWidth(1)
            love.graphics.rectangle("line", 815, 405, 140, 40)
            love.graphics.setFont(font_Afacad24)
            if player.upgrades.nexus.attackSpeed.level < 26 then
                love.graphics.draw(img_currency_token, 820, 410)
                love.graphics.print(player.upgrades.nexus.attackSpeed.cost, 852, 409)
            else
                love.graphics.printf("Max", 815, 409, 140, "center")
            end

            love.graphics.setFont(font_Afacad20)
            love.graphics.setLineStyle("smooth")
            love.graphics.setLineWidth(2)
            love.graphics.rectangle("line", 970, 250, 150, 200, 4, 4)
            love.graphics.printf("Health", 970, 250, 150, "center")
            love.graphics.printf(string.format("x%.2f", player.upgrades.nexus.health.value), 970, 280, 150, "center")
            love.graphics.setColor(0.6, 0.45, 0.25, 1)
            love.graphics.rectangle("fill", 975, 405, 140, 40)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.setLineStyle("rough")
            love.graphics.setLineWidth(1)
            love.graphics.rectangle("line", 975, 405, 140, 40)
            love.graphics.setFont(font_Afacad24)
            if player.upgrades.nexus.health.level < 41 then
                love.graphics.draw(img_currency_token, 980, 410)
                love.graphics.print(player.upgrades.nexus.health.cost, 1012, 409)
            else
                love.graphics.printf("Max", 975, 409, 140, "center")
            end

            love.graphics.setFont(font_Afacad20)
            love.graphics.setLineStyle("smooth")
            love.graphics.setLineWidth(2)
            love.graphics.rectangle("line", 1130, 250, 150, 200, 4, 4)
            love.graphics.printf("Regeneration", 1130, 250, 150, "center")
            love.graphics.printf(string.format("x%.2f", player.upgrades.nexus.regeneration.value), 1130, 280, 150, "center")
            love.graphics.setColor(0.6, 0.45, 0.25, 1)
            love.graphics.rectangle("fill", 1135, 405, 140, 40)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.setLineStyle("rough")
            love.graphics.setLineWidth(1)
            love.graphics.rectangle("line", 1135, 405, 140, 40)
            love.graphics.setFont(font_Afacad24)
            if player.upgrades.nexus.regeneration.level < 41 then
                love.graphics.draw(img_currency_token, 1140, 410)
                love.graphics.print(player.upgrades.nexus.regeneration.cost, 1172, 409)
            else
                love.graphics.printf("Max", 1135, 409, 140, "center")
            end

            love.graphics.setFont(font_AfacadBold32)
            love.graphics.printf("Gameplay modifiers", 810, 500, 300, "center")

            local gameplayModifiers = {
                {name = "Wave Skip", unlockCost = 10, value = player.modifiers.waveSkip.value, cost = player.modifiers.waveSkip.cost, maxLevel = 10, text = {{1, 1, 1, 1}, "There is a ", {0, 1, 0.7, 1}, string.format("%d%%", player.modifiers.waveSkip.value), {1, 1, 1, 1}, " chance of skipping a wave and immediately advancing to the next wave."}, upgradeText = "Chance", unlock = player.modifiers.waveSkip.unlocked, level = player.modifiers.waveSkip.level},
                {name = "Hyperloop", unlockCost = 15, value = player.modifiers.hyperloop.value, cost = player.modifiers.hyperloop.cost, maxLevel = 11, text = {{1, 1, 1, 1}, "All enemies outside of the tower range are ", {1, 0.5, 0.3, 1}, string.format("%d%%", player.modifiers.hyperloop.value), {1, 1, 1, 1}, " faster."}, upgradeText = "Speed", unlock = player.modifiers.hyperloop.unlocked, level = player.modifiers.hyperloop.level},
            }

            for i=1,2 do
                love.graphics.setFont(font_Afacad20)
                love.graphics.setLineStyle("smooth")
                love.graphics.setLineWidth(2)
                love.graphics.rectangle("line", 650, 550 + 140 * (i - 1), 630, 120, 4, 4)
                love.graphics.setLineStyle("rough")
                love.graphics.setLineWidth(1)
                love.graphics.line(650, 585 + 140 * (i - 1), 1280, 585 + 140 * (i - 1))
                love.graphics.setFont(font_AfacadBold24)
                love.graphics.printf(gameplayModifiers[i].name, 650, 550 + 140 * (i - 1), 630, "center")
                if player.currencies.currentElectrum >= gameplayModifiers[i].cost and gameplayModifiers[i].level < gameplayModifiers[i].maxLevel then
                    love.graphics.setColor(0.6, 0.45, 0.25, 1)
                else
                    love.graphics.setColor(0.35, 0.25, 0.15, 1)
                end
                love.graphics.rectangle("fill", 1155, 590 + 140 * (i - 1), 120, 75)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.setLineStyle("rough")
                love.graphics.setLineWidth(1)
                love.graphics.rectangle("line", 1155, 590 + 140 * (i - 1), 120, 75)
                love.graphics.setColor(0.5, 0.3, 0.1, 1)
                love.graphics.rectangle("fill", 1155, 590 + 140 * (i - 1), 120, 25)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.rectangle("line", 1155, 590 + 140 * (i - 1), 120, 25)
                love.graphics.setFont(font_Afacad20)
                if gameplayModifiers[i].unlock then
                    love.graphics.setFont(font_Afacad20)
                    love.graphics.printf(gameplayModifiers[i].upgradeText, 1155, 589 + 140 * (i - 1), 120, "center")
                    if gameplayModifiers[i].level < gameplayModifiers[i].maxLevel then
                        love.graphics.draw(img_currency_electrum, 1160, 630 + 140 * (i - 1), 0, 20/32)
                        love.graphics.setFont(font_Afacad20)
                        love.graphics.print(notations.convertToLetterNotation(gameplayModifiers[i].cost, "brief"), 1180, 626 + 140 * (i - 1))
                    else
                        love.graphics.setFont(font_Afacad20)
                        love.graphics.printf("Max", 1155, 626 + 140 * (i - 1), 120, "center")
                    end
                else
                    love.graphics.printf("Unlock", 1155, 589 + 140 * (i - 1), 120, "center")
                    love.graphics.draw(img_currency_electrum, 1160, 630 + 140 * (i - 1), 0, 20/32)
                    love.graphics.print(notations.convertToLetterNotation(gameplayModifiers[i].cost, "brief"), 1180, 626 + 140 * (i - 1))
                end
                love.graphics.setFont(font_Afacad20)
                love.graphics.printf(gameplayModifiers[i].text, 660, 585 + 140 * (i - 1), 350, "left")
            end
        end
    end
end

function inHub_mouse(x, y)
    if player.location == "hub" and not player.menu.saveStats then
        
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
        
        --[[ Exit Hub and go to battle ]]--
        if hubSection == "Main" then
            if x >= 860 and x <= 1060 and y >= 900 and y <= 980 then
                player.location = "round"
                gameplay.difficulty = player.difficulty.difficulty
                resetRoundValues()
                towers.reload()
                gameOver = false
                player.menu.paused = false
                gameSpeed = 1
            end
            local levelUnlocks = {player.difficulty.unlocks.d2, player.difficulty.unlocks.d3, player.difficulty.unlocks.d4}
            if x >= 840 and x <= 864 and y >= 746 and y <= 770 and player.difficulty.difficulty > 1 and levelUnlocks[player.difficulty.difficulty - 1] then
                player.difficulty.difficulty = player.difficulty.difficulty - 1
                
            elseif x >= 1056 and x <= 1080 and y >= 746 and y <= 770 and player.difficulty.difficulty < 4 and levelUnlocks[player.difficulty.difficulty] then
                player.difficulty.difficulty = player.difficulty.difficulty + 1
            end

        elseif hubSection == "Science" then

            player.upgrades.science.attackDamage.level, player.upgrades.science.attackDamage.cost, player.tower.attackDamage = processUpgradeModule.upgrade(x, y, upgradeModules["science"]["ATK"][1], reloadFormulae(upgradeModules["science"]["ATK"][1][8] + 1)["science"]["ATK"][1][1], reloadFormulae(upgradeModules["science"]["ATK"][1][8] + 1)["science"]["ATK"][1][2])
            player.upgrades.science.attackSpeed.level, player.upgrades.science.attackSpeed.cost, player.tower.attackSpeed = processUpgradeModule.upgrade(x, y, upgradeModules["science"]["ATK"][2], reloadFormulae(upgradeModules["science"]["ATK"][2][8] + 1)["science"]["ATK"][2][1], reloadFormulae(upgradeModules["science"]["ATK"][2][8] + 1)["science"]["ATK"][2][2])
            player.upgrades.science.critChance.level, player.upgrades.science.critChance.cost, player.tower.critChance = processUpgradeModule.upgrade(x, y, upgradeModules["science"]["ATK"][3], reloadFormulae(upgradeModules["science"]["ATK"][3][8] + 1)["science"]["ATK"][3][1], reloadFormulae(upgradeModules["science"]["ATK"][3][8] + 1)["science"]["ATK"][3][2])
            player.upgrades.science.critFactor.level, player.upgrades.science.critFactor.cost, player.tower.critFactor = processUpgradeModule.upgrade(x, y, upgradeModules["science"]["ATK"][4], reloadFormulae(upgradeModules["science"]["ATK"][4][8] + 1)["science"]["ATK"][4][1], reloadFormulae(upgradeModules["science"]["ATK"][4][8] + 1)["science"]["ATK"][4][2])
            player.upgrades.science.range.level, player.upgrades.science.range.cost, player.tower.range = processUpgradeModule.upgrade(x, y, upgradeModules["science"]["ATK"][5], reloadFormulae(upgradeModules["science"]["ATK"][5][8] + 1)["science"]["ATK"][5][1], reloadFormulae(upgradeModules["science"]["ATK"][5][8] + 1)["science"]["ATK"][5][2])

            player.upgrades.science.health.level, player.upgrades.science.health.cost, player.tower.maxHealth = processUpgradeModule.upgrade(x, y, upgradeModules["science"]["VIT"][1], reloadFormulae(upgradeModules["science"]["VIT"][1][8] + 1)["science"]["VIT"][1][1], reloadFormulae(upgradeModules["science"]["VIT"][1][8] + 1)["science"]["VIT"][1][2])
            player.upgrades.science.regeneration.level, player.upgrades.science.regeneration.cost, player.tower.regeneration = processUpgradeModule.upgrade(x, y, upgradeModules["science"]["VIT"][2], reloadFormulae(upgradeModules["science"]["VIT"][2][8] + 1)["science"]["VIT"][2][1], reloadFormulae(upgradeModules["science"]["VIT"][2][8] + 1)["science"]["VIT"][2][2])
            player.upgrades.science.resistance.level, player.upgrades.science.resistance.cost, player.tower.resistance = processUpgradeModule.upgrade(x, y, upgradeModules["science"]["VIT"][3], reloadFormulae(upgradeModules["science"]["VIT"][3][8] + 1)["science"]["VIT"][3][1], reloadFormulae(upgradeModules["science"]["VIT"][3][8] + 1)["science"]["VIT"][3][2])
            player.upgrades.science.shieldCooldown.level, player.upgrades.science.shieldCooldown.cost, player.tower.shieldCooldown = processUpgradeModule.upgrade(x, y, upgradeModules["science"]["VIT"][4], reloadFormulae(upgradeModules["science"]["VIT"][4][8] + 1)["science"]["VIT"][4][1], reloadFormulae(upgradeModules["science"]["VIT"][4][8] + 1)["science"]["VIT"][4][2])
            player.upgrades.science.shieldDuration.level, player.upgrades.science.shieldDuration.cost, player.tower.shieldDuration = processUpgradeModule.upgrade(x, y, upgradeModules["science"]["VIT"][5], reloadFormulae(upgradeModules["science"]["VIT"][5][8] + 1)["science"]["VIT"][5][1], reloadFormulae(upgradeModules["science"]["VIT"][5][8] + 1)["science"]["VIT"][5][2])
            player.upgrades.science.meteorAmount.level, player.upgrades.science.meteorAmount.cost, player.tower.meteorAmount = processUpgradeModule.upgrade(x, y, upgradeModules["science"]["VIT"][6], reloadFormulae(upgradeModules["science"]["VIT"][6][8] + 1)["science"]["VIT"][6][1], reloadFormulae(upgradeModules["science"]["VIT"][6][8] + 1)["science"]["VIT"][6][2])
            player.upgrades.science.meteorRPM.level, player.upgrades.science.meteorRPM.cost, player.tower.meteorRPM = processUpgradeModule.upgrade(x, y, upgradeModules["science"]["VIT"][7], reloadFormulae(upgradeModules["science"]["VIT"][7][8] + 1)["science"]["VIT"][7][1], reloadFormulae(upgradeModules["science"]["VIT"][7][8] + 1)["science"]["VIT"][7][2])

            player.upgrades.science.copperPerWave.level, player.upgrades.science.copperPerWave.cost, player.tower.copperPerWave = processUpgradeModule.upgrade(x, y, upgradeModules["science"]["UTL"][1], reloadFormulae(upgradeModules["science"]["UTL"][1][8] + 1)["science"]["UTL"][1][1], reloadFormulae(upgradeModules["science"]["UTL"][1][8] + 1)["science"]["UTL"][1][2])
            player.upgrades.science.silverPerWave.level, player.upgrades.science.silverPerWave.cost, player.tower.silverPerWave = processUpgradeModule.upgrade(x, y, upgradeModules["science"]["UTL"][2], reloadFormulae(upgradeModules["science"]["UTL"][2][8] + 1)["science"]["UTL"][2][1], reloadFormulae(upgradeModules["science"]["UTL"][2][8] + 1)["science"]["UTL"][2][2])
            player.upgrades.science.copperBonus.level, player.upgrades.science.copperBonus.cost, player.tower.copperBonus = processUpgradeModule.upgrade(x, y, upgradeModules["science"]["UTL"][3], reloadFormulae(upgradeModules["science"]["UTL"][3][8] + 1)["science"]["UTL"][3][1], reloadFormulae(upgradeModules["science"]["UTL"][3][8] + 1)["science"]["UTL"][3][2])
            player.upgrades.science.silverBonus.level, player.upgrades.science.silverBonus.cost, player.tower.silverBonus = processUpgradeModule.upgrade(x, y, upgradeModules["science"]["UTL"][4], reloadFormulae(upgradeModules["science"]["UTL"][4][8] + 1)["science"]["UTL"][4][1], reloadFormulae(upgradeModules["science"]["UTL"][4][8] + 1)["science"]["UTL"][4][2])

            unlockPanelsPressed = 0
            player.upgrades.unlocks.crit = processUnlockPanel.clickCheck(x, y, unlockPanels["crit"])
            player.upgrades.unlocks.range = processUnlockPanel.clickCheck(x, y, unlockPanels["range"])
            player.upgrades.unlocks.resistance = processUnlockPanel.clickCheck(x, y, unlockPanels["resistance"])
            player.upgrades.unlocks.shield = processUnlockPanel.clickCheck(x, y, unlockPanels["shield"])
            player.upgrades.unlocks.meteor = processUnlockPanel.clickCheck(x, y, unlockPanels["meteor"])
            player.upgrades.unlocks.resourceBonus = processUnlockPanel.clickCheck(x, y, unlockPanels["resourceBonus"])

        elseif hubSection == "Nexus" then
            --[[ If in Nexus, clicking the Alloy button starts the Electrum alloying process after spending 400 Silver and 2 Gold ]]--
            if x >= 1655 and x <= 1795 and y >= 265 and y <= 295 then
                if player.currencies.currentSilver >= 400 and player.currencies.currentGold >= 2 and player.canClaim.electrum then
                    player.canClaim.electrum = false
                    player.timers.electrum = 0
                    player.currencies.currentSilver = player.currencies.currentSilver - 400
                    player.currencies.currentGold = player.currencies.currentGold - 2
                end
            end

            --[[ Claiming tokens ]]--
            if x >= 1455 and x <= 1645 and y >= 265 and y <= 295 then
                if player.canClaim.tokens then
                    player.currencies.currentTokens = player.currencies.currentTokens + 15
                    player.canClaim.tokens = false
                    player.timers.tokens = 0
                end
            end

            --[[ Attack Damage stat buff ]]--
            if x >= 655 and x <= 795 and y >= 405 and y <= 445 then
                if player.currencies.currentTokens >= player.upgrades.nexus.attackDamage.cost and player.upgrades.nexus.attackDamage.level < 41 then
                    player.currencies.currentTokens = player.currencies.currentTokens - player.upgrades.nexus.attackDamage.cost
                    player.upgrades.nexus.attackDamage.level = player.upgrades.nexus.attackDamage.level + 1
                    player.upgrades.nexus.attackDamage.cost = 20 + ((player.upgrades.nexus.attackDamage.level * (player.upgrades.nexus.attackDamage.level - 1)) / 2) * 5
                    player.upgrades.nexus.attackDamage.value = math.min(1 + (player.upgrades.nexus.attackDamage.level - 1) * 10/100, 5)
                    player.tower.attackDamage = ((0.25 * player.upgrades.science.attackDamage.level - 0.25)^3 + 4 + player.upgrades.science.attackDamage.level) * player.upgrades.nexus.attackDamage.value
                    player.stats.save.upgradesAcquired.nexus = player.stats.save.upgradesAcquired.nexus + 1
                end
                processUpgradeModule.reload()
            end

            --[[ Attack Speed stat buff ]]--
            if x >= 815 and x <= 955 and y >= 405 and y <= 445 then
                if player.currencies.currentTokens >= player.upgrades.nexus.attackSpeed.cost and player.upgrades.nexus.attackSpeed.level < 26 then
                    player.currencies.currentTokens = player.currencies.currentTokens - player.upgrades.nexus.attackSpeed.cost
                    player.upgrades.nexus.attackSpeed.level = player.upgrades.nexus.attackSpeed.level + 1
                    player.upgrades.nexus.attackSpeed.cost = 20 + ((player.upgrades.nexus.attackSpeed.level * (player.upgrades.nexus.attackSpeed.level - 1)) / 2) * 5
                    player.upgrades.nexus.attackSpeed.value = math.min(1 + (player.upgrades.nexus.attackSpeed.level - 1) * 4/100, 2)
                    player.tower.attackSpeed = (math.min(0.5 + 0.04 * (player.upgrades.science.attackSpeed.level - 1), 4.5)) * player.upgrades.nexus.attackSpeed.value
                    player.stats.save.upgradesAcquired.nexus = player.stats.save.upgradesAcquired.nexus + 1
                end
                processUpgradeModule.reload()
            end

            --[[ Health stat buff ]]--
            if x >= 975 and x <= 1115 and y >= 405 and y <= 445 then
                if player.currencies.currentTokens >= player.upgrades.nexus.health.cost and player.upgrades.nexus.health.level < 41 then
                    player.currencies.currentTokens = player.currencies.currentTokens - player.upgrades.nexus.health.cost
                    player.upgrades.nexus.health.level = player.upgrades.nexus.health.level + 1
                    player.upgrades.nexus.health.cost = 20 + ((player.upgrades.nexus.health.level * (player.upgrades.nexus.health.level - 1)) / 2) * 5
                    player.upgrades.nexus.health.value = math.min(1 + (player.upgrades.nexus.health.level - 1) * 10/100, 5)
                    player.tower.maxHealth = ((0.3 * player.upgrades.science.health.level - 0.3)^3.75 + 14.6 + 0.4 * player.upgrades.science.health.level) * player.upgrades.nexus.health.value
                    player.stats.save.upgradesAcquired.nexus = player.stats.save.upgradesAcquired.nexus + 1
                end
                processUpgradeModule.reload()
            end

            --[[ Regeneration stat buff ]]--
            if x >= 1135 and x <= 1275 and y >= 405 and y <= 445 then
                if player.currencies.currentTokens >= player.upgrades.nexus.regeneration.cost and player.upgrades.nexus.regeneration.level < 41 then
                    player.currencies.currentTokens = player.currencies.currentTokens - player.upgrades.nexus.regeneration.cost
                    player.upgrades.nexus.regeneration.level = player.upgrades.nexus.regeneration.level + 1
                    player.upgrades.nexus.regeneration.cost = 20 + ((player.upgrades.nexus.regeneration.level * (player.upgrades.nexus.regeneration.level - 1)) / 2) * 5
                    player.upgrades.nexus.regeneration.value = math.min(1 + (player.upgrades.nexus.regeneration.level - 1) * 10/100, 5)
                    player.tower.regeneration = (((0.8 * player.upgrades.science.regeneration.level - 0.8)^2.75) / 50) * player.upgrades.nexus.regeneration.value
                    player.stats.save.upgradesAcquired.nexus = player.stats.save.upgradesAcquired.nexus + 1
                end
                processUpgradeModule.reload()
            end

            if x >= 1155 and x <= 1275 and y >= 615 and y <= 665 then
                if player.currencies.currentElectrum >= player.modifiers.waveSkip.cost and player.modifiers.waveSkip.level < 10 then
                    if player.modifiers.waveSkip.unlocked then
                        player.currencies.currentElectrum = player.currencies.currentElectrum - player.modifiers.waveSkip.cost
                        player.modifiers.waveSkip.level = player.modifiers.waveSkip.level + 1
                        player.modifiers.waveSkip.cost = (player.modifiers.waveSkip.level * (player.modifiers.waveSkip.level - 1)) / 2 + 4
                        player.modifiers.waveSkip.value = math.min(4 * player.modifiers.waveSkip.level, 40)
                    else
                        player.currencies.currentElectrum = player.currencies.currentElectrum - 10
                        player.modifiers.waveSkip.unlocked = true
                        player.modifiers.waveSkip.cost = (player.modifiers.waveSkip.level * (player.modifiers.waveSkip.level - 1)) / 2 + 4
                        player.modifiers.waveSkip.value = 4
                    end
                end
            elseif x >= 1155 and x <= 1275 and y >= 755 and y <= 805 then
                if player.currencies.currentElectrum >= player.modifiers.hyperloop.cost and player.modifiers.hyperloop.level < 11 then
                    if player.modifiers.waveSkip.unlocked then
                        player.currencies.currentElectrum = player.currencies.currentElectrum - player.modifiers.hyperloop.cost
                        player.modifiers.hyperloop.level = player.modifiers.hyperloop.level + 1
                        player.modifiers.hyperloop.cost = player.modifiers.hyperloop.level^2 - 2 * player.modifiers.hyperloop.level + 11
                        player.modifiers.hyperloop.value = math.min(2 + 8 * player.modifiers.hyperloop.level, 90)
                    else
                        player.currencies.currentElectrum = player.currencies.currentElectrum - 15
                        player.modifiers.hyperloop.unlocked = true
                        player.modifiers.hyperloop.cost = player.modifiers.hyperloop.level^2 - 2 * player.modifiers.hyperloop.level + 11
                        player.modifiers.hyperloop.value = 10
                    end
                end
            end
        end
    end
end