function drawUpgradeMenu()
    if player.menu.upgrades then
        love.graphics.setLineStyle("smooth")
        love.graphics.setLineWidth(3)
        if background == "main" or background == "stellar" then
            love.graphics.setColor(0.106, 0.11, 0.22, 1)
        elseif background == "eclipse" then
            love.graphics.setColor(0.13, 0.05, 0, 1)
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
            ["ATK"] = {0.8, 0.35, 0, 1},
            ["VIT"] = {0, 0.7, 0.8, 1},
            ["UTL"] = {0, 0.8, 0.4, 1}
        }
            love.graphics.setColor(sectionColors[roundUpgradeSection])
            love.graphics.print("(" .. roundUpgradeSection .. ")", 145, 816)

            for i,v in ipairs(upgradeModules["round"][roundUpgradeSection]) do
                processUpgradeModule.draw(upgradeModules["round"][roundUpgradeSection][i])
            end

        love.graphics.setColor(1, 1, 1, 1)
    else
        love.graphics.setLineStyle("smooth")
        love.graphics.setLineWidth(3)
        if background == "main" or background == "stellar" then
            love.graphics.setColor(0.106, 0.11, 0.22, 1)
        elseif background == "eclipse" then
            love.graphics.setColor(0.13, 0.05, 0, 1)
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

function upgradeMenu_mouse(x, y)
    if player.menu.upgrades and not player.menu.paused and player.tower.currentHealth > 0 then

        if roundUpgradeSection == "ATK" then
            player.upgrades.round.attackDamage.level, player.upgrades.round.attackDamage.cost, player.tower.attackDamage = processUpgradeModule.upgrade(x, y, upgradeModules["round"]["ATK"][1], reloadFormulae(upgradeModules["science"]["ATK"][1][8], upgradeModules["round"]["ATK"][1][8] + 1)["round"]["ATK"][1][1], reloadFormulae(upgradeModules["science"]["ATK"][1][8], upgradeModules["round"]["ATK"][1][8] + 1)["round"]["ATK"][1][2])
            player.upgrades.round.attackSpeed.level, player.upgrades.round.attackSpeed.cost, player.tower.attackSpeed = processUpgradeModule.upgrade(x, y, upgradeModules["round"]["ATK"][2], reloadFormulae(upgradeModules["science"]["ATK"][2][8], upgradeModules["round"]["ATK"][2][8] + 1)["round"]["ATK"][2][1], reloadFormulae(upgradeModules["science"]["ATK"][2][8], upgradeModules["round"]["ATK"][2][8] + 1)["round"]["ATK"][2][2])
            player.upgrades.round.critChance.level, player.upgrades.round.critChance.cost, player.tower.critChance = processUpgradeModule.upgrade(x, y, upgradeModules["round"]["ATK"][3], reloadFormulae(upgradeModules["science"]["ATK"][3][8], upgradeModules["round"]["ATK"][3][8] + 1)["round"]["ATK"][3][1], reloadFormulae(upgradeModules["science"]["ATK"][3][8], upgradeModules["round"]["ATK"][3][8] + 1)["round"]["ATK"][3][2])
            player.upgrades.round.critFactor.level, player.upgrades.round.critFactor.cost, player.tower.critFactor = processUpgradeModule.upgrade(x, y, upgradeModules["round"]["ATK"][4], reloadFormulae(upgradeModules["science"]["ATK"][4][8], upgradeModules["round"]["ATK"][4][8] + 1)["round"]["ATK"][4][1], reloadFormulae(upgradeModules["science"]["ATK"][4][8], upgradeModules["round"]["ATK"][4][8] + 1)["round"]["ATK"][4][2])
            player.upgrades.round.range.level, player.upgrades.round.range.cost, player.tower.range = processUpgradeModule.upgrade(x, y, upgradeModules["round"]["ATK"][5], reloadFormulae(upgradeModules["science"]["ATK"][5][8], upgradeModules["round"]["ATK"][5][8] + 1)["round"]["ATK"][5][1], reloadFormulae(upgradeModules["science"]["ATK"][5][8], upgradeModules["round"]["ATK"][5][8] + 1)["round"]["ATK"][5][2])
        elseif roundUpgradeSection == "VIT" then
            player.upgrades.round.health.level, player.upgrades.round.health.cost, player.tower.maxHealth = processUpgradeModule.upgrade(x, y, upgradeModules["round"]["VIT"][1], reloadFormulae(upgradeModules["science"]["VIT"][1][8], upgradeModules["round"]["VIT"][1][8] + 1)["round"]["VIT"][1][1], reloadFormulae(upgradeModules["science"]["VIT"][1][8], upgradeModules["round"]["VIT"][1][8] + 1)["round"]["VIT"][1][2])
            player.upgrades.round.regeneration.level, player.upgrades.round.regeneration.cost, player.tower.regeneration = processUpgradeModule.upgrade(x, y, upgradeModules["round"]["VIT"][2], reloadFormulae(upgradeModules["science"]["VIT"][2][8], upgradeModules["round"]["VIT"][2][8] + 1)["round"]["VIT"][2][1], reloadFormulae(upgradeModules["science"]["VIT"][2][8], upgradeModules["round"]["VIT"][2][8] + 1)["round"]["VIT"][2][2])
            player.upgrades.round.resistance.level, player.upgrades.round.resistance.cost, player.tower.resistance = processUpgradeModule.upgrade(x, y, upgradeModules["round"]["VIT"][3], reloadFormulae(upgradeModules["science"]["VIT"][3][8], upgradeModules["round"]["VIT"][3][8] + 1)["round"]["VIT"][3][1], reloadFormulae(upgradeModules["science"]["VIT"][3][8], upgradeModules["round"]["VIT"][3][8] + 1)["round"]["VIT"][3][2])
            player.upgrades.round.shieldCooldown.level, player.upgrades.round.shieldCooldown.cost, player.tower.shieldCooldown = processUpgradeModule.upgrade(x, y, upgradeModules["round"]["VIT"][4], reloadFormulae(upgradeModules["science"]["VIT"][4][8], upgradeModules["round"]["VIT"][4][8] + 1)["round"]["VIT"][4][1], reloadFormulae(upgradeModules["science"]["VIT"][4][8], upgradeModules["round"]["VIT"][4][8] + 1)["round"]["VIT"][4][2])
            player.upgrades.round.shieldDuration.level, player.upgrades.round.shieldDuration.cost, player.tower.shieldDuration = processUpgradeModule.upgrade(x, y, upgradeModules["round"]["VIT"][5], reloadFormulae(upgradeModules["science"]["VIT"][5][8], upgradeModules["round"]["VIT"][5][8] + 1)["round"]["VIT"][5][1], reloadFormulae(upgradeModules["science"]["VIT"][5][8], upgradeModules["round"]["VIT"][5][8] + 1)["round"]["VIT"][5][2])
            player.upgrades.round.meteorAmount.level, player.upgrades.round.meteorAmount.cost, player.tower.meteorAmount = processUpgradeModule.upgrade(x, y, upgradeModules["round"]["VIT"][6], reloadFormulae(upgradeModules["science"]["VIT"][6][8], upgradeModules["round"]["VIT"][6][8] + 1)["round"]["VIT"][6][1], reloadFormulae(upgradeModules["science"]["VIT"][6][8], upgradeModules["round"]["VIT"][6][8] + 1)["round"]["VIT"][6][2])
            player.upgrades.round.meteorRPM.level, player.upgrades.round.meteorRPM.cost, player.tower.meteorRPM = processUpgradeModule.upgrade(x, y, upgradeModules["round"]["VIT"][7], reloadFormulae(upgradeModules["science"]["VIT"][7][8], upgradeModules["round"]["VIT"][7][8] + 1)["round"]["VIT"][7][1], reloadFormulae(upgradeModules["science"]["VIT"][7][8], upgradeModules["round"]["VIT"][7][8] + 1)["round"]["VIT"][7][2])
        elseif roundUpgradeSection == "UTL" then
            player.upgrades.round.copperPerWave.level, player.upgrades.round.copperPerWave.cost, player.tower.copperPerWave = processUpgradeModule.upgrade(x, y, upgradeModules["round"]["UTL"][1], reloadFormulae(upgradeModules["science"]["UTL"][1][8], upgradeModules["round"]["UTL"][1][8] + 1)["round"]["UTL"][1][1], reloadFormulae(upgradeModules["science"]["UTL"][1][8], upgradeModules["round"]["UTL"][1][8] + 1)["round"]["UTL"][1][2])
            player.upgrades.round.silverPerWave.level, player.upgrades.round.silverPerWave.cost, player.tower.silverPerWave = processUpgradeModule.upgrade(x, y, upgradeModules["round"]["UTL"][2], reloadFormulae(upgradeModules["science"]["UTL"][2][8], upgradeModules["round"]["UTL"][2][8] + 1)["round"]["UTL"][2][1], reloadFormulae(upgradeModules["science"]["UTL"][2][8], upgradeModules["round"]["UTL"][2][8] + 1)["round"]["UTL"][2][2])
            player.upgrades.round.copperBonus.level, player.upgrades.round.copperBonus.cost, player.tower.copperBonus = processUpgradeModule.upgrade(x, y, upgradeModules["round"]["UTL"][3], reloadFormulae(upgradeModules["science"]["UTL"][3][8], upgradeModules["round"]["UTL"][3][8] + 1)["round"]["UTL"][3][1], reloadFormulae(upgradeModules["science"]["UTL"][3][8], upgradeModules["round"]["UTL"][3][8] + 1)["round"]["UTL"][3][2])
            player.upgrades.round.silverBonus.level, player.upgrades.round.silverBonus.cost, player.tower.silverBonus = processUpgradeModule.upgrade(x, y, upgradeModules["round"]["UTL"][4], reloadFormulae(upgradeModules["science"]["UTL"][4][8], upgradeModules["round"]["UTL"][4][8] + 1)["round"]["UTL"][4][1], reloadFormulae(upgradeModules["science"]["UTL"][4][8], upgradeModules["round"]["UTL"][4][8] + 1)["round"]["UTL"][4][2])
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