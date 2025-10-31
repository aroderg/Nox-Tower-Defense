--- Check if the tower had collapsed.
function checkIfTowerCollapsed()
    if player.tower.currentHealth <= 0 then
        player.tower.currentHealth = 0
        gameEnd()
    end
end

--- Draw the game over menu if the tower collapse process has ended.
function menu_display_gameOver()
    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle("fill", 0, 0, 1920, 1080)
    love.graphics.setColor(accentColors[player.misc.theme].menus)
    love.graphics.rectangle("fill", 710, 380, 500, 320)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setLineWidth(1)
    love.graphics.rectangle("line", 710, 380, 500, 320, 3, 3)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(font_AfacadBold32)
    love.graphics.printf("Game Over", 860, 380, 200, "center")
    love.graphics.setFont(font_AfacadBold24)
    love.graphics.printf(string.format("Wave: %d (D%d)", gameplay.wave, gameplay.difficulty), 860, 430, 200, "center")
    love.graphics.setFont(font_Afacad24)
    love.graphics.printf(string.format("Best Wave: %d", player.bestWaves["d" .. gameplay.difficulty]), 860, 458, 200, "center")
    love.graphics.setColor(accentColors[player.misc.theme].buttons)
    love.graphics.rectangle("fill", 890, 570, 140, 40)
    love.graphics.setColor(accentColors[player.misc.theme].buttonOutlines)
    love.graphics.setLineWidth(2)
    love.graphics.rectangle("line", 890, 570, 140, 40, 2, 2)
    love.graphics.setFont(font_Afacad24)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf("Stats", 870, 573, 180, "center")
    love.graphics.setColor(accentColors[player.misc.theme].buttons)
    love.graphics.rectangle("fill", 870, 620, 180, 60)
    love.graphics.setColor(accentColors[player.misc.theme].buttonOutlines)
    love.graphics.setLineWidth(2)
    love.graphics.rectangle("line", 870, 620, 180, 60, 2, 2)
    love.graphics.setFont(font_Afacad28)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf("To Hub", 780, 630, 360, "center")
end

--- If the tower's health reaches 0, it collapses after a while a Game Over screen pops up.
function gameEnd()
    if not gameOver then
        gameplay.gameSpeed = 1
        local tc = audio_tower_collapse:clone()
        tc:setVolume(1 * player.settings.volume^2)
        tc:play()
        for i=1,math.max(100*settings_particleMultipliers[player.settings.particleMultiplier], 1) do
            createCollapseParticle()
        end
        enemyAttributes.pendingEnemies = 0
        enemyAttributes.spawnRate = 0
        closestEnemy = nil
        gameOver = true
        if gameplay.wave > player.bestWaves.d1 and gameplay.difficulty == 1 then
            player.bestWaves.d1 = gameplay.wave
        elseif gameplay.wave > player.bestWaves.d2 and gameplay.difficulty == 2 then
            player.bestWaves.d2 = gameplay.wave
        elseif gameplay.wave > player.bestWaves.d3 and gameplay.difficulty == 3 then
            player.bestWaves.d3 = gameplay.wave
        elseif gameplay.wave > player.bestWaves.d4 and gameplay.difficulty == 4 then
            player.bestWaves.d4 = gameplay.wave
        elseif gameplay.wave > player.bestWaves.d5 and gameplay.difficulty == 5 then
            player.bestWaves.d4 = gameplay.wave
        end
        if player.bestWaves.d1 > 99 then
            player.difficulty.unlocks.d2 = true
        end
        if player.bestWaves.d2 > 99 then
            player.difficulty.unlocks.d3 = true
        end
        if player.bestWaves.d3 > 150 then
            player.difficulty.unlocks.d4 = true
        end
        if player.bestWaves.d4 > 150 then
            player.difficulty.unlocks.d5 = true
        end
        abilityFunctions.updateSlotCount()
    end
    if #collapseParticles == 0 then
        gameplay.gameSpeed = 0
    end
    -- audioST_Echoes:stop()
end