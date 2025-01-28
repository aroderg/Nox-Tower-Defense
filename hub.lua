local hubSections = {"Main", "Science", "Nexus", "Abilities"}
local rolledClass
local rolledInternalAbility
local rolledAbility
local abilitiesFromRolledClass = {}

--- Draws all of the Hub visuals.
function inHub_visual()    
    if player.location == "hub" then
        love.graphics.setLineWidth(1)
        love.graphics.setFont(font_Afacad24)
        love.graphics.setLineStyle("smooth")
        love.graphics.setColor(0, 0, 0.2, 1)
        love.graphics.rectangle("fill", 0, 0, 1920, 1080)

        local hubColors = {{0.65, 0.5, 0}, {0, 0.65, 0.3}, {0.5, 0, 0.6}, {0.8, 0.2, 0.2}}
        for i=1,#hubSections do
            love.graphics.setColor(hubColors[i])
            love.graphics.rectangle("fill", 0, (1080 / #hubSections) * (i - 1), 50, 1080 / #hubSections)
            love.graphics.setColor(1, 1, 1, 1)
            if hubSection == hubSections[i] then
                love.graphics.setColor(1, 0, 0, 1)
            end
            love.graphics.rectangle("line", 51, (1080 / #hubSections) * (i - 1) + 1, 100, 40, 2, 2)
            love.graphics.printf(hubSections[i], 50, (1080 / #hubSections) * (i - 1) + 3, 100, "center")
        end

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

        local hubLore = {
            "View and analyze your tower's initial properties and other statistics.",
            "Upgrade your tower's initial properties and unlock new upgrades to push your limits even further.",
            "Unlock unique modifiers and get powerful stat buffs.",
            "Get passive and active abilities to use in battles and other challenges."
        }
        for i=1,#hubSections do
            if hubSection == hubSections[i] then
                love.graphics.setFont(font_AfacadBold48)
                love.graphics.printf(hubSections[i], 810, 50, 300, "center")
                love.graphics.setFont(font_Afacad20)
                love.graphics.printf(hubLore[i], 760, 120, 400, "center")
            end
        end
        if hubSection == "Main" then
            love.graphics.setFont(font_AfacadSemiBold28)
            love.graphics.printf(string.format("Difficulty %d", player.difficulty.difficulty), 810, 738, 300, "center")
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

            love.graphics.setLineStyle("rough")
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

            love.graphics.setLineStyle("smooth")
            love.graphics.setLineWidth(2)

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
            local nexusBuffs = {
                {name = "Attack Damage", maxLevel = 41, currentLevel = player.upgrades.nexus.attackDamage.level, cost = player.upgrades.nexus.attackDamage.cost, value = player.upgrades.nexus.attackDamage.value},
                {name = "Attack Speed", maxLevel = 26, currentLevel = player.upgrades.nexus.attackSpeed.level, cost = player.upgrades.nexus.attackSpeed.cost, value = player.upgrades.nexus.attackSpeed.value},
                {name = "Health", maxLevel = 41, currentLevel = player.upgrades.nexus.health.level, cost = player.upgrades.nexus.health.cost, value = player.upgrades.nexus.health.value},
                {name = "Regeneration", maxLevel = 41, currentLevel = player.upgrades.nexus.regeneration.level, cost = player.upgrades.nexus.regeneration.cost, value = player.upgrades.nexus.regeneration.value}
            }
            for i,v in pairs(nexusBuffs) do
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.setLineStyle("smooth")
                love.graphics.setLineWidth(2)
                love.graphics.setFont(font_Afacad20)
                love.graphics.rectangle("line", 650 + (i - 1) * 160, 250, 150, 200, 4, 4)
                love.graphics.printf(v.name, 650 + (i - 1) * 160, 250, 150, "center")
                love.graphics.printf(string.format("x%.2f", v.value), 650 + (i - 1) * 160, 280, 150, "center")
                love.graphics.setColor(0.6, 0.45, 0.25, 1)
                love.graphics.rectangle("fill", 655 + (i - 1) * 160, 405, 140, 40)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.setLineStyle("rough")
                love.graphics.setLineWidth(1)
                love.graphics.rectangle("line", 655 + (i - 1) * 160, 405, 140, 40)
                love.graphics.setFont(font_Afacad24)
                if v.currentLevel < v.maxLevel then
                    love.graphics.draw(img_currency_token, 660 + (i - 1) * 160, 410)
                    love.graphics.print(v.cost, 692 + (i - 1) * 160, 409)
                else
                    love.graphics.printf("Max", 655 + (i - 1) * 160, 409, 140, "center")
                end
            end

            love.graphics.setFont(font_AfacadBold32)
            love.graphics.printf("Gameplay modifiers", 810, 500, 300, "center")

            local gameplayModifiers = {
                {name = "Wave Skip", unlockCost = 10, value = player.modifiers.waveSkip.value, cost = player.modifiers.waveSkip.cost, maxLevel = 10, text = {{1, 1, 1, 1}, "There is a ", {0, 1, 0.7, 1}, string.format("%d%%", player.modifiers.waveSkip.value), {1, 1, 1, 1}, " chance of skipping a wave and immediately advancing to the next wave."}, upgradeText = "Chance", unlocked = player.modifiers.waveSkip.unlocked, level = player.modifiers.waveSkip.level},
                {name = "Hyperloop", unlockCost = 15, value = player.modifiers.hyperloop.value, cost = player.modifiers.hyperloop.cost, maxLevel = 11, text = {{1, 1, 1, 1}, "All enemies outside of the tower range are ", {1, 0.5, 0.3, 1}, string.format("%d%%", player.modifiers.hyperloop.value), {1, 1, 1, 1}, " faster."}, upgradeText = "Speed", unlocked = player.modifiers.hyperloop.unlocked, level = player.modifiers.hyperloop.level},
            }

            for i,v in pairs(gameplayModifiers) do
                love.graphics.setFont(font_Afacad20)
                love.graphics.setLineStyle("smooth")
                love.graphics.setLineWidth(2)
                love.graphics.rectangle("line", 650, 550 + 140 * (i - 1), 630, 120, 4, 4)
                love.graphics.setLineStyle("rough")
                love.graphics.setLineWidth(1)
                love.graphics.line(650, 585 + 140 * (i - 1), 1280, 585 + 140 * (i - 1))
                love.graphics.setFont(font_AfacadBold24)
                love.graphics.printf(v.name, 650, 550 + 140 * (i - 1), 630, "center")
                if player.currencies.currentElectrum >= v.cost and v.level < v.maxLevel then
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
                if v.unlocked then
                    love.graphics.setFont(font_Afacad20)
                    love.graphics.printf(v.upgradeText, 1155, 589 + 140 * (i - 1), 120, "center")
                    if v.level < v.maxLevel then
                        love.graphics.draw(img_currency_electrum, 1160, 630 + 140 * (i - 1), 0, 20/32)
                        love.graphics.setFont(font_Afacad20)
                        love.graphics.print(notations.convertToLetterNotation(v.cost, "brief"), 1180, 626 + 140 * (i - 1))
                    else
                        love.graphics.setFont(font_Afacad20)
                        love.graphics.printf("Max", 1155, 626 + 140 * (i - 1), 120, "center")
                    end
                else
                    love.graphics.printf("Unlock", 1155, 589 + 140 * (i - 1), 120, "center")
                    love.graphics.draw(img_currency_electrum, 1160, 630 + 140 * (i - 1), 0, 20/32)
                    love.graphics.print(notations.convertToLetterNotation(v.cost, "brief"), 1180, 626 + 140 * (i - 1))
                end
                love.graphics.setFont(font_Afacad20)
                love.graphics.printf(v.text, 660, 585 + 140 * (i - 1), 350, "left")
            end

        elseif hubSection == "Abilities" then
            love.graphics.setFont(font_AfacadBold24)
            love.graphics.printf(string.format("Equipped: %d/%d", player.abilities.equipped, player.abilities.maxEquipped), 860, 200, 200, "center")
            love.graphics.draw(img_button_questionMark, 1040, 205)
            love.graphics.setColor(0.2, 0, 0.3, 1)
            love.graphics.rectangle("fill", 810, 250, 300, 60)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.setLineStyle("rough")
            love.graphics.setLineWidth(1)
            love.graphics.setFont(font_Afacad20)
            love.graphics.print("Assemble an Ability", 815, 265)
            love.graphics.rectangle("line", 810, 250, 300, 60)
            if not player.misc.abilityAssembling then
                love.graphics.setColor(0.3, 0, 0.45, 1)
            else
                love.graphics.setColor(0.15, 0, 0.25, 1)
            end
            love.graphics.rectangle("fill", 1017, 253, 90, 54)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.rectangle("line", 1017, 253, 90, 54)
            if not player.misc.abilityAssembling then
                love.graphics.draw(img_currency_token, 1021, 268, 0, 24/32)
                love.graphics.print("60", 1045, 266)
            elseif player.misc.abilityAssembling and player.timers.abilityAssembly < player.cooldowns.abilityAssembly_current then
                love.graphics.setFont(font_Afacad16)
                love.graphics.printf("Assembling...", 1017, 268, 90, "center")
                love.graphics.setFont(font_Afacad20)
            else
                love.graphics.setFont(font_Afacad20)
                love.graphics.printf("Ready!", 1017, 266, 90, "center")
            end
            love.graphics.draw(img_button_questionMark, 1110, 268)
            if player.misc.abilityAssembling and player.timers.abilityAssembly < player.cooldowns.abilityAssembly_current then
                love.graphics.setColor(1, 0, 0, 1)
                love.graphics.rectangle("fill", 810, 320, 300, 8)
                love.graphics.setColor(0, 1, 0, 1)
                love.graphics.rectangle("fill", 810, 320, (player.timers.abilityAssembly / player.cooldowns.abilityAssembly_current) * 300, 8)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.printf(string.format("%dm %ds", (player.cooldowns.abilityAssembly_current - player.timers.abilityAssembly) / 60, (player.cooldowns.abilityAssembly_current - player.timers.abilityAssembly) % 60), 860, 325, 200, "center")
            end
                if not abilityFunctions.checkMenuDisplay() and not player.menu.rolledAbilityDisplay then
                tooltips.displayAbilityInfo()
            end
            for i,v in pairs(internalAbilities) do
                --Draw the brief ("Card") appearance of the Ability.
                love.graphics.setLineStyle("rough")
                love.graphics.setColor(1, 1, 1, 0.25 + 0.75 * (v.unlocked and 1 or 0))
                love.graphics.draw(v.preview, abilityFunctions.calculateOffset(i), 430 + math.floor((i - 1) / 5) * 230)
                love.graphics.setColor(1, 1, 1, 0.5)
                love.graphics.setLineWidth(1)
                love.graphics.rectangle("line", abilityFunctions.calculateOffset(i), 430 + math.floor((i - 1) / 5) * 230, 150, 100)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.setLineWidth(2)
                love.graphics.setLineStyle("smooth")
                local borderColor = v.level < #v.levelRequirements - 1 and {1, 1, 1, 1} or {1, 0.5, 0, 1}
                love.graphics.setColor(borderColor)
                love.graphics.rectangle("line", abilityFunctions.calculateOffset(i), 400 + math.floor((i - 1) / 5) * 230, 150, 200, 2, 2)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.setFont(font_AfacadBold20)
                love.graphics.printf(v.name, abilityFunctions.calculateOffset(i), 400 + math.floor((i - 1) / 5) * 230, 150, "center")
                love.graphics.setFont(font_Afacad20)
                love.graphics.printf("Level " .. v.level, abilityFunctions.calculateOffset(i), 535 + math.floor((i - 1) / 5) * 230, 150, "center")
                love.graphics.setLineWidth(1)
                love.graphics.setLineStyle("rough")
                love.graphics.setFont(font_Afacad16)
                love.graphics.rectangle("line", abilityFunctions.calculateOffset(i) + 5, 570 + math.floor((i - 1) / 5) * 230, 70, 25)
                love.graphics.printf("Info", abilityFunctions.calculateOffset(i) + 5, 571 + math.floor((i - 1) / 5) * 230, 70, "center")
                love.graphics.rectangle("line", abilityFunctions.calculateOffset(i) + 76, 570 + math.floor((i - 1) / 5) * 230, 70, 25)
                love.graphics.printf(not v.equipped and "Equip" or "Unequip", abilityFunctions.calculateOffset(i) + 76, 571 + math.floor((i - 1) / 5) * 230, 70, "center")
            end
            for i,v in pairs(internalAbilities) do
                abilityFunctions.showInfo.draw(v)
            end
            if player.menu.rolledAbilityDisplay then
                love.graphics.setColor(0, 0, 0, 0.5)
                love.graphics.rectangle("fill", 0, 0, 1920, 1080)
                love.graphics.setColor(0.15, 0, 0.3, 1)
                love.graphics.rectangle("fill", 660, 390, 600, 300, 2, 2)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.setLineStyle("smooth")
                love.graphics.setLineWidth(1)
                love.graphics.draw(abilitiesFromRolledClass[rolledAbility].preview, 675, 405)
                love.graphics.rectangle("line", 675, 405, 150, 100, 2, 2)
                love.graphics.rectangle("line", 660, 390, 600, 300, 2, 2)
                love.graphics.setFont(font_AfacadSemiBold24)
                love.graphics.printf({{1, 1, 1, 1}, "Assembled: ", {0.75, 0.55, 1, 1}, abilitiesFromRolledClass[rolledAbility].name}, 825, 398, 435, "center")
                love.graphics.setFont(font_Afacad20)
                love.graphics.printf(abilitiesFromRolledClass[rolledAbility].effect, 845, 435, 400, "left")
                local classColor =
                    abilitiesFromRolledClass[rolledAbility].class == "D" and {0.6, 0.5, 0.3, 1} or
                    abilitiesFromRolledClass[rolledAbility].class == "C" and {0.45, 0.66, 0.75, 1} or
                    abilitiesFromRolledClass[rolledAbility].class == "B" and {0.35, 0.8, 0.75, 1} or
                    abilitiesFromRolledClass[rolledAbility].class == "A" and {0.25, 0.9, 0.75, 1} or
                    {1, 1, 1, 1}
                local amountColor =
                    abilitiesFromRolledClass[rolledAbility].amount < abilitiesFromRolledClass[rolledAbility].nextLevelRequirement and {1, 0.4, 0.35, 1} or
                    {0.35, 1, 0.5, 1}
                love.graphics.printf({{1, 1, 1, 1}, "Class: ", classColor, abilitiesFromRolledClass[rolledAbility].class}, 675, 515, 150, "center")
                love.graphics.printf({{1, 1, 1, 1}, "Amount: ", amountColor, abilitiesFromRolledClass[rolledAbility].amount, {1, 1, 1, 1}, "/", {0.35, 1, 0.5, 1}, abilitiesFromRolledClass[rolledAbility].nextLevelRequirement}, 675, 535, 150, "center")
                love.graphics.setColor(0.1, 0.15, 0.5, 1)
                love.graphics.rectangle("fill", 920, 645, 80, 35, 2, 2)
                love.graphics.setColor(0.3, 0.75, 0.85, 1)
                love.graphics.setLineWidth(2)
                love.graphics.rectangle("line", 920, 645, 80, 35, 2, 2)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.setFont(font_Afacad24)
                love.graphics.printf("Back", 920, 646, 80, "center")
            end
        end
    end
end

abilityFunctions = {
    showInfo = {}
}

--- Calculates an offset that is used to center all the Abilities while in the "Ability" Hub section.
---@param n number The number of the Ability.
function abilityFunctions.calculateOffset(n)
    local alignmentOffset = 0
    if n <= 5 then
        alignmentOffset = (1920 - ((math.min(#internalAbilities, 6) * 150) + ((math.min(#internalAbilities - 1, 5)) * 30))) / 2
        return alignmentOffset + (n % 6 - 0.5) * 180
    else
        alignmentOffset = 1920 - (((n + 1) * 150) + ((n - 0.5) * 30))
        return alignmentOffset + (n % 6 - 0.5) * 360
    end
end

--- Draw the detailed ("Panel") appearance of the Ability.
---@param ability table The Ability to draw.
function abilityFunctions.showInfo.draw(ability)
    if ability.menu then
        love.graphics.setColor(0, 0, 0, 0.5)
        love.graphics.rectangle("fill", 0, 0, 1920, 1080)
        love.graphics.setColor(0.15, 0, 0.3, 1)
        love.graphics.rectangle("fill", 660, 340, 600, 400, 2, 2)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setLineStyle("smooth")
        love.graphics.setLineWidth(1)
        love.graphics.setFont(font_Afacad24)
        love.graphics.setColor(1, 1, 1, 0.25 + 0.75 * (ability.unlocked and 1 or 0))
        love.graphics.draw(ability.preview, 885, 360)
        love.graphics.setFont(font_AfacadBold24)
        love.graphics.printf(ability.name, 810, 470, 300, "center")
        love.graphics.setFont(font_Afacad24)
        if ability.level < #ability.levelRequirements - 1 then
            love.graphics.printf("Level " .. ability.level .. string.format(" (%d/%d)", ability.amount, ability.nextLevelRequirement), 670, 355, 216, "center")
        else
            love.graphics.printf("Level " .. ability.level .. string.format(" (%d)", ability.amount), 670, 355, 216, "center")
        end
        love.graphics.setFont(font_Afacad20)
        love.graphics.setLineWidth(1)
        if ability.level < #ability.levelRequirements - 1 then
            love.graphics.setColor(1, 0, 0, 1)
            love.graphics.rectangle("fill", 708, 390, 140, 8)
            love.graphics.setColor(0, 1, 0, 1)
            love.graphics.rectangle("fill", 708, 390, math.min(ability.amount / ability.levelRequirements[ability.level + 1], 1) * 140, 8)
        end
        love.graphics.setLineStyle("rough")
        love.graphics.setColor(0.25, 0, 0.4, 1)
        love.graphics.rectangle("fill", 700, 418, 156, 40)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.rectangle("line", 700, 418, 156, 40)
        if ability.level < #ability.levelRequirements - 1 then
            love.graphics.printf(string.format("Enhance (lvl %d)", ability.level + 1), 700, 424, 156, "center")
        else
            love.graphics.printf("Max level!", 700, 424, 156, "center")
        end
        local classColor =
            ability.class == "D" and {0.6, 0.5, 0.3, 1} or
            ability.class == "C" and {0.45, 0.66, 0.75, 1} or
            ability.class == "B" and {0.35, 0.8, 0.75, 1} or
            ability.class == "A" and {0.25, 0.9, 0.75, 1} or
            {1, 1, 1, 1}
        local freqSuffix = ability.tags.condition == "Time" and "s" or (ability.tags.condition == "Projectile Fired" or ability.tags.condition == "Wave Start") and "%" or ""
        local rowOffset = freqSuffix ~= "" and -16 or 0
        love.graphics.printf({{1, 1, 1, 1}, "Class: ", classColor, ability.class}, 1035, 381 + rowOffset, 224, "center")
        love.graphics.printf({{1, 0.75, 0.5, 1}, table.len(ability.tags), {1, 1, 1, 1}, " tags"}, 1035, 411 + rowOffset, 224, "center")
        love.graphics.draw(img_button_questionMark, 1180, 414 + rowOffset)
        --love.graphics.printf("Event: " .. ability.event, 1035, 385, 224, "center")
        --love.graphics.printf({{1, 1, 1, 1}, "Frequency: ", {0.35, 0.95, 0.7, 1}, not ability.guaranteed and ability.frequency or string.format("1/%d", ability.frequency), {1, 1, 1, 1}, ability.guaranteed and "(G)" or "", {1, 1, 1, 1}, ability.event == "Time" and "s" or not ability.guaranteed and "%" or ""}, 1035, 415, 224, "center")
        if freqSuffix ~= "" then
            love.graphics.printf("Frequency: " .. ability.frequency .. freqSuffix, 1035, 441 + rowOffset, 224, "center")
        end
        love.graphics.setLineWidth(1)
        love.graphics.setLineStyle("smooth")
        love.graphics.printf(ability.effect, 680, 510, 560, "left")
        love.graphics.rectangle("line", 885, 360, 150, 100, 2, 2)
        love.graphics.rectangle("line", 660, 340, 600, 400, 2, 2)
        love.graphics.setColor(0.1, 0.15, 0.5, 1)
        love.graphics.rectangle("fill", 910, 680, 100, 40, 2, 2)
        love.graphics.setColor(0.3, 0.75, 0.85, 1)
        love.graphics.setLineWidth(2)
        love.graphics.rectangle("line", 910, 680, 100, 40, 2, 2)
        love.graphics.setFont(font_Afacad24)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf("Back", 910, 682, 100, "center")
        tooltips.displayAbilityTags()
    end
end

--- Equip or unequip the given Ability.
---@param x number Mouse cursor position (horizontal).
---@param y number Mouse cursor position (vertical).
---@param ax number The horizontal position of the Ability.
---@param ay number The vertical position of the Ability.
---@param ability table The Ability to equip or unequip.
function abilityFunctions.changeEquipState(x, y, ax, ay, ability)
    if x >= ax and x <= ax + 70 and y >= ay and y <= ay + 25 then
        if ability.unlocked and (ability.equipped and (player.abilities.equipped <= player.abilities.maxEquipped) or (player.abilities.equipped < player.abilities.maxEquipped)) and not ability.menu and not player.menu.rolledAbilityDisplay and abilityFunctions.checkForCompatibility(ability) then
            return not ability.equipped
        else
            return ability.equipped
        end
    else
        return ability.equipped
    end
end

function abilityFunctions.checkForCompatibility(ability)
    local compatible = true
    if ability.tags.incompatibilities then
        for i,v in pairs(ability.tags.incompatibilities) do
            if player.abilities[v].equipped then
                compatible = false
            end
        end
    end
    return compatible
end

--- Returns true if any Ability info menu is shown, used for checking if a click on any other button is valid.
function abilityFunctions.checkMenuDisplay()
    local abilityMenuShown = false

    for i=1,#internalAbilities do
        if internalAbilities[i].menu == true then
            abilityMenuShown = true
        end
    end
    return abilityMenuShown
end

--- Process if the Info button is pressed and open the Ability info menu if so. Additionally, processes the Back button press if the menu is opened.
---@param x number Mouse cursor position (horizontal).
---@param y number Mouse cursor position (vertical).
---@param ax number The horizontal position of the Ability.
---@param ay number The horizontal position of the Ability.
---@param ability table The Ability which menu is influenced.
function abilityFunctions.showInfo.process(x, y, ax, ay, ability)
    if ability.unlocked then
        if x >= ax and x <= ax + 70 and y >= ay and y <= ay + 25 and not ability.menu and not abilityFunctions.checkMenuDisplay() then
            return true
        end
        if x >= 910 and x <= 1010 and y >= 680 and y <= 720 and ability.menu and abilityFunctions.checkMenuDisplay() then
            return false
        elseif ability.menu then
            return true
        end
    end
end

--- Process all the mouse and button clicks while in Hub.
---@param x number Mouse cursor position (horizontal).
---@param y number Mouse cursor position (vertical).
function inHub_mouse(x, y)
    if player.location == "hub" and not player.menu.saveStats then
        
        --[[ Process mouse clicks on sidebar, go to different sections based on the button pressed ]]--

        for i=1,#hubSections do
            if x >= 0 and x <= 50 and y >= (1080 / #hubSections) * (i - 1) and y <= (1080 / #hubSections) * i and not abilityFunctions.checkMenuDisplay() and not player.menu.rolledAbilityDisplay then
                hubSection = hubSections[i]
            end
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
                gameplay.gameSpeed = player.maxGameSpeed
            end
            local levelUnlocks = {player.difficulty.unlocks.d2, player.difficulty.unlocks.d3, player.difficulty.unlocks.d4}
            if x >= 840 and x <= 864 and y >= 746 and y <= 770 and player.difficulty.difficulty > 1 and levelUnlocks[player.difficulty.difficulty - 1] then
                player.difficulty.difficulty = player.difficulty.difficulty - 1
                
            elseif x >= 1056 and x <= 1080 and y >= 746 and y <= 770 and player.difficulty.difficulty < 4 and levelUnlocks[player.difficulty.difficulty] then
                player.difficulty.difficulty = player.difficulty.difficulty + 1
            end

        elseif hubSection == "Science" then

            local science = player.upgrades.science
            local upgradeNames = {
                ATK = {"attackDamage", "attackSpeed", "critChance", "critFactor", "range"},
                VIT = {"health", "regeneration", "resistance", "shieldCooldown", "shieldDuration", "meteorAmount", "meteorRPM"},
                UTL = {"copperPerWave", "silverPerWave", "copperBonus", "silverBonus"}
            }
            local upgradeSectionNames = {"ATK", "VIT", "UTL"}
            for i=1,#upgradeSectionNames do
                local currentProcessedSection = upgradeSectionNames[i]
                for j=1,#upgradeNames[currentProcessedSection] do
                    if i == 2 and j == 1 then
                        player.upgrades.science.health.level, player.upgrades.science.health.cost, player.tower.maxHealth = processUpgradeModule.upgrade(x, y, upgradeModules["science"][currentProcessedSection][1], reloadFormulae(upgradeModules["science"][currentProcessedSection][1][8] + 1)["science"][upgradeSectionNames[i]][1][1], reloadFormulae(upgradeModules["science"][currentProcessedSection][1][8] + 1)["science"][currentProcessedSection][1][2] * (player.abilities.JerelosBlessing.equipped and levelingInfo[7].healthIncrease[player.abilities.JerelosBlessing.level + 1] or 1))
                    else
                        player.upgrades.science[upgradeNames[currentProcessedSection][j]].level, player.upgrades.science[upgradeNames[currentProcessedSection][j]].cost, player.tower[upgradeNames[currentProcessedSection][j]] = processUpgradeModule.upgrade(x, y, upgradeModules["science"][currentProcessedSection][j], reloadFormulae(upgradeModules["science"][currentProcessedSection][j][8] + 1)["science"][currentProcessedSection][j][1], reloadFormulae(upgradeModules["science"][currentProcessedSection][j][8] + 1)["science"][currentProcessedSection][j][2])
                    end
                end
            end

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
        elseif hubSection == "Abilities" then
            if x >= 1017 and x <= 1107 and y >= 253 and y <= 307 and not abilityFunctions.checkMenuDisplay() and not player.menu.rolledAbilityDisplay then
                if player.currencies.currentTokens >= 60 then
                    if player.canClaim.ability == true and player.timers.abilityAssembly == player.cooldowns.abilityAssembly_current and player.misc.abilityAssembling then
                        abilitiesFromRolledClass = {}
                        local rolledPercent = love.math.random(0, 100000) / 1000
                        local chanceClassRange = {0, 0}
                        for i=1,#abilityClasses do
                            chanceClassRange[1] = chanceClassRange[2]
                            chanceClassRange[2] = chanceClassRange[2] + abilityClassProbabilities[abilityClasses[i]]
                            if rolledPercent >= chanceClassRange[1] and rolledPercent <= chanceClassRange[2] then
                                rolledClass = abilityClasses[i]
                                break
                            end
                        end
                        for i=1,#internalAbilities do
                            if internalAbilities[i].class == rolledClass then
                                table.insert(abilitiesFromRolledClass, internalAbilities[i])
                            end
                        end
                        rolledAbility = love.math.random(1, #abilitiesFromRolledClass)
                        rolledInternalAbility = abilitiesFromRolledClass[rolledAbility].internalName
                        player.abilities[rolledInternalAbility].amount = player.abilities[rolledInternalAbility].amount + 1
                        player.menu.rolledAbilityDisplay = true
                        player.timers.abilityAssembly = 0
                        player.misc.abilityAssembling = false
                        player.canClaim.ability = false
                        abilityFunctions.updateInternals()
                    elseif player.timers.abilityAssembly == 0 and not player.misc.abilityAssembling then
                        player.currencies.currentTokens = player.currencies.currentTokens - 60
                        player.cooldowns.abilityAssembly_current = love.math.random(player.cooldowns.abilityAssembly_min, player.cooldowns.abilityAssembly_max)
                        player.timers.abilityAssembly = 0
                        player.misc.abilityAssembling = true
                        player.canClaim.ability = false
                    end
                end
            end
            if x >= 920 and x <= 1000 and y >= 645 and y <= 680 and player.menu.rolledAbilityDisplay then
                player.menu.rolledAbilityDisplay = false
            end
            for i,v in pairs(internalAbilities) do
                player.abilities[v.internalName].equipped = abilityFunctions.changeEquipState(x, y, abilityFunctions.calculateOffset(i) + 76, 570 + math.floor((i - 1) / 5) * 230, v)
                player.menu.abilities[v.internalName] = abilityFunctions.showInfo.process(x, y, abilityFunctions.calculateOffset(i) + 5, 570 + math.floor((i - 1) / 5) * 230, v)
                player.abilities[v.internalName].level, player.abilities[v.internalName].amount = abilityFunctions.upgrade(x, y, v)
                if v.internalName == "JerelosBlessing" then
                    player.tower.maxHealth = reloadFormulae(player.upgrades.round.health.level)["science"]["VIT"][1][2] * (player.abilities.JerelosBlessing.equipped and levelingInfo[7].healthIncrease[v.level + 1] or 1)
                    player.tower.currentHealth = player.tower.maxHealth
                    processUpgradeModule.reload()
                end
            end
            abilityFunctions.updateInternals()
        end
    end
end