function checkIfTowerCollapsed()
    if player.tower.currentHealth <= 0 then
        player.tower.currentHealth = 0
        gameEnd()
    end
end

function menu_display_gameOver()
    --[[ Draw the game over menu if the tower collapsed ]]--
    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle("fill", 0, 0, 1920, 1080)
    love.graphics.setColor(0.2, 0, 0.35, 1)
    love.graphics.rectangle("fill", 710, 240, 500, 600)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(font_AfacadBold32)
    love.graphics.printf("Game Over", 860, 250, 200, "center")
    love.graphics.printf(string.format("Wave: %d", gameplay.wave), 860, 310, 200, "center")
    love.graphics.setColor(0.1, 0.15, 0.5, 1)
    love.graphics.rectangle("fill", 870, 760, 180, 60)
    love.graphics.setColor(0.3, 0.75, 0.85, 1)
    love.graphics.setLineWidth(2)
    love.graphics.rectangle("line", 870, 760, 180, 60, 2, 2)
    love.graphics.setFont(font_Afacad28)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf("To Hub", 780, 770, 360, "center")
end

function gameEnd()
    if not gameOver then
        for i=1, 100 do
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
    end
    if #collapseParticles == 0 then
        gameSpeed = 0
    end
end