towers = {}
--- Reloads all towers.
function towers.reload()
    local frameExact = 0
    local frame = 0
    local startDelayTimer = 0
    --- Main tower display.
    function towers.main()
        if player.tower.currentHealth > 0 then
            if not shieldActive then
                love.graphics.draw(img_tower_main, 928, 508)
            else
                love.graphics.draw(img_tower_main_shielded, 928, 508)
            end
        end
    end

    --- Eclipse tower display & processing.
    --- @param i boolean The "mode" of the tower, true for processing, false for rendering.
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

    --- Eclipse2 tower display & processing.
    --- @param i boolean The "mode" of the tower, true for processing, false for rendering.
    function towers.eclipse2(i, dt)
        love.graphics.setColor(1, 1, 1, 1)
        local maxFrames = 120
        local changeRate = 16
        local startDelay = 0
        if player.tower.currentHealth > 0 then
            if startDelayTimer < startDelay then
                if i then
                    startDelayTimer = startDelayTimer + dt
                else
                    if not shieldActive then
                        love.graphics.draw(img_tower_eclipse_sun2, 928, 508)
                    else
                        love.graphics.draw(img_tower_eclipse_sun2_shielded, 928, 508)
                    end
                end
            else
                if i then
                    frameExact = frameExact + dt * changeRate
                    frame = math.floor(frameExact)
                else
                    if not shieldActive then
                        love.graphics.draw(img_tower_eclipse_sun2, 928, 508)
                    else
                        love.graphics.draw(img_tower_eclipse_sun2_shielded, 928, 508)
                    end
                    love.graphics.draw(img_tower_eclipse_moon2, 950 + math.sin(frame / (maxFrames / math.pi)) * 20, 530)
                    love.graphics.draw(img_tower_eclipse_moon2, 950, 530 + math.sin(frame / (maxFrames / math.pi)) * 20)
                    love.graphics.draw(img_tower_eclipse_moon2, 950, 530 - math.sin(frame / (maxFrames / math.pi)) * 20)
                    love.graphics.draw(img_tower_eclipse_moon2, 950 - math.sin(frame / (maxFrames / math.pi)) * 20, 530)
                    love.graphics.setColor(1, 1, 1, 1)
                end
            end
        end
    end

    --- Nova tower display & processing.
    --- @param i boolean The "mode" of the tower, true for processing, false for rendering.
    function towers.nova(i, dt)
        local maxFrames = 2880
        local changeRate = 120
        local startDelay = 0
        if player.tower.currentHealth > 0 then
            if startDelayTimer < startDelay then
                if i then
                    startDelayTimer = startDelayTimer + dt
                else
                    love.graphics.draw(img_tower_nova_static, 928, 508)
                end
            else
                if i then
                    frameExact = frameExact + dt * changeRate
                    frame = math.floor(frameExact)
                else
                    love.graphics.setColor(1, 1, 1, 1)
                    love.graphics.draw(img_tower_nova_branches, 960, 540, -(frame*0.5/maxFrames) * 2 * math.pi, 1, 1, 32, 32)
                    love.graphics.draw(img_tower_nova_outerLines, 960, 540, (frame/maxFrames) * 2 * math.pi, 1, 1, 32, 32)
                    love.graphics.draw(img_tower_nova_static, 928, 508)
                    if shieldActive then
                        love.graphics.draw(img_tower_nova_shield, 960, 540, (frame*0.28/maxFrames) * 2 * math.pi, 1, 1, 32, 32)
                    end
                end
            end
        end
    end
end