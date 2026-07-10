--- Draw the tower and enemy stats and misc. info while in a battle.
function towerInfo_visual()
    -- Determine the Y offset based on whether the upgrades menu is open
    local yOffset = player.menu.upgrades and 719 or 999

    --[[ Print out tower info ]]--
    love.graphics.setColor(accentColors[player.misc.theme].towerInfo)
    love.graphics.rectangle("fill", 10, yOffset, 200, 70)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle("line", 10, yOffset, 200, 70)
    love.graphics.setLineWidth(2)
    love.graphics.setLineStyle("smooth")
    
    if player.tower.currentHealth > 0 then
        love.graphics.setColor(0, 0.5, 0.2, 1)
        love.graphics.rectangle("fill", 15, yOffset + 40, (player.tower.currentHealth / player.tower.health) * 190, 25, 2, 2)
    end
    
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle("line", 15, yOffset + 40, 190, 25, 2, 2)
    love.graphics.setFont(font_AfacadBold20)
    love.graphics.printf(string.format("%s/%s", notations.convertToLetterNotation(player.tower.currentHealth, "precise"), notations.convertToLetterNotation(player.tower.health, "precise")), 10, yOffset + 38, 200, "center")
    
    love.graphics.draw(img_icon_player_attack, 15, yOffset + 5)
    love.graphics.setFont(font_Afacad20)
    love.graphics.printf(string.format("%s", notations.convertToLetterNotation(player.tower.attackDamage, "precise")), 42, yOffset + 2, 200, "left")
    love.graphics.setLineWidth(1)
    love.graphics.setLineStyle("rough")

    --[[ Print out enemy info ]]--
    love.graphics.setColor(accentColors[player.misc.theme].towerInfo)
    love.graphics.rectangle("fill", 1690, yOffset, 220, 70)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle("line", 1690, yOffset, 220, 70)
    
    love.graphics.draw(img_icon_enemy_health, 1695, yOffset + 5)
    love.graphics.printf(string.format("%s", notations.convertToLetterNotation(enemyAttributes.health, "precise")), 1722, yOffset + 2, 200, "left")
    
    love.graphics.draw(img_icon_enemy_attack, 1695, yOffset + 41)
    love.graphics.printf(string.format("%s", notations.convertToLetterNotation(enemyAttributes.attackDamage, "precise")), 1722, yOffset + 38, 200, "left")

    --[[ Print out gameplay info ]]--
    love.graphics.printf(string.format("Wave %d (D%d)", gameplay.wave, gameplay.difficulty), 1755, yOffset + 2, 150, "right")
    love.graphics.setLineStyle("smooth")
    love.graphics.setColor(0.2, 0.2, 0.2, 1)
    love.graphics.ellipse("line", 1875, yOffset + 46, 20, 20)
    love.graphics.ellipse("fill", 1875, yOffset + 46, 20, 20)
    
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setLineStyle("smooth")
    love.graphics.setLineWidth(1)
    
    -- Calculate arc percentage
    local arcPercent = 0
    if timers.nextWave == 0 then
        arcPercent = player.stats.wave.enemiesKilled / enemyAttributes.waveCap
    else
        arcPercent = timers.nextWave / gameplay.waveCooldown
    end
    
    local startAngle = 1.5 * math.pi
    local endAngle = 3.5 * math.pi - (arcPercent * 2 * math.pi)
    
    love.graphics.arc("line", 1875, yOffset + 46, 20, startAngle, endAngle)
    love.graphics.arc("fill", 1875, yOffset + 46, 20, startAngle, endAngle)
    
    love.graphics.setColor(accentColors[player.misc.theme].towerInfo)
    love.graphics.setLineWidth(10)
    love.graphics.ellipse("line", 1875, yOffset + 46, 5, 5)
end