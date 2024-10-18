function checkIfTowerCollapsed()
    if tower_value_currentHealth <= 0 then
        tower_value_currentHealth = 0
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
    love.graphics.printf(string.format("Wave: %d", gameplay_wave), 860, 310, 200, "center")
    love.graphics.setColor(0.1, 0.15, 0.5, 1)
    love.graphics.rectangle("fill", 870, 760, 180, 60)
    love.graphics.setColor(0.3, 0.75, 0.85, 1)
    love.graphics.setLineWidth(2)
    love.graphics.rectangle("line", 870, 760, 180, 60, 3, 3)
    love.graphics.setFont(font_Afacad28)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf("To Hub", 780, 770, 360, "center")
end

function gameEnd()
    if not gameOver then
        for i=1, 200 do
            createCollapseParticle()
        end
        pendingEnemies = 0
        enemySpawnRate = 0
        closestEnemy = nil
        gameOver = true
    end
    if #collapseParticles == 0 then
        gameSpeed = 0
    end
end