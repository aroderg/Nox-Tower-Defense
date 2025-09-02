--- Draw the Upgrade menu while in battle.
function drawUpgradeMenu()
    if player.menu.upgrades then
        love.graphics.setLineStyle("smooth")
        love.graphics.setLineWidth(3)
        if background == "main" or background == "stellar" then
            love.graphics.setColor(0.106, 0.11, 0.22, 1)
        elseif background == "eclipse" then
            love.graphics.setColor(0.13, 0.05, 0, 1)
        elseif background == "nova" then
            love.graphics.setColor(0, 0.004, 0.1)
        end
        love.graphics.rectangle("fill", 860, 750, 200, 52)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.rectangle("line", 860, 750, 200, 52, 2, 2)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setFont(font_VeraBold16)
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
        love.graphics.rectangle("line", 1789, 801, 100, 40, 2, 2)
        love.graphics.printf("ATK", 1789, 803, 100, "center")
        love.graphics.setColor(0.8, 0.35, 0, 1)
        love.graphics.rectangle("fill", 1890, 800, 30, 93)
        love.graphics.setColor(1, 1, 1, 1)

        if roundUpgradeSection == "VIT" then
            love.graphics.setColor(1, 0, 0, 1)
        end
        love.graphics.setLineStyle("smooth")
        love.graphics.rectangle("line", 1789, 894, 100, 40, 2, 2)
        love.graphics.printf("VIT", 1789, 896, 100, "center")
        love.graphics.setColor(0, 0.7, 0.8, 1)
        love.graphics.rectangle("fill", 1890, 893, 30, 93)
        love.graphics.setColor(1, 1, 1, 1)

        if roundUpgradeSection == "UTL" then
            love.graphics.setColor(1, 0, 0, 1)
        end
        love.graphics.setLineStyle("smooth")
        love.graphics.rectangle("line", 1789, 987, 100, 40, 2, 2)
        love.graphics.printf("UTL", 1789, 989, 100, "center")
        love.graphics.setColor(0, 0.8, 0.4, 1)
        love.graphics.rectangle("fill", 1890, 986, 30, 93)

        love.graphics.setLineStyle("rough")
        love.graphics.setFont(font_VeraBold18)

        processUpgradeModule.reload()

        local sectionColors = {
            ATK = {0.8, 0.35, 0, 1},
            VIT = {0, 0.7, 0.8, 1},
            UTL = {0, 0.8, 0.4, 1}
        }
            love.graphics.setColor(sectionColors[roundUpgradeSection])
            love.graphics.print("(" .. roundUpgradeSection .. ")", 145, 816)

            for i,v in ipairs(upgradeModules["round"][roundUpgradeSection]) do
                processUpgradeModule.draw(upgradeModules["round"][roundUpgradeSection][i])
            end

        love.graphics.setColor(1, 1, 1, 1)
        if not player.menu.paused and player.tower.currentHealth > 0 and not player.menu.gameplayInfo and not player.menu.battleStats then
            tooltips.displayRound()
        end
    else
        love.graphics.setLineStyle("smooth")
        love.graphics.setLineWidth(3)
        if background == "main" or background == "stellar" then
            love.graphics.setColor(0.106, 0.11, 0.22, 1)
        elseif background == "eclipse" then
            love.graphics.setColor(0.13, 0.05, 0, 1)
        elseif background == "nova" then
            love.graphics.setColor(0, 0.004, 0.1)
        end
        love.graphics.rectangle("fill", 860, 1030, 200, 52)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.rectangle("line", 860, 1030, 200, 52, 2, 2)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setFont(font_VeraBold16)
        love.graphics.printf("Upgrades", 860, 1047, 200, "center")
        love.graphics.setLineStyle("rough")
        love.graphics.setLineWidth(1)
    end
end

--- Process all button clicks while the Upgrade menu is opened in battle.
---@param x number Mouse cursor position (horizontal).
---@param y number Mouse cursor position (vertical).
function upgradeMenu_mouse(x, y)
    if player.menu.upgrades and not player.menu.paused and player.tower.currentHealth > 0 and not player.menu.gameplayInfo and not player.menu.battleStats then

        local round = player.upgrades.round
        local upgradeNames = {
            ATK = {"attackDamage", "attackSpeed", "critChance", "critFactor", "range"},
            VIT = {"health", "regeneration", "resistance", "shieldCooldown", "shieldDuration", "meteorAmount", "meteorRPM"},
            UTL = {"copperPerWave", "silverPerWave", "copperBonus", "silverBonus"}
        }
        local upgradeSectionNames = {"ATK", "VIT", "UTL"}
        for i=1,#upgradeSectionNames do
            if roundUpgradeSection == upgradeSectionNames[i] then
                for j=1,#upgradeNames[roundUpgradeSection] do
                    if i == 2 and j == 1 then
                        round[upgradeNames[roundUpgradeSection][j]].level, round[upgradeNames[roundUpgradeSection][j]].cost, player.tower.health = processUpgradeModule.upgrade(x, y, upgradeModules["round"][roundUpgradeSection][j], reloadFormulae(upgradeModules["science"][roundUpgradeSection][j][8], upgradeModules["round"][roundUpgradeSection][j][8] + 1)["round"][roundUpgradeSection][j][1], reloadFormulae(upgradeModules["science"][roundUpgradeSection][j][8], upgradeModules["round"][roundUpgradeSection][j][8] + 1)["round"][roundUpgradeSection][j][2] * (player.abilities.JerelosBlessing.equipped and levelingInfo[7].healthIncrease[player.abilities.JerelosBlessing.level + 1] or 1))
                    else
                        round[upgradeNames[roundUpgradeSection][j]].level, round[upgradeNames[roundUpgradeSection][j]].cost, player.tower[upgradeNames[roundUpgradeSection][j]] = processUpgradeModule.upgrade(x, y, upgradeModules["round"][roundUpgradeSection][j], reloadFormulae(upgradeModules["science"][roundUpgradeSection][j][8], upgradeModules["round"][roundUpgradeSection][j][8] + 1)["round"][roundUpgradeSection][j][1], reloadFormulae(upgradeModules["science"][roundUpgradeSection][j][8], upgradeModules["round"][roundUpgradeSection][j][8] + 1)["round"][roundUpgradeSection][j][2])
                    end
                end
            end
        end

        -- Process upgrade section buttons and go to respective sections
        if x >= 1890 and x <= 1920 and y >= 800 and y <= 893 then
            roundUpgradeSection = "ATK"
        elseif x >= 1890 and x <= 1920 and y >= 893 and y <= 986 then
            roundUpgradeSection = "VIT"
        elseif x >= 1890 and x <= 1920 and y >= 986 and y <= 1079 then
            roundUpgradeSection = "UTL"
        end
    end
end

--- Process all button clicks while the Upgrade menu is opened in battle.
---@param x number Mouse cursor position (horizontal).
---@param y number Mouse cursor position (vertical).
function upgradeMenu_mouse_new(x, y)
    if player.menu.upgrades and not player.menu.paused and player.tower.currentHealth > 0 and not player.menu.gameplayInfo and not player.menu.battleStats then

        local round = player.upgrades.round
        local upgradeNames = {
            ATK = {"attackDamage", "attackSpeed", "critChance", "critFactor", "range"},
            VIT = {"health", "regeneration", "resistance", "shieldCooldown", "shieldDuration", "meteorAmount", "meteorRPM"},
            UTL = {"copperPerWave", "silverPerWave", "copperBonus", "silverBonus"}
        }
        local upgradeBonuses = {
            ATK = {
                attackDamage = (player.abilities.berserkerKit.equipped and 1 + levelingInfo[8].attackDamageIncrease[player.abilities.berserkerKit.level + 1] / 100 or 1),
                attackSpeed = (player.abilities.berserkerKit.equipped and 1 + levelingInfo[8].attackSpeedIncrease[player.abilities.berserkerKit.level + 1] / 100 or 1)
            },
            VIT = {
                health = (player.abilities.berserkerKit.equipped and 1 - levelingInfo[8].healthDecrease / 100 or 1) * (player.abilities.JerelosBlessing.equipped and levelingInfo[7].healthIncrease[player.abilities.JerelosBlessing.level + 1] or 1),
                resistance = (player.abilities.berserkerKit.equipped and 1 - levelingInfo[8].resistanceDecrease / 100 or 1)
            },
            UTL = {}
        }
        local upgradeSectionNames = {"ATK", "VIT", "UTL"}
        for i=1,#upgradeSectionNames do
            if roundUpgradeSection == upgradeSectionNames[i] then
                for j,w in pairs(upgradeNames[roundUpgradeSection]) do
                    round[upgradeNames[roundUpgradeSection][j]].level, round[upgradeNames[roundUpgradeSection][j]].cost, player.tower[upgradeNames[roundUpgradeSection][j]] = processUpgradeModule.upgrade(x, y, upgradeModules["round"][roundUpgradeSection][j], reloadFormulae(upgradeModules["science"][roundUpgradeSection][j][8], upgradeModules["round"][roundUpgradeSection][j][8] + 1)["round"][roundUpgradeSection][j][1], reloadFormulae(upgradeModules["science"][roundUpgradeSection][j][8], upgradeModules["round"][roundUpgradeSection][j][8] + 1)["round"][roundUpgradeSection][j][2] * (upgradeBonuses[roundUpgradeSection][w] or 1))
                end
            end
        end

        -- Process upgrade section buttons and go to respective sections
        if x >= 1890 and x <= 1920 and y >= 800 and y <= 893 then
            roundUpgradeSection = "ATK"
        elseif x >= 1890 and x <= 1920 and y >= 893 and y <= 986 then
            roundUpgradeSection = "VIT"
        elseif x >= 1890 and x <= 1920 and y >= 986 and y <= 1079 then
            roundUpgradeSection = "UTL"
        end
    end
end