function towerInfo_visual()
    if not player.menu.upgrades then
        --[[ Print out tower info ]]--
        love.graphics.setColor(0.106, 0.11, 0.22, 1)
        love.graphics.rectangle("fill", 10, 950, 200, 70)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.rectangle("line", 10, 950, 200, 70)
        love.graphics.setLineWidth(2)
        love.graphics.setLineStyle("smooth")
        if player.tower.currentHealth > 0 then
            love.graphics.setColor(0, 0.5, 0.2, 1)
            love.graphics.rectangle("fill", 15, 990, (player.tower.currentHealth/player.tower.maxHealth) * 190, 25, 2, 2)
        end
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.rectangle("line", 15, 990, 190, 25, 2, 2)
        love.graphics.setFont(font_VeraBold16)
        love.graphics.printf(string.format("%s/%s", notations.convertToLetterNotation(player.tower.currentHealth, "precise"), notations.convertToLetterNotation(player.tower.maxHealth, "precise")), 10, 993, 200, "center")
        love.graphics.draw(img_icon_player_attack, 15, 955)
        love.graphics.setFont(font_Afacad20)
        love.graphics.printf(string.format("%s", notations.convertToLetterNotation(player.tower.attackDamage, "precise")), 42, 952, 200, "left")
        love.graphics.setLineWidth(1)
        love.graphics.setLineStyle("rough")

        --[[ Print out enemy info ]]--
        love.graphics.setColor(0.106, 0.11, 0.22, 1)
        love.graphics.rectangle("fill", 1690, 950, 220, 70)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.rectangle("line", 1690, 950, 220, 70)
        love.graphics.draw(img_icon_enemy_health, 1695, 955)
        love.graphics.printf(string.format("%s", notations.convertToLetterNotation(enemyAttributes.health, "precise")), 1722, 952, 200, "left")
        love.graphics.draw(img_icon_enemy_attack, 1695, 991)
        love.graphics.printf(string.format("%s", notations.convertToLetterNotation(enemyAttributes.attackDamage, "precise")), 1722, 988, 200, "left")

        --[[ Print out gameplay info ]]--
        love.graphics.setFont(font_Afacad20)
        if gameplay.difficulty == 1 then
            love.graphics.printf(string.format("Wave %d", gameplay.wave), 1755, 952, 150, "right")
        else
            love.graphics.printf(string.format("Wave %d", gameplay.wave), 1740, 952, 150, "right")
            love.graphics.setFont(font_ViraSansBold20)
            love.graphics.printf(string.format("%s", levelNames[gameplay.difficulty]), 1854, 953, 50, "right")
        end
        love.graphics.setLineStyle("smooth")
        love.graphics.setColor(0.2, 0.2, 0.2, 1)
        love.graphics.ellipse("line", 1875, 996, 20, 20)
        love.graphics.ellipse("fill", 1875, 996, 20, 20)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setLineStyle("smooth")
        love.graphics.setLineWidth(1)
        if timers.nextWave == 0 then
            love.graphics.arc("line", 1875, 996, 20, 1.5*math.pi, 3.5*math.pi - ((player.stats.wave.enemiesKilled / enemyAttributes.waveCap) * 2 * math.pi))
            love.graphics.arc("fill", 1875, 996, 20, 1.5*math.pi, 3.5*math.pi - ((player.stats.wave.enemiesKilled / enemyAttributes.waveCap) * 2 * math.pi))
        else
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.arc("line", 1875, 996, 20, 1.5*math.pi, 3.5*math.pi - (timers.nextWave / gameplay.waveCooldown) * 2 * math.pi)
            love.graphics.arc("fill", 1875, 996, 20, 1.5*math.pi, 3.5*math.pi - (timers.nextWave / gameplay.waveCooldown) * 2 * math.pi)
        end
        love.graphics.setColor(0.106, 0.11, 0.22, 1)
        love.graphics.setLineWidth(10)
        love.graphics.ellipse("line", 1875, 996, 5, 5)
        
    else
        --[[ Print out tower info ]]--
        love.graphics.setColor(0.106, 0.11, 0.22, 1)
        love.graphics.rectangle("fill", 10, 720, 200, 70)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.rectangle("line", 10, 720, 200, 70)
        love.graphics.setLineWidth(2)
        love.graphics.setLineStyle("smooth")
        if player.tower.currentHealth > 0 then
            love.graphics.setColor(0, 0.5, 0.2, 1)
            love.graphics.rectangle("fill", 15, 760, (player.tower.currentHealth/player.tower.maxHealth) * 190, 25, 2, 2)
        end
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.rectangle("line", 15, 760, 190, 25, 2, 2)
        love.graphics.setFont(font_VeraBold16)
        love.graphics.printf(string.format("%s/%s", notations.convertToLetterNotation(player.tower.currentHealth, "precise"), notations.convertToLetterNotation(player.tower.maxHealth, "precise")), 10, 763, 200, "center")
        love.graphics.draw(img_icon_player_attack, 15, 725)
        love.graphics.setFont(font_Afacad20)
        love.graphics.printf(string.format("%s", notations.convertToLetterNotation(player.tower.attackDamage, "precise")), 42, 722, 200, "left")
        love.graphics.setLineWidth(1)
        love.graphics.setLineStyle("rough")

        --[[ Print out enemy info ]]--
        love.graphics.setColor(0.106, 0.11, 0.22, 1)
        love.graphics.rectangle("fill", 1690, 720, 220, 70)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.rectangle("line", 1690, 720, 220, 70)
        love.graphics.draw(img_icon_enemy_health, 1695, 725)
        love.graphics.printf(string.format("%s", notations.convertToLetterNotation(enemyAttributes.health, "precise")), 1722, 722, 200, "left")
        love.graphics.draw(img_icon_enemy_attack, 1695, 761)
        love.graphics.printf(string.format("%s", notations.convertToLetterNotation(enemyAttributes.attackDamage, "precise")), 1722, 758, 200, "left")

        --[[ Print out gameplay info ]]--
        if gameplay.difficulty == 1 then
            love.graphics.printf(string.format("Wave %d", gameplay.wave), 1755, 722, 150, "right")
        else
            love.graphics.printf(string.format("Wave %d", gameplay.wave), 1740, 722, 150, "right")
            love.graphics.setFont(font_ViraSansBold20)
            love.graphics.printf(string.format("%s", levelNames[gameplay.difficulty]), 1854, 723, 50, "right")
        end
        love.graphics.setLineStyle("smooth")
        love.graphics.setColor(0.2, 0.2, 0.2, 1)
        love.graphics.ellipse("line", 1875, 766, 20, 20)
        love.graphics.ellipse("fill", 1875, 766, 20, 20)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setLineStyle("smooth")
        love.graphics.setLineWidth(1)
        if timers.nextWave == 0 then
            love.graphics.arc("line", 1875, 766, 20, 1.5*math.pi, 3.5*math.pi - ((player.stats.wave.enemiesKilled / enemyAttributes.waveCap) * 2 * math.pi))
            love.graphics.arc("fill", 1875, 766, 20, 1.5*math.pi, 3.5*math.pi - ((player.stats.wave.enemiesKilled / enemyAttributes.waveCap) * 2 * math.pi))
        else
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.arc("line", 1875, 766, 20, 1.5*math.pi, 3.5*math.pi - (timers.nextWave / gameplay.waveCooldown) * 2 * math.pi)
            love.graphics.arc("fill", 1875, 766, 20, 1.5*math.pi, 3.5*math.pi - (timers.nextWave / gameplay.waveCooldown) * 2 * math.pi)
        end
        love.graphics.setColor(0.106, 0.11, 0.22, 1)
        love.graphics.setLineWidth(10)
        love.graphics.ellipse("line", 1875, 766, 5, 5)
    end
end