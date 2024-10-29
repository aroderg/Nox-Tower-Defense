towers = {}
function towers.reload()
    local frameExact = 0
    local frame = 0
    local startDelayTimer = 0
    function towers.main()
        if player.tower.currentHealth > 0 and not shieldActive then
            if not shieldActive then
                love.graphics.draw(img_tower_main, 928, 508)
            else
                love.graphics.draw(img_tower_main_shielded, 928, 508)
            end
        end
    end
    function towers.eclipse(i, dt)
        local maxFrames = 120
        local changeRate = 24
        local startDelay = 0
        if player.tower.currentHealth > 0 then
            if startDelayTimer < startDelay then
                if i then
                    startDelayTimer = startDelayTimer + dt
                else
                    love.graphics.draw(img_tower_eclipse_sun, 928, 508)
                end
            else
                if i then
                    frameExact = frameExact + dt * changeRate
                    frame = math.floor(frameExact)
                else
                    love.graphics.draw(img_tower_eclipse_sun, 928, 508)
                    love.graphics.setColor(1, 1, 1, 0.5 + math.sin((frame - 0.5 * maxFrames) / (maxFrames / math.pi)) * 0.5)
                    love.graphics.draw(img_tower_eclipse_moon, 928, 508)
                    love.graphics.setColor(1, 1, 1, 1)
                end
            end
        end
    end
    function towers.eclipse2(i, dt)
        local maxFrames = 120
        local changeRate = 16
        local startDelay = 0
        if player.tower.currentHealth > 0 then
            if startDelayTimer < startDelay then
                if i then
                    startDelayTimer = startDelayTimer + dt
                else
                    love.graphics.draw(img_tower_eclipse_sun2, 928, 508)
                end
            else
                if i then
                    frameExact = frameExact + dt * changeRate
                    frame = math.floor(frameExact)
                else
                    love.graphics.draw(img_tower_eclipse_sun2, 928, 508)
                    love.graphics.draw(img_tower_eclipse_moon2, 950 + math.sin(frame / (maxFrames / math.pi)) * 20, 530)
                    love.graphics.draw(img_tower_eclipse_moon2, 950, 530 + math.sin(frame / (maxFrames / math.pi)) * 20)
                    love.graphics.draw(img_tower_eclipse_moon2, 950, 530 - math.sin(frame / (maxFrames / math.pi)) * 20)
                    love.graphics.draw(img_tower_eclipse_moon2, 950 - math.sin(frame / (maxFrames / math.pi)) * 20, 530)
                    love.graphics.setColor(1, 1, 1, 1)
                end
            end
        end
    end
end