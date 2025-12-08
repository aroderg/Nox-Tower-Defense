local hubSections = {"Main", "Science", "Nexus", "Abilities"}
local rolledClass
local rolledInternalAbility
local rolledAbility
local abilitiesFromRolledClass = {}
orbital = {}

--- Update all the Orbitals displayed in the Hub.
---@param shuffle boolean Whether to change the random Orbital displayed.
function orbital.update(shuffle)
    function getUsername()
        local username = os.getenv("USERNAME")
        if username == nil then
            username = os.getenv("USER")
        end
        if username == nil then
            username = "playername"
        end
        return username
    end

    local orbitals = {
        "The space is waiting for you.",
        "Novae stellae semper clare fulgent.", --Latin for "New stars always shine bright."
        "Are we moving to other galaxies?",
        "Neverending waves.",
        "100% chance of alien invasion.",
        "Lost in space, still going strong.",
        "Spiraling up the upgrade path.",
        "One tower should be enough.",
        "Look, I'm an Orbital! So pretty!",
        "Nice to meet you, " .. getUsername() .. ".",
        "Defending the tower again, are we?",
        player.currencies.currentElectrum .. " Electrum? What will you do with it?",
        string.format("%d Silver... I'd just assume you found some floating debris.", player.currencies.currentSilver),
        string.format("%d Gold... That is something pirates would be jealous of.", player.currencies.currentGold),
        player.currencies.currentTokens .. " Tokens could be enough for a Nexus upgrade.",
        "Running low on resources?",
        "Look at that, a bright Aurora out there all by herself!",
        "Ever wondered why they are called Meteors?",
        "We found no use for space rocks.",
        "Oh, you like tower defending, you're a tower defender O_O",
        "Wave " .. player.bestWaves.d1 .. " is solid progress, let's see if you can go further.",
        "Woah, you've cleared " .. player.stats.save.wavesBeaten .. " waves so far. Impressive!",
        "They would prefer to connect sometime soon.",
        "Those " .. (player.modifiers.acceleration.unlocked and "accelerated " or "") .. "space battles look gorgeous.",
        "If you like offense, try the Berserker Kit. If you like defense, try the Tank Kit.",
        "Don't waste your offline time! It caps at 6 hours.",
        "Don't forget to check all the themes in the Settings.",
        "The Lifesteal upgrade can really save a run sometimes.",
        "The Hub looks great with the " .. settings_themeNames[player.misc.theme] .. " theme. Check the others out!",
        "Disruptance Wave is great for crowd control.",
        love.system.getOS() .. " user?",
        "The harder the difficulty, the better the Silver Multiplier!",
        "Pressing Escape while in a wave? That's the instant pause button now.",
        "If you see an Ability border glowing orange, it's maxed. Time to celebrate!",
        "It's not truly idle if you're not gaining Silver, right?",
        "Built with LOVE2d. We hope you enjoy it!",
        "A lone tower against the cosmos. That's the Nox way.",
        "Feeling impatient? Wave Skip Chance can get you through quickly.",
        "You can open Settings and Stats right from the Hub, too."
    }
    player.misc.currentOrbital = shuffle and love.math.random(1, #orbitals) or player.misc.currentOrbital
    return orbitals[player.misc.currentOrbital]
end

--- Draws all of the Hub visuals.
function inHub_visual()
    if player.location == "hub" then
        love.graphics.setLineWidth(1)
        love.graphics.setFont(font_Afacad24)
        love.graphics.setLineStyle("smooth")
        if player.misc.theme == "main" then
            love.graphics.setColor(1, 1, 1, 1)
        else
            love.graphics.setColor(0.5, 0.5, 0.5, 1)
            --love.graphics.setColor(1, 1, 1, 1)
        end
        love.graphics.draw(accentColors[player.misc.theme].background, 0, 0)

        local hubColors = {{0.65, 0.5, 0}, {0, 0.65, 0.3}, {0.5, 0, 0.6}, {0.8, 0.2, 0.2}}
        for i=1,#hubSections do
            love.graphics.setColor(hubColors[i])
            love.graphics.rectangle("fill", 0, (1080 / #hubSections) * (i - 1), 30, 1080 / #hubSections)
            love.graphics.setColor(1, 1, 1, 1)
            if hubSection == hubSections[i] then
                love.graphics.setColor(1, 0, 0, 1)
            end
            love.graphics.rectangle("line", 31, (1080 / #hubSections) * (i - 1) + 1, 100, 40, 2, 2)
            love.graphics.printf(hubSections[i], 30, (1080 / #hubSections) * (i - 1) + 3, 100, "center")
        end

        love.graphics.setColor(0, 0, 0, 0.5)
        love.graphics.rectangle("fill", 1800, 100, 119, 200, 4, 4)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setLineWidth(2)
        love.graphics.rectangle("line", 1800, 100, 119, 200, 4, 4)
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

        love.graphics.setColor(accentColors[player.misc.theme].buttons)
        love.graphics.rectangle("fill", 1800, 22, 118, 32)
        love.graphics.setColor(accentColors[player.misc.theme].buttonOutlines)
        love.graphics.setLineWidth(2)
        love.graphics.rectangle("line", 1800, 22, 118, 32, 2, 2)
        love.graphics.setFont(font_Afacad24)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf("Settings", 1780, 21, 158, "center")
        love.graphics.setColor(accentColors[player.misc.theme].buttons)
        love.graphics.rectangle("fill", 1800, 62, 118, 32)
        love.graphics.setColor(accentColors[player.misc.theme].buttonOutlines)
        love.graphics.setLineWidth(2)
        love.graphics.rectangle("line", 1800, 62, 118, 32, 2, 2)
        love.graphics.setFont(font_Afacad24)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf("Stats", 1780, 61, 158, "center")
        love.graphics.setLineWidth(1)
        love.graphics.draw(img_discordLogo, 1710, 22, 0, 80/512, 80/512)
        if not player.menu.settings and not player.menu.saveStats and not player.menu.rolledAbilityDisplay and not abilityFunctions.checkMenuDisplay() and player.settings.tooltips then
            tooltips.displayDiscordTooltip()
        end
        love.graphics.setColor(1, 1, 1, 1)
        
        if hubSection == "Main" then
            love.graphics.setFont(font_Afacad16)
            love.graphics.printf({{0, 1, 1, 0.4}, "(" .. orbital.update() .. ")"}, 1024, 82, 700, "left")
            love.graphics.setFont(font_AfacadSemiBold28)
            love.graphics.printf(string.format("Difficulty %d", player.difficulty.difficulty), 810, 738, 300, "center")
            local bestWaves = {player.bestWaves.d1, player.bestWaves.d2, player.bestWaves.d3, player.bestWaves.d4, player.bestWaves.d5}
            local highestDiffUnlocked = player.difficulty.unlocks.d5 and 5 or player.difficulty.unlocks.d4 and 4 or player.difficulty.unlocks.d3 and 3 or player.difficulty.unlocks.d2 and 2 or 1
            love.graphics.setFont(font_Afacad24)
            love.graphics.printf(string.format("Best Wave: %s", bestWaves[player.difficulty.difficulty] or "None"), 810, 772, 300, "center")
            love.graphics.setFont(font_Afacad18)
            love.graphics.printf({{1, 1, 1, 1}, "Silver Multiplier: ", {0.5, 1, 1, 1}, "x" .. difficultyMultipliers[player.difficulty.difficulty]}, 810, 799, 300, "center")
            if player.difficulty.difficulty > 1 then
                love.graphics.draw(img_button_arrowLeft, 840, 746)
            end
            if player.difficulty.difficulty < highestDiffUnlocked then
                love.graphics.draw(img_button_arrowRight, 1056, 746)
            end
            love.graphics.setColor(accentColors[player.misc.theme].buttons)
            love.graphics.rectangle("fill", 860, 900, 200, 80, 3, 3)
            love.graphics.setColor(accentColors[player.misc.theme].buttonOutlines)
            love.graphics.setLineWidth(2)
            love.graphics.rectangle("line", 860, 900, 200, 80, 3, 3)
            love.graphics.setLineWidth(1)
            love.graphics.setFont(font_Afacad28)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.printf("Battle", 780, 920, 360, "center")
            
        elseif hubSection == "Science" then

            love.graphics.setLineStyle("rough")
            upgradeModuleFuncs.load()

            local sectionTable = {"ATK", "VIT", "UTL"}
            for i,v in ipairs(sectionTable) do
                local section = sectionTable[i]
                
                for j,w in ipairs(upgradeModules["science"][section]) do
                    if upgradeModules["science"][section][j]["precedingUpgrade"] ~= false then
                        upgradeModuleFuncs.draw(upgradeModules["science"][section][j])
                    else
                        unlockPanelFuncs.draw(unlockPanels[upgradeModules["science"][section][j][14]])
                        break
                    end
                end
            end

        elseif hubSection == "Nexus" then

            love.graphics.setLineStyle("smooth")
            love.graphics.setLineWidth(2)

            --[[ Electrum sub-menu ]]--
            love.graphics.setColor(0, 0, 0, 0.5)
            love.graphics.rectangle("fill", 1650, 100, 150, 200, 4, 4)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.rectangle("line", 1650, 100, 150, 200, 4, 4)
            love.graphics.draw(img_currency_silver, 1660, 110)
            love.graphics.draw(img_currency_gold, 1759, 110)
            love.graphics.setFont(font_Vera16)
            love.graphics.printf("600", 1655, 140, 40, "center")
            love.graphics.printf("3", 1755, 140, 40, "center")
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
            love.graphics.setColor(0, 0, 0, 0.5)
            love.graphics.rectangle("fill", 1450, 100, 200, 200, 4, 4)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.rectangle("line", 1450, 100, 200, 200, 4, 4)
            love.graphics.setFont(font_AfacadBold20)
            love.graphics.printf("Claim your tokens!", 1450, 100, 200, "center")
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
                {name = "Regeneration", maxLevel = 41, currentLevel = player.upgrades.nexus.regeneration.level, cost = player.upgrades.nexus.regeneration.cost, value = player.upgrades.nexus.regeneration.value},
                {name = "Ability Chance", maxLevel = 41, currentLevel = player.upgrades.nexus.abilityChance.level, cost = player.upgrades.nexus.abilityChance.cost, value = player.upgrades.nexus.abilityChance.value},
                {name = "Ability Cooldown", maxLevel = 31, currentLevel = player.upgrades.nexus.abilityCooldown.level, cost = player.upgrades.nexus.abilityCooldown.cost, value = player.upgrades.nexus.abilityCooldown.value},
            }
            for i,v in pairs(nexusBuffs) do
                love.graphics.setLineStyle("smooth")
                love.graphics.setLineWidth(2)
                love.graphics.setFont(font_Afacad20)
                love.graphics.setColor(0, 0, 0, 0.5)
                love.graphics.rectangle("fill", 725 + (i - 1) % 3 * 160, 190 + math.floor((i - 1) / 3) * 160, 150, 150, 4, 4)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.rectangle("line", 725 + (i - 1) % 3 * 160, 190 + math.floor((i - 1) / 3) * 160, 150, 150, 4, 4)
                love.graphics.printf(v.name, 725 + (i - 1) % 3 * 160, 190 + math.floor((i - 1) / 3) * 160, 150, "center")
                love.graphics.printf(v.name == "Ability Cooldown" and string.format("/%.3f", v.value) or string.format("x%.2f", v.value), 725 + (i - 1) % 3 * 160, 220 + math.floor((i - 1) / 3) * 160, 150, "center")
                love.graphics.setColor(0.6, 0.45, 0.25, 1)
                love.graphics.rectangle("fill", 730 + (i - 1) % 3 * 160, 295 + math.floor((i - 1) / 3) * 160, 140, 40)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.setLineStyle("rough")
                love.graphics.setLineWidth(1)
                love.graphics.rectangle("line", 730 + (i - 1) % 3 * 160, 295 + math.floor((i - 1) / 3) * 160, 140, 40)
                love.graphics.setFont(font_Afacad24)
                if v.currentLevel < v.maxLevel then
                    love.graphics.draw(img_currency_token, 735 + (i - 1) % 3 * 160, 300 + math.floor((i - 1) / 3) * 160)
                    love.graphics.print(v.cost, 767 + (i - 1) % 3 * 160, 299 + math.floor((i - 1) / 3) * 160)
                else
                    love.graphics.printf("Max", 730 + (i - 1) % 3 * 160, 299 + math.floor((i - 1) / 3) * 160, 140, "center")
                end
            end

            love.graphics.setFont(font_AfacadBold32)
            love.graphics.printf("Gameplay modifiers", 810, 500, 300, "center")

            local gameplayModifiers = {
                {name = "Wave Skip", unlockCost = 10, value = player.modifiers.waveSkip.value, cost = player.modifiers.waveSkip.cost, maxLevel = 10, text = {{1, 1, 1, 1}, "There is a ", {0, 1, 0.7, 1}, string.format("%d", player.modifiers.waveSkip.value), {1, 1, 1, 1}, "% chance of skipping a wave and immediately advancing to the next one."}, upgradeText = "Chance", unlocked = player.modifiers.waveSkip.unlocked, level = player.modifiers.waveSkip.level},
                {name = "Hyperloop", unlockCost = 15, value = player.modifiers.hyperloop.value, cost = player.modifiers.hyperloop.cost, maxLevel = 11, text = {{1, 1, 1, 1}, "All enemies outside of the tower range are ", {1, 0.5, 0.3, 1}, string.format("%d", player.modifiers.hyperloop.value), {1, 1, 1, 1}, "% faster."}, upgradeText = "Speed", unlocked = player.modifiers.hyperloop.unlocked, level = player.modifiers.hyperloop.level},
                {name = "Acceleration", unlockCost = 15, value = player.modifiers.acceleration.value, cost = player.modifiers.acceleration.cost, maxLevel = 20, text = {{1, 1, 1, 1}, "The game is processed at ", {1, 0.44, 0.79}, 100 + player.modifiers.acceleration.value * 100, {1, 1, 1, 1}, "% of the normal speed."}, upgradeText = "Speed", unlocked = player.modifiers.acceleration.unlocked, level = player.modifiers.acceleration.level},
            }

            for i,v in pairs(gameplayModifiers) do
                love.graphics.setFont(font_Afacad20)
                love.graphics.setLineStyle("smooth")
                love.graphics.setLineWidth(2)
                love.graphics.setColor(0, 0, 0, 1)
                love.graphics.rectangle("fill", 650, 550 + 140 * (i - 1), 630, 35, 4, 4)
                love.graphics.setColor(0, 0, 0, 0.5)
                love.graphics.rectangle("fill", 650, 585 + 140 * (i - 1), 630, 85, 4, 4)
                love.graphics.setColor(1, 1, 1, 1)
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

            love.graphics.setLineStyle("smooth")
            love.graphics.setLineWidth(2)
            love.graphics.setColor(0, 0, 0, 0.5)
            love.graphics.rectangle("fill", 1650, 300, 269, 200, 4, 4)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.rectangle("line", 1650, 300, 269, 200, 4, 4)
            love.graphics.setFont(font_AfacadBold24)
            love.graphics.printf("Idle Gains", 1650, 300, 269, "center")
            love.graphics.setFont(font_AfacadBold18)
            love.graphics.printf(string.format("%dm %ds/%dm", math.floor(player.idleTime / 60), player.idleTime % 60, math.floor(player.idleTimeCap / 60)), 1650, 335, 269, "center")
            love.graphics.setColor(1, 0, 0, 1)
            love.graphics.rectangle("fill", 1657, 330, 253, 8)
            love.graphics.setColor(0, 1, 0, 1)
            love.graphics.rectangle("fill", 1657, 330, (player.idleTime / player.idleTimeCap) * 253, 8)
            love.graphics.setFont(font_Afacad18)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.draw(img_currency_silver, 1657, 360)
            love.graphics.draw(img_currency_gold, 1657, 392)
            love.graphics.printf(string.format("+%.2f/min -> %s", player.idleGains.silver, notations.convertToLetterNotation(player.storedGains.silver, "precise2")), 1691, 363, 300, "left")
            love.graphics.printf(string.format("+%.2f/min -> %.2f", player.idleGains.gold, player.storedGains.gold), 1691, 395, 300, "left")
            love.graphics.setLineStyle("rough")
            love.graphics.rectangle("line", 1655, 465, 260, 30)
            love.graphics.setFont(font_Afacad20)
            love.graphics.printf("Claim", 1655, 465, 260, "center")

        elseif hubSection == "Abilities" then
            love.graphics.setFont(font_AfacadBold24)
            love.graphics.printf(string.format("Equipped: %d/%d", player.abilities.equipped, player.abilities.maxEquipped), 860, 200, 200, "center")
            love.graphics.draw(img_button_questionMark, 1040, 205)
            love.graphics.setColor(accentColors[player.misc.theme].upgradeModule)
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
            if not player.misc.abilityAssembling and player.timers.abilityAssembly == 0 then
                love.graphics.draw(img_currency_token, 1021, 268, 0, 24/32)
                love.graphics.print("60", 1045, 266)
            elseif player.misc.abilityAssembling and player.timers.abilityAssembly < player.cooldowns.abilityAssembly_current then
                love.graphics.setFont(font_Afacad16)
                love.graphics.printf("Assembling...", 1017, 268, 90, "center")
                love.graphics.setFont(font_Afacad20)
            elseif not player.misc.abilityAssembling and player.canClaim.ability and player.timers.abilityAssembly >= player.cooldowns.abilityAssembly_current then
                love.graphics.setFont(font_Afacad20)
                love.graphics.printf("Ready!", 1017, 266, 90, "center")
            end
            --love.graphics.print(tostring(player.misc.abilityAssembling), 100, 100)
            --love.graphics.print(tostring(player.canClaim.ability), 100, 130)
            --love.graphics.print(player.timers.abilityAssembly, 100, 160)
            love.graphics.draw(img_button_questionMark, 1110, 268)
            if player.misc.abilityAssembling and player.timers.abilityAssembly < player.cooldowns.abilityAssembly_current then
                love.graphics.setColor(1, 0, 0, 1)
                love.graphics.rectangle("fill", 810, 320, 300, 8)
                love.graphics.setColor(0, 1, 0, 1)
                love.graphics.rectangle("fill", 810, 320, (player.timers.abilityAssembly / player.cooldowns.abilityAssembly_current) * 300, 8)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.printf(string.format("%dm %ds", (player.cooldowns.abilityAssembly_current - player.timers.abilityAssembly) / 60, (player.cooldowns.abilityAssembly_current - player.timers.abilityAssembly) % 60), 860, 325, 200, "center")
            end
            if not abilityFunctions.checkMenuDisplay() and not player.menu.rolledAbilityDisplay and not player.menu.settings and not player.menu.saveStats and player.settings.tooltips then
                tooltips.displayAbilityInfo()
            end
            for i,v in pairs(internalAbilities) do
                local roleColors = {
                    active = {0.98, 0.44, 0.24},
                    link = {0.5, 0.99, 0.52},
                    passive = {0.45, 0.61, 0.89},
                }
                --Draw the brief ("Card") appearance of the Ability.
                love.graphics.setColor(0, 0, 0, 0.5)
                love.graphics.rectangle("fill", abilityFunctions.calculateOffset(i), 360 + math.floor((i - 1) / 5) * 230, 150, 200, 2, 2)
                love.graphics.setLineStyle("rough")
                love.graphics.setColor(0.35 + 0.65 * (v.unlocked and 1 or 0), 0.35 + 0.65 * (v.unlocked and 1 or 0), 0.35 + 0.65 * (v.unlocked and 1 or 0), 1)
                love.graphics.draw(v.preview, abilityFunctions.calculateOffset(i), 390 + math.floor((i - 1) / 5) * 230)
                love.graphics.setColor(1, 1, 1, 0.5)
                love.graphics.setLineWidth(1)
                love.graphics.rectangle("line", abilityFunctions.calculateOffset(i), 390 + math.floor((i - 1) / 5) * 230, 150, 100)
                love.graphics.setLineWidth(2)
                love.graphics.setLineStyle("smooth")
                local nextLvlReq = (v.level < #v.levelRequirements - 1) and (v.levelRequirements[v.level + 1]) or math.huge
                local borderColor =
                --(v.level < #v.levelRequirements - 1) and {1, 1, 1, 1} or
                (v.amount >= nextLvlReq) and {0, 1, 0, 1} or (v.level < #v.levelRequirements - 1) and {1, 1, 1, 1} or {1, 0.5, 0, 1}
                love.graphics.setColor(borderColor)
                love.graphics.rectangle("line", abilityFunctions.calculateOffset(i), 360 + math.floor((i - 1) / 5) * 230, 150, 200, 2, 2)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.setFont(font_AfacadBold20)
                love.graphics.printf(v.name, abilityFunctions.calculateOffset(i), 361 + math.floor((i - 1) / 5) * 230, 150, "center")
                love.graphics.setFont(font_Afacad20)
                love.graphics.printf("Level " .. v.level, abilityFunctions.calculateOffset(i), 495 + math.floor((i - 1) / 5) * 230, 150, "center")
                love.graphics.setLineWidth(1)
                love.graphics.setLineStyle("rough")
                love.graphics.setFont(font_Afacad16)
                love.graphics.rectangle("line", abilityFunctions.calculateOffset(i) + 5, 530 + math.floor((i - 1) / 5) * 230, 70, 25)
                love.graphics.printf("Info", abilityFunctions.calculateOffset(i) + 5, 531 + math.floor((i - 1) / 5) * 230, 70, "center")
                local buttonColor = abilityFunctions.checkForCompatibility(v) and {1, 1, 1, 1} or {1, 0.3, 0.4, 1}
                love.graphics.setColor(buttonColor)
                love.graphics.rectangle("line", abilityFunctions.calculateOffset(i) + 76, 530 + math.floor((i - 1) / 5) * 230, 70, 25)
                love.graphics.printf(not v.equipped and "Equip" or "Unequip", abilityFunctions.calculateOffset(i) + 76, 531 + math.floor((i - 1) / 5) * 230, 70, "center")
                love.graphics.setColor(1, 1, 1, 1)
                local roleTagColor = roleColors[(tostring(v.tags.role)):sub(1, 1):lower() .. (tostring(v.tags.role)):sub(2, -1)]
                love.graphics.setColor(roleTagColor)
                love.graphics.rectangle("fill", abilityFunctions.calculateOffset(i) + 5, 470 + math.floor((i - 1) / 5) * 230, 15, 15, 2, 2)
            end
            for i,v in pairs(internalAbilities) do
                abilityFunctions.showInfo.draw(v)
            end
            if player.menu.rolledAbilityDisplay then
                local roleColors = {
                    active = {0.98, 0.44, 0.24},
                    link = {0.5, 0.99, 0.52},
                    passive = {0.45, 0.61, 0.89},
                }
                love.graphics.setColor(0, 0, 0, 0.5)
                love.graphics.rectangle("fill", 0, 0, 1920, 1080)
                love.graphics.setColor(accentColors[player.misc.theme].menus)
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
                    abilitiesFromRolledClass[rolledAbility].amount < abilitiesFromRolledClass[rolledAbility].nextLevelRequirement - 1 and {1, 0.4, 0.35, 1} or
                    {0.35, 1, 0.5, 1}
                love.graphics.printf({{1, 1, 1, 1}, "Class: ", classColor, abilitiesFromRolledClass[rolledAbility].class}, 675, 515, 150, "center")
                love.graphics.printf({{1, 1, 1, 1}, "Amount: ", amountColor, abilitiesFromRolledClass[rolledAbility].amount + (abilitiesFromRolledClass[rolledAbility].unlocked and 1 or 0), {1, 1, 1, 1}, "/", {0.35, 1, 0.5, 1}, abilitiesFromRolledClass[rolledAbility].nextLevelRequirement}, 675, 535, 150, "center")
                local roleTagColor = roleColors[(tostring(abilitiesFromRolledClass[rolledAbility].tags.role)):sub(1, 1):lower() .. (tostring(abilitiesFromRolledClass[rolledAbility].tags.role)):sub(2, -1)]
                love.graphics.setColor(roleTagColor)
                love.graphics.rectangle("fill", 680, 485, 15, 15, 2, 2)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.setFont(font_Afacad24)
                love.graphics.setColor(accentColors[player.misc.theme].buttons)
                love.graphics.rectangle("fill", 920, 645, 80, 35, 2, 2)
                love.graphics.setColor(accentColors[player.misc.theme].buttonOutlines)
                love.graphics.setLineWidth(2)
                love.graphics.rectangle("line", 920, 645, 80, 35, 2, 2)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.setFont(font_Afacad24)
                love.graphics.printf("Back", 920, 646, 80, "center")
            end
        end
    end
end
function refreshNexusBuffs()
    return {
        attackDamage = {name = "Attack Damage", maxLevel = 41, currentLevel = player.upgrades.nexus.attackDamage.level, cost = player.upgrades.nexus.attackDamage.cost, value = player.upgrades.nexus.attackDamage.value},
        attackSpeed = {name = "Attack Speed", maxLevel = 26, currentLevel = player.upgrades.nexus.attackSpeed.level, cost = player.upgrades.nexus.attackSpeed.cost, value = player.upgrades.nexus.attackSpeed.value},
        health = {name = "Health", maxLevel = 41, currentLevel = player.upgrades.nexus.health.level, cost = player.upgrades.nexus.health.cost, value = player.upgrades.nexus.health.value},
        regeneration = {name = "Regeneration", maxLevel = 41, currentLevel = player.upgrades.nexus.regeneration.level, cost = player.upgrades.nexus.regeneration.cost, value = player.upgrades.nexus.regeneration.value},
        abilityChance = {name = "Ability Chance", maxLevel = 41, currentLevel = player.upgrades.nexus.abilityChance.level, cost = player.upgrades.nexus.abilityChance.cost, value = player.upgrades.nexus.abilityChance.value},
        abilityCooldown = {name = "Ability Cooldown", maxLevel = 31, currentLevel = player.upgrades.nexus.abilityCooldown.level, cost = player.upgrades.nexus.abilityCooldown.cost, value = player.upgrades.nexus.abilityCooldown.value},
    }
end

--- Process all the mouse and button clicks while in Hub.
---@param x number Mouse cursor position (horizontal).
---@param y number Mouse cursor position (vertical).
function inHub_mouse(x, y)
    if player.location == "hub" and not player.menu.saveStats then
        
        --[[ Process mouse clicks on sidebar, go to different sections based on the button pressed ]]--

        for i=1,#hubSections do
            if x >= 0 and x <= 30 and y >= (1080 / #hubSections) * (i - 1) and y <= (1080 / #hubSections) * i and not abilityFunctions.checkMenuDisplay() and not player.menu.rolledAbilityDisplay and not player.menu.settings then
                hubSection = hubSections[i]
            end
        end
        
        --[[ Exit Hub and go to battle ]]--
        if hubSection == "Main" then
            if x >= 860 and x <= 1060 and y >= 900 and y <= 980 and not player.menu.settings then
                player.location = "round"
                orbital.update(true)
                player.difficulty.difficulty = player.difficulty.difficulty
                roundUpgradeSection = "ATK"
                resetRoundValues()
                towers.reload()
                gameOver = false
                player.menu.paused = false
                gameplay.gameSpeed = player.maxGameSpeed
                -- audioST_Echoes:setVolume(1 * player.settings.volume^2)
                -- audioST_Echoes:play()
            end
            local levelUnlocks = {player.difficulty.unlocks.d2, player.difficulty.unlocks.d3, player.difficulty.unlocks.d4, player.difficulty.unlocks.d5}
            if x >= 840 and x <= 864 and y >= 746 and y <= 770 and player.difficulty.difficulty > 1 and levelUnlocks[player.difficulty.difficulty - 1] and not player.menu.settings then
                player.difficulty.difficulty = player.difficulty.difficulty - 1
            elseif x >= 1056 and x <= 1080 and y >= 746 and y <= 770 and player.difficulty.difficulty < 5 and levelUnlocks[player.difficulty.difficulty] and not player.menu.settings then
                player.difficulty.difficulty = player.difficulty.difficulty + 1
            end

        elseif hubSection == "Science" and not player.menu.settings then

            local science = player.upgrades.science
            local upgradeNames = {
                ATK = {"attackDamage", "attackSpeed", "critChance", "critFactor", "range", "clusterFireChance", "clusterFireTargets", "clusterFireEfficiency"},
                VIT = {"health", "regeneration", "resistance", "shieldCooldown", "shieldDuration", "meteorAmount", "meteorRPM", "lifestealChance", "lifestealPercent"},
                UTL = {"copperPerWave", "silverPerWave", "copperBonus", "silverBonus"}
            }
            local upgradeSectionNames = {"ATK", "VIT", "UTL"}
            for i=1,#upgradeSectionNames do
                local currentProcessedSection = upgradeSectionNames[i]
                if currentProcessedSection == upgradeSectionNames[i] and not player.menu.saveStats then
                    for j,w in pairs(upgradeNames[currentProcessedSection]) do
                        player.upgrades.science[upgradeNames[currentProcessedSection][j]].level, player.upgrades.science[upgradeNames[currentProcessedSection][j]].cost, player.tower[upgradeNames[currentProcessedSection][j]] = upgradeModuleFuncs.upgrade(x, y, upgradeModules["science"][currentProcessedSection][j], upgradeModuleFuncs.reloadFormulae(upgradeModules["science"][currentProcessedSection][j][8] + 1)["science"][currentProcessedSection][j][1], upgradeModuleFuncs.reloadFormulae(upgradeModules["science"][currentProcessedSection][j][8] + 1)["science"][currentProcessedSection][j][2])
                    end
                end
            end

            unlockPanelsPressed = 0
            if not player.menu.settings and not player.menu.saveStats then
                player.upgrades.unlocks.crit = unlockPanelFuncs.clickCheck(x, y, unlockPanels["crit"])
                player.upgrades.unlocks.range = unlockPanelFuncs.clickCheck(x, y, unlockPanels["range"])
                player.upgrades.unlocks.clusterFire = unlockPanelFuncs.clickCheck(x, y, unlockPanels["clusterFire"])
                player.upgrades.unlocks.resistance = unlockPanelFuncs.clickCheck(x, y, unlockPanels["resistance"])
                player.upgrades.unlocks.shield = unlockPanelFuncs.clickCheck(x, y, unlockPanels["shield"])
                player.upgrades.unlocks.meteor = unlockPanelFuncs.clickCheck(x, y, unlockPanels["meteor"])
                player.upgrades.unlocks.lifesteal = unlockPanelFuncs.clickCheck(x, y, unlockPanels["lifesteal"])
                player.upgrades.unlocks.resourceBonus = unlockPanelFuncs.clickCheck(x, y, unlockPanels["resourceBonus"])
            end

        elseif hubSection == "Nexus" then
            --[[ If in Nexus, clicking the Alloy button starts the Electrum alloying process after spending 400 Silver and 2 Gold ]]--
            if x >= 1655 and x <= 1795 and y >= 265 and y <= 295 and not player.menu.settings then
                if player.currencies.currentSilver >= 600 and player.currencies.currentGold >= 3 and player.canClaim.electrum then
                    player.canClaim.electrum = false
                    player.timers.electrum = 0
                    player.currencies.currentSilver = player.currencies.currentSilver - 600
                    player.currencies.currentGold = player.currencies.currentGold - 3
                end
            end

            --[[ Claiming tokens ]]--
            if x >= 1455 and x <= 1645 and y >= 265 and y <= 295 and not player.menu.settings then
                if player.canClaim.tokens then
                    player.currencies.currentTokens = player.currencies.currentTokens + 15
                    player.canClaim.tokens = false
                    player.timers.tokens = 0
                end
            end

            local addendums = {attackDamage = 0.1, attackSpeed = 0.04, health = 0.1, regeneration = 0.1, abilityChance = 0.02, abilityCooldown = 0.012}

            local buffGrid = {attackDamage = {x = 730, y = 295}, attackSpeed = {x = 890, y = 295}, health = {x = 1050, y = 295}, regeneration = {x = 730, y = 455}, abilityChance = {x = 890, y = 455}, abilityCooldown = {x = 1050, y = 455}}

            local currentProcessedNexusBuff = 1
            local buffUpgraded = false
            for i,v in pairs(refreshNexusBuffs()) do
                if x >= buffGrid[i].x and x <= buffGrid[i].x + 140 and y >= buffGrid[i].y and y <= buffGrid[i].y + 40 and not player.menu.settings then
                    if player.currencies.currentTokens >= v.cost and v.currentLevel < v.maxLevel then
                        player.currencies.currentTokens = player.currencies.currentTokens - v.cost
                        player.upgrades.nexus[i].level = player.upgrades.nexus[i].level + 1
                        player.upgrades.nexus[i].cost = 20 + (((v.currentLevel + 1) * (v.currentLevel)) / 2) * 5
                        player.upgrades.nexus[i].value = 1 + (v.currentLevel) * addendums[i]
                        player.stats.save.upgradesAcquired.nexus = player.stats.save.upgradesAcquired.nexus + 1
                        player.tower.attackDamage = upgradeModuleFuncs.reloadFormulae(player.upgrades.science.attackDamage.level)["science"]["ATK"][1][2]
                        player.tower.attackSpeed = upgradeModuleFuncs.reloadFormulae(player.upgrades.science.attackSpeed.level)["science"]["ATK"][2][2]
                        player.tower.health = upgradeModuleFuncs.reloadFormulae(player.upgrades.science.health.level)["science"]["VIT"][1][2]
                        player.tower.regeneration = upgradeModuleFuncs.reloadFormulae(player.upgrades.science.regeneration.level)["science"]["VIT"][2][2]
                        upgradeModuleFuncs.load()
                        buffUpgraded = true
                    end
                end
                currentProcessedNexusBuff = currentProcessedNexusBuff + 1
            end
            if buffUpgraded then
                refreshNexusBuffs()
                buffUpgraded = false
            end

            -- --[[ Attack Damage stat buff ]]--
            -- if x >= 490 and x <= 630 and y >= 405 and y <= 445 and not player.menu.settings then
            --     if player.currencies.currentTokens >= player.upgrades.nexus.attackDamage.cost and player.upgrades.nexus.attackDamage.level < 41 then
            --         player.currencies.currentTokens = player.currencies.currentTokens - player.upgrades.nexus.attackDamage.cost
            --         player.upgrades.nexus.attackDamage.level = player.upgrades.nexus.attackDamage.level + 1
            --         player.upgrades.nexus.attackDamage.cost = 20 + ((player.upgrades.nexus.attackDamage.level * (player.upgrades.nexus.attackDamage.level - 1)) / 2) * 5
            --         player.upgrades.nexus.attackDamage.value = math.min(1 + (player.upgrades.nexus.attackDamage.level - 1) * 10/100, 5)
            --         player.tower.attackDamage = upgradeModuleFuncs.reloadFormulae(player.upgrades.science.attackDamage.level)["science"]["ATK"][1][2]
            --         player.stats.save.upgradesAcquired.nexus = player.stats.save.upgradesAcquired.nexus + 1
            --     end
            --     upgradeModuleFuncs.load()
            -- end

            -- --[[ Attack Speed stat buff ]]--
            -- if x >= 650 and x <= 790 and y >= 405 and y <= 445 and not player.menu.settings then
            --     if player.currencies.currentTokens >= player.upgrades.nexus.attackSpeed.cost and player.upgrades.nexus.attackSpeed.level < 26 then
            --         player.currencies.currentTokens = player.currencies.currentTokens - player.upgrades.nexus.attackSpeed.cost
            --         player.upgrades.nexus.attackSpeed.level = player.upgrades.nexus.attackSpeed.level + 1
            --         player.upgrades.nexus.attackSpeed.cost = 20 + ((player.upgrades.nexus.attackSpeed.level * (player.upgrades.nexus.attackSpeed.level - 1)) / 2) * 5
            --         player.upgrades.nexus.attackSpeed.value = math.min(1 + (player.upgrades.nexus.attackSpeed.level - 1) * 4/100, 2)
            --         player.tower.attackSpeed = upgradeModuleFuncs.reloadFormulae(player.upgrades.science.attackSpeed.level)["science"]["ATK"][2][2]
            --         player.stats.save.upgradesAcquired.nexus = player.stats.save.upgradesAcquired.nexus + 1
            --     end
            --     upgradeModuleFuncs.load()
            -- end

            -- --[[ Health stat buff ]]--
            -- if x >= 810 and x <= 950 and y >= 405 and y <= 445 and not player.menu.settings then
            --     if player.currencies.currentTokens >= player.upgrades.nexus.health.cost and player.upgrades.nexus.health.level < 41 then
            --         player.currencies.currentTokens = player.currencies.currentTokens - player.upgrades.nexus.health.cost
            --         player.upgrades.nexus.health.level = player.upgrades.nexus.health.level + 1
            --         player.upgrades.nexus.health.cost = 20 + ((player.upgrades.nexus.health.level * (player.upgrades.nexus.health.level - 1)) / 2) * 5
            --         player.upgrades.nexus.health.value = math.min(1 + (player.upgrades.nexus.health.level - 1) * 10/100, 5)
            --         player.tower.health = upgradeModuleFuncs.reloadFormulae(player.upgrades.science.health.level)["science"]["VIT"][1][2]
            --         player.stats.save.upgradesAcquired.nexus = player.stats.save.upgradesAcquired.nexus + 1
            --     end
            --     upgradeModuleFuncs.load()
            -- end

            -- --[[ Regeneration stat buff ]]--
            -- if x >= 970 and x <= 1110 and y >= 405 and y <= 445 and not player.menu.settings then
            --     if player.currencies.currentTokens >= player.upgrades.nexus.regeneration.cost and player.upgrades.nexus.regeneration.level < 41 then
            --         player.currencies.currentTokens = player.currencies.currentTokens - player.upgrades.nexus.regeneration.cost
            --         player.upgrades.nexus.regeneration.level = player.upgrades.nexus.regeneration.level + 1
            --         player.upgrades.nexus.regeneration.cost = 20 + ((player.upgrades.nexus.regeneration.level * (player.upgrades.nexus.regeneration.level - 1)) / 2) * 5
            --         player.upgrades.nexus.regeneration.value = math.min(1 + (player.upgrades.nexus.regeneration.level - 1) * 10/100, 5)
            --         player.tower.regeneration = upgradeModuleFuncs.reloadFormulae(player.upgrades.science.regeneration.level)["science"]["VIT"][2][2]
            --         player.stats.save.upgradesAcquired.nexus = player.stats.save.upgradesAcquired.nexus + 1
            --     end
            --     upgradeModuleFuncs.load()
            -- end

            -- --[[ Ability Chance stat buff ]]--
            -- if x >= 1130 and x <= 1270 and y >= 405 and y <= 445 and not player.menu.settings then
            --     if player.currencies.currentTokens >= player.upgrades.nexus.abilityChance.cost and player.upgrades.nexus.abilityChance.level < 41 then
            --         player.currencies.currentTokens = player.currencies.currentTokens - player.upgrades.nexus.abilityChance.cost
            --         player.upgrades.nexus.abilityChance.level = player.upgrades.nexus.abilityChance.level + 1
            --         player.upgrades.nexus.abilityChance.cost = 20 + ((player.upgrades.nexus.abilityChance.level * (player.upgrades.nexus.abilityChance.level - 1)) / 2) * 5
            --         player.upgrades.nexus.abilityChance.value = math.min(1 + (player.upgrades.nexus.abilityChance.level - 1) * 2/100, 1.8)
            --         player.stats.save.upgradesAcquired.nexus = player.stats.save.upgradesAcquired.nexus + 1
            --     end
            --     upgradeModuleFuncs.load()
            -- end

            -- --[[ Ability Cooldown stat buff ]]--
            -- if x >= 1290 and x <= 1430 and y >= 405 and y <= 445 and not player.menu.settings then
            --     if player.currencies.currentTokens >= player.upgrades.nexus.abilityCooldown.cost and player.upgrades.nexus.abilityCooldown.level < 41 then
            --         player.currencies.currentTokens = player.currencies.currentTokens - player.upgrades.nexus.regeneration.cost
            --         player.upgrades.nexus.abilityCooldown.level = player.upgrades.nexus.abilityCooldown.level + 1
            --         player.upgrades.nexus.abilityCooldown.cost = 20 + ((player.upgrades.nexus.abilityCooldown.level * (player.upgrades.nexus.abilityCooldown.level - 1)) / 2) * 5
            --         player.upgrades.nexus.abilityCooldown.value = math.min(1 + (player.upgrades.nexus.abilityCooldown.level - 1) * 1.2/100, 1.36)
            --         player.stats.save.upgradesAcquired.nexus = player.stats.save.upgradesAcquired.nexus + 1
            --     end
            --     upgradeModuleFuncs.load()
            -- end

            if x >= 1155 and x <= 1275 and y >= 615 and y <= 665 and not player.menu.settings then
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
                upgradeModuleFuncs.load()
                end
            elseif x >= 1155 and x <= 1275 and y >= 755 and y <= 805 and not player.menu.settings then
                if player.currencies.currentElectrum >= player.modifiers.hyperloop.cost and player.modifiers.hyperloop.level < 11 then
                    if player.modifiers.hyperloop.unlocked then
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
                upgradeModuleFuncs.load()
                end
            elseif x >= 1155 and x <= 1275 and y >= 895 and y <= 945 and not player.menu.settings then
                if player.currencies.currentElectrum >= player.modifiers.acceleration.cost and player.modifiers.acceleration.level < 20 then
                    if player.modifiers.acceleration.unlocked then
                        player.currencies.currentElectrum = player.currencies.currentElectrum - player.modifiers.acceleration.cost
                        player.modifiers.acceleration.level = player.modifiers.acceleration.level + 1
                        player.modifiers.acceleration.cost = math.floor(5 * (2^(player.modifiers.acceleration.level))^0.21) or 15
                        player.modifiers.acceleration.value = math.min(0.04 * (player.modifiers.acceleration.level), 0.8)
                    else
                        player.currencies.currentElectrum = player.currencies.currentElectrum - 15
                        player.modifiers.acceleration.unlocked = true
                        player.modifiers.acceleration.cost = math.floor(5 * (2^(player.modifiers.acceleration.level))^0.21)
                        player.modifiers.acceleration.value = 0
                    end
                upgradeModuleFuncs.load()
                end
            elseif x >= 1655 and x <= 1915 and y >= 465 and y <= 495 and not player.menu.settings and not player.menu.saveStats then
                if player.idleTime >= 60 then
                    player.currencies.currentSilver = player.currencies.currentSilver + player.storedGains.silver
                    player.stats.save.silverEarned = player.stats.save.silverEarned + player.storedGains.silver
                    player.currencies.currentGold = player.currencies.currentGold + math.floor(player.storedGains.gold)
                    player.stats.save.goldEarned = player.currencies.currentGold + math.floor(player.storedGains.gold)
                    player.storedGains.silver = 0
                    player.storedGains.gold = player.storedGains.gold % 1
                    player.idleTime = player.idleTime % 60
                end
            end
        elseif hubSection == "Abilities" then
            if x >= 1017 and x <= 1107 and y >= 253 and y <= 307 and not abilityFunctions.checkMenuDisplay() and not player.menu.rolledAbilityDisplay and not player.menu.settings then
                if player.currencies.currentTokens >= 60 then
                    if player.timers.abilityAssembly == 0 and not player.misc.abilityAssembling and not player.menu.settings then
                        player.currencies.currentTokens = player.currencies.currentTokens - 60
                        player.cooldowns.abilityAssembly_current = love.math.random(player.cooldowns.abilityAssembly_min, player.cooldowns.abilityAssembly_max)
                        player.timers.abilityAssembly = 0
                        player.misc.abilityAssembling = true
                        player.canClaim.ability = false
                        player.misc.tokensRefundable = true
                    end
                end
                if not player.misc.abilityAssembling and not player.menu.settings and player.timers.abilityAssembly >= player.cooldowns.abilityAssembly_current then
                    abilitiesFromRolledClass = {}
                    local rolledPercent = love.math.random() * 100
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
                    if player.abilities[rolledInternalAbility].unlocked then
                        player.abilities[rolledInternalAbility].amount = player.abilities[rolledInternalAbility].amount + 1
                    else
                        player.abilities[rolledInternalAbility].amount = 0
                    end
                    player.abilities[rolledInternalAbility].unlocked = true
                    player.menu.rolledAbilityDisplay = true
                    player.timers.abilityAssembly = 0
                    player.misc.abilityAssembling = false
                    player.canClaim.ability = false
                    player.misc.tokensRefundable = false
                    abilityFunctions.updateInternals()
                end
            end
            if x >= 920 and x <= 1000 and y >= 645 and y <= 680 and player.menu.rolledAbilityDisplay and not player.menu.settings then
                player.menu.rolledAbilityDisplay = false
            end
            if not player.menu.settings then
                for i,v in pairs(internalAbilities) do
                    player.abilities[v.internalName].equipped = abilityFunctions.changeEquipState(x, y, abilityFunctions.calculateOffset(i) + 76, 530 + math.floor((i - 1) / 5) * 230, v)
                    player.menu.abilities[v.internalName] = abilityFunctions.showInfo.process(x, y, abilityFunctions.calculateOffset(i) + 5, 530 + math.floor((i - 1) / 5) * 230, v)
                    player.abilities[v.internalName].level, player.abilities[v.internalName].amount = abilityFunctions.upgrade(x, y, v)
                end
                upgradeModuleFuncs.load()
                resetRoundValues()
                player.tower = {
                    attackDamage = upgradeModuleFuncs.reloadFormulae(player.upgrades.round.attackDamage.level)["science"]["ATK"][1][2],
                    attackSpeed = upgradeModuleFuncs.reloadFormulae(player.upgrades.round.attackSpeed.level)["science"]["ATK"][2][2],
                    critChance = upgradeModuleFuncs.reloadFormulae(player.upgrades.round.critChance.level)["science"]["ATK"][3][2],
                    critFactor = upgradeModuleFuncs.reloadFormulae(player.upgrades.round.critFactor.level)["science"]["ATK"][4][2],
                    range = upgradeModuleFuncs.reloadFormulae(player.upgrades.round.range.level)["science"]["ATK"][5][2],
                    clusterFireChance = upgradeModuleFuncs.reloadFormulae(player.upgrades.round.clusterFireChance.level)["science"]["ATK"][6][2],
                    clusterFireTargets = upgradeModuleFuncs.reloadFormulae(player.upgrades.round.clusterFireTargets.level)["science"]["ATK"][7][2],
                    clusterFireEfficiency = upgradeModuleFuncs.reloadFormulae(player.upgrades.round.clusterFireEfficiency.level)["science"]["ATK"][8][2],

                    health = upgradeModuleFuncs.reloadFormulae(player.upgrades.round.health.level)["science"]["VIT"][1][2],
                    currentHealth = upgradeModuleFuncs.reloadFormulae(player.upgrades.round.health.level)["science"]["VIT"][1][2],
                    regeneration = upgradeModuleFuncs.reloadFormulae(player.upgrades.round.regeneration.level)["science"]["VIT"][2][2],
                    resistance = upgradeModuleFuncs.reloadFormulae(player.upgrades.round.resistance.level)["science"]["VIT"][3][2],
                    shieldCooldown = upgradeModuleFuncs.reloadFormulae(player.upgrades.round.shieldCooldown.level)["science"]["VIT"][4][2],
                    shieldDuration = upgradeModuleFuncs.reloadFormulae(player.upgrades.round.shieldDuration.level)["science"]["VIT"][5][2],
                    meteorAmount = upgradeModuleFuncs.reloadFormulae(player.upgrades.round.meteorAmount.level)["science"]["VIT"][6][2],
                    meteorRPM = upgradeModuleFuncs.reloadFormulae(player.upgrades.round.meteorRPM.level)["science"]["VIT"][7][2],
                    lifestealChance = upgradeModuleFuncs.reloadFormulae(player.upgrades.round.lifestealChance.level)["science"]["VIT"][8][2],
                    lifestealPercent = upgradeModuleFuncs.reloadFormulae(player.upgrades.round.lifestealPercent.level)["science"]["VIT"][9][2],

                    copperPerWave = upgradeModuleFuncs.reloadFormulae(player.upgrades.round.copperPerWave.level)["science"]["UTL"][1][2],
                    silverPerWave = upgradeModuleFuncs.reloadFormulae(player.upgrades.round.silverPerWave.level)["science"]["UTL"][2][2],
                    copperBonus = upgradeModuleFuncs.reloadFormulae(player.upgrades.round.copperBonus.level)["science"]["UTL"][3][2],
                    silverBonus = upgradeModuleFuncs.reloadFormulae(player.upgrades.round.silverBonus.level)["science"]["UTL"][4][2],
                }
                upgradeModuleFuncs.load()
            end
            abilityFunctions.updateInternals()
        end
    if x >= 1800 and x <= 1918 and y >= 22 and y <= 54 and not player.menu.settings and not abilityFunctions.checkMenuDisplay() and not player.menu.rolledAbilityDisplay and not player.menu.saveStats then
        player.menu.settings = true
    end
    if x >= 1800 and x <= 1918 and y >= 62 and y <= 94 and not player.menu.settings and not abilityFunctions.checkMenuDisplay() and not player.menu.rolledAbilityDisplay and not player.menu.saveStats then
        player.menu.saveStats = true
    end
    if x >= 1710 and x <= 1790 and y >= 31 and y <= 93 and not player.menu.settings and not abilityFunctions.checkMenuDisplay() and not player.menu.rolledAbilityDisplay and not player.menu.saveStats then
        love.system.openURL("https://discord.gg/V576eHJQH3")
    end
    elseif player.menu.saveStats then
        if x >= 910 and x <= 1010 and y >= 780 and y <= 820 then
            player.menu.saveStats = false
        end
    end
end