local statTextScrollState = 0
local savefileVel = {velx = 0, vely = 0} -- The scroll velocity
local battleVel = {velx = 0, vely = 0} -- The scroll velocity
local enemyInfoVel = {velx = 0, vely = 0} -- The scroll velocity

statsMenus = {
    savefile = {},
    battle = {},
    enemyInfo = {}
}
function statsMenus.savefile.draw()
    love.graphics.setLineWidth(1)
    love.graphics.setLineStyle("smooth")
    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle("fill", 0, 0, 1920, 1080)
    love.graphics.setColor(accentColors[player.misc.theme].menus)
    love.graphics.rectangle("fill", 710, 240, 500, 600, 2, 2)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle("line", 710, 240, 500, 600, 2, 2)
    love.graphics.setFont(font_AfacadBold24)
    love.graphics.printf("Player Stats - Savefile", 710, 243, 500, "center")
    local statNames = {
        "Enemies Killed",
        "Damage Dealt",
        "Silver Earned",
        "Gold Earned",
        "Waves Skipped",
        "Projectiles Fired",
        "Science Upgrades",
        "Nexus Upgrades",
        "Waves Defeated",
        "Cluster Fire - Triggered",
        "Lifesteal - Triggered",
        "HP healed by Lifesteal",
        "Spiked Crystals - Enemies Killed",
        "Spiked Crystals - Damage Dealt",
        "Spiked Crystals - Crystals Spawned",
        "Scatter Fire - Damage Dealt",
        "Scatter Fire - Triggered",
        "Burst Fire - Damage Dealt",
        "Burst Fire - Triggered",
        "Ice Domain - Triggered",
        "Magma Touch - Enemies Killed",
        "Magma Touch - Damage Dealt",
        "Magma Touch - Pools Spawned",
        "Lightning Orb - Enemies Killed",
        "Lightning Orb - Damage Dealt",
        "Lightning Orb - Orbs Spawned",
        "Jerelo's Blessing - Triggered",
        "Jerelo's Blessing - Health Regenerated",
        "Supercritical - Hits",
        "Supercritical - Damage Dealt",
        "Disruption Wave - Triggered",
        "Disruption Wave - Damage Dealt",
        "Disruption Wave - Enemies Killed",
    }
    local statVars = {
        {player.stats.save.enemiesKilled, "brief"},
        {player.stats.save.damageDealt, "precise"},
        {player.stats.save.silverEarned, "brief"},
        {player.stats.save.goldEarned, "brief"},
        {player.stats.save.wavesSkipped, "brief"},
        {player.stats.save.projectilesFired, "brief"},
        {player.stats.save.upgradesAcquired.science, "brief"},
        {player.stats.save.upgradesAcquired.nexus, "brief"},
        {player.stats.save.wavesBeaten, "brief"},

        {player.stats.save.clusterFire.triggered, "brief"},
        
        {player.stats.save.lifesteal.triggered, "brief"},
        {player.stats.save.lifesteal.healed, "precise"},
        
        {player.stats.save.spikedCrystals.enemiesKilled, "brief"},
        {player.stats.save.spikedCrystals.damageDealt, "precise"},
        {player.stats.save.spikedCrystals.spawned, "brief"},

        {player.stats.save.scatterFire.damageDealt, "precise"},
        {player.stats.save.scatterFire.triggered, "brief"},

        {player.stats.save.burstFire.damageDealt, "precise"},
        {player.stats.save.burstFire.triggered, "brief"},

        {player.stats.save.iceDomain.triggered, "brief"},

        {player.stats.save.magmaTouch.enemiesKilled, "brief"},
        {player.stats.save.magmaTouch.damageDealt, "precise"},
        {player.stats.save.magmaTouch.spawned, "brief"},

        {player.stats.save.lightningOrb.enemiesKilled, "brief"},
        {player.stats.save.lightningOrb.damageDealt, "precise"},
        {player.stats.save.lightningOrb.spawned, "brief"},

        {player.stats.save.JerelosBlessing.triggered, "brief"},
        {player.stats.save.JerelosBlessing.healthRegenerated, "precise"},

        {player.stats.save.supercritical.triggered, "brief"},
        {player.stats.save.supercritical.damageDealt, "precise"},

        {player.stats.save.disruptWave.triggered, "brief"},
        {player.stats.save.disruptWave.damageDealt, "precise"},
        {player.stats.save.disruptWave.enemiesKilled, "brief"}
    }
    for i=1,math.min(#statNames, #statVars) do
        love.graphics.setScissor(710, 280, 500, 490)
        local rowCenter = (255 + i * 25) + math.floor(statTextScrollState)
        local color = {0, 1 - i / 50, 0.8 + i / 250}
        love.graphics.setFont(font_Afacad18)
        love.graphics.printf(statNames[i], 760, rowCenter, 300, "left")
        love.graphics.setFont(font_AfacadBold18)
        love.graphics.printf({color, string.format("%s", notations.convertToLetterNotation(statVars[i][1], statVars[i][2]))}, 860, rowCenter, 300, "right")
        love.graphics.setScissor()
    end
    for i=2,math.min(#statNames, #statVars) do
        love.graphics.setScissor(710, 280, 500, 490)
        local rowCenter = (255 + i * 25) + math.floor(statTextScrollState)
        local color = {1, 0.5 + i / 80, 0.2 - i / 250}
        local color = {0.25 + i / 64, 0.8, 0.4}
        love.graphics.setColor(color[1], color[2], color[3], 0.4)
        love.graphics.line(760, rowCenter + 1, 1160, rowCenter + 1)
        love.graphics.setScissor()
    end
    love.graphics.setColor(accentColors[player.misc.theme].buttons)
    love.graphics.rectangle("fill", 910, 780, 100, 40, 2, 2)
    love.graphics.setColor(accentColors[player.misc.theme].buttonOutlines)
    love.graphics.setLineWidth(2)
    love.graphics.rectangle("line", 910, 780, 100, 40, 2, 2)
    love.graphics.setFont(font_Afacad24)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf("Back", 910, 782, 100, "center")
end

function statsMenus.battle.draw()
    love.graphics.setLineWidth(1)
    love.graphics.setLineStyle("smooth")
    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle("fill", 0, 0, 1920, 1080)
    love.graphics.setColor(accentColors[player.misc.theme].menus)
    love.graphics.rectangle("fill", 710, 240, 500, 600, 2, 2)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle("line", 710, 240, 500, 600, 2, 2)
    love.graphics.setFont(font_AfacadBold24)
    love.graphics.printf("Player Stats - Battle", 710, 243, 500, "center")
    if player.tower.currentHealth > 0 then
        love.graphics.draw(img_button_arrowLeft_big, 674, 522)
    end
    local statNames = {
        "Battle Time (in-game)",
        "Battle Time (real)",
        "Enemies Killed",
        "Damage Taken",
        "Damage Dealt",
        "Copper Earned",
        "Silver Earned",
        "Gold Earned",
        "Damage Absorbed",
        "Waves Skipped",
        "Projectiles Fired",
        "Upgrades Acquired",
        "Cluster Fire - Triggered",
        "Lifesteal - Triggered",
        "HP healed by Lifesteal",
        "Spiked Crystals - Enemies Killed",
        "Spiked Crystals - Damage Dealt",
        "Spiked Crystals - Crystals Spawned",
        "Scatter Fire - Damage Dealt",
        "Scatter Fire - Triggered",
        "Burst Fire - Damage Dealt",
        "Burst Fire - Triggered",
        "Ice Domain - Triggered",
        "Magma Touch - Enemies Killed",
        "Magma Touch - Damage Dealt",
        "Magma Touch - Pools Spawned",
        "Lightning Orb - Enemies Killed",
        "Lightning Orb - Damage Dealt",
        "Lightning Orb - Orbs Spawned",
        "Jerelo's Blessing - Triggered",
        "Jerelo's Blessing - Health Regenerated",
        "Supercritical - Hits",
        "Supercritical - Damage Dealt",
        "Disruption Wave - Triggered",
        "Disruption Wave - Damage Dealt",
        "Disruption Wave - Enemies Killed"
    }
    local statVars = {
        player.stats.battle.gameTime,
        player.stats.battle.realTime,
        {player.stats.battle.enemiesKilled, "brief"},
        {player.stats.battle.damageTaken, "precise"},
        {player.stats.battle.damageDealt, "precise"},
        {player.stats.battle.copperEarned, "brief"},
        {player.stats.battle.silverEarned, "brief"},
        {player.stats.battle.goldEarned, "brief"},
        {player.stats.battle.shieldDamageAbsorb, "precise"},
        {player.stats.battle.wavesSkipped, "brief"},
        {player.stats.battle.projectilesFired, "brief"},
        {player.stats.battle.upgradesAcquired, "brief"},

        {player.stats.battle.clusterFire.triggered, "brief"},

        {player.stats.battle.lifesteal.triggered, "brief"},
        {player.stats.battle.lifesteal.healed, "precise"},
        
        {player.stats.battle.spikedCrystals.enemiesKilled, "brief"},
        {player.stats.battle.spikedCrystals.damageDealt, "precise"},
        {player.stats.battle.spikedCrystals.spawned, "brief"},

        {player.stats.battle.scatterFire.damageDealt, "precise"},
        {player.stats.battle.scatterFire.triggered, "brief"},

        {player.stats.battle.burstFire.damageDealt, "precise"},
        {player.stats.battle.burstFire.triggered, "brief"},

        {player.stats.battle.iceDomain.triggered, "brief"},

        {player.stats.battle.magmaTouch.enemiesKilled, "brief"},
        {player.stats.battle.magmaTouch.damageDealt, "precise"},
        {player.stats.battle.magmaTouch.spawned, "brief"},

        {player.stats.battle.lightningOrb.enemiesKilled, "brief"},
        {player.stats.battle.lightningOrb.damageDealt, "precise"},
        {player.stats.battle.lightningOrb.spawned, "brief"},

        {player.stats.battle.JerelosBlessing.triggered, "brief"},
        {player.stats.battle.JerelosBlessing.healthRegenerated, "precise"},

        {player.stats.battle.supercritical.triggered, "brief"},
        {player.stats.battle.supercritical.damageDealt, "precise"},

        {player.stats.battle.disruptWave.triggered, "brief"},
        {player.stats.battle.disruptWave.damageDealt, "precise"},
        {player.stats.battle.disruptWave.enemiesKilled, "brief"}
    }
    for i=1,math.min(#statNames, #statVars) do
        love.graphics.setScissor(710, 280, 500, 490)
        local rowCenter = (255 + i * 25) + math.floor(statTextScrollState)
        local color = {0, 1 - i / 50, 0.8 + i / 250}
        love.graphics.setFont(font_Afacad18)
        love.graphics.printf(statNames[i], 760, rowCenter, 300, "left")
        love.graphics.setFont(font_AfacadBold18)
        if i ~= 1 and i ~= 2 then
            love.graphics.printf({color, string.format("%s", notations.convertToLetterNotation(statVars[i][1], statVars[i][2]))}, 860, rowCenter, 300, "right")    
        else
            love.graphics.printf({color, string.format("%dm %ds", statVars[i] / 60, statVars[i] % 60)}, 860, rowCenter, 300, "right") 
        end
        love.graphics.setScissor()
    end
    for i=2,math.min(#statNames, #statVars) do
        love.graphics.setScissor(710, 280, 500, 490)
        local rowCenter = (255 + i * 25) + math.floor(statTextScrollState)
        local color = {1, 0.5 + i / 80, 0.2 - i / 250}
        love.graphics.setColor(color[1], color[2], color[3], 0.4)
        love.graphics.line(760, rowCenter + 1, 1160, rowCenter + 1)
        love.graphics.setScissor()
    end
    love.graphics.setColor(accentColors[player.misc.theme].buttons)
    love.graphics.rectangle("fill", 910, 780, 100, 40, 2, 2)
    love.graphics.setColor(accentColors[player.misc.theme].buttonOutlines)
    love.graphics.setLineWidth(2)
    love.graphics.rectangle("line", 910, 780, 100, 40, 2, 2)
    love.graphics.setFont(font_Afacad24)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf("Back", 910, 782, 100, "center")
end

function statsMenus.enemyInfo.draw()
    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle("fill", 0, 0, 1920, 1080)
    love.graphics.setColor(accentColors[player.misc.theme].menus)
    love.graphics.rectangle("fill", 760, 210, 400, 660, 2, 2)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setLineWidth(1)
    love.graphics.rectangle("line", 760, 210, 400, 660, 2, 2)
    love.graphics.setFont(font_AfacadBold28)
    love.graphics.printf("Enemy Info", 710, 213, 500, "center")

    love.graphics.setFont(font_Afacad18)
    font_Afacad20:setLineHeight(0.8)
    love.graphics.setScissor(760, 260, 400, 550)
    love.graphics.draw(img_enemy_basic, 770, 270 + math.floor(statTextScrollState), 0, 40/20, 40/20)
    love.graphics.printf("The Basics are considered to the cheapest and most expendable enemy group. Lacking any resistance types and special behaviours, they often can be destroyed relatively easily.", 820, 265 + math.floor(statTextScrollState), 330, "left")
    love.graphics.draw(img_enemy_tank, 770, 390 + math.floor(statTextScrollState), 0, 40/32, 40/32)
    love.graphics.printf("Colloquially known as \"Estorbo(s)\", these units offer five times as much health compared to the Basics at the cost of being 20% slower.", 820, 385 + math.floor(statTextScrollState), 330, "left")
    love.graphics.draw(img_enemy_swift, 770, 510 + math.floor(statTextScrollState), 0, 40/16, 40/16)
    love.graphics.printf("These units were designed to be good and quick when it comes to raiding the players' towers even though they only have 60% of the usual health. These have been equipped with a 2x speed multiplier, along with a 1.5x attack speed multiplier.", 820, 505 + math.floor(statTextScrollState), 330, "left")
    love.graphics.draw(img_enemy_sentry, 770, 680 + math.floor(statTextScrollState), 0, 40/44, 40/44)
    love.graphics.printf("Sentries are the weakest boss enemies the tower will meet. They come with ever-scaling health and 4 times as much base attack damage, albeit only attacking once per 1.33s. They are 40% slower and come every 10 waves.", 820, 675 + math.floor(statTextScrollState), 330, "left")
    love.graphics.draw(img_enemy_centurion, 770, 850 + math.floor(statTextScrollState), 0, 40/60, 40/60)
    love.graphics.printf("Every 100 waves, ZrTG sends out their biggest and toughest enemy: The Centurion. It has 256x health, 10x attack damage and comes with the new ZrTg's technology that lets enemies ignore the tower's Shield upgrades.", 820, 845 + math.floor(statTextScrollState), 330, "left")
    love.graphics.draw(img_enemy_exploder_static, 770, 1020 + math.floor(statTextScrollState), 0, 40/24, 40/24)
    love.graphics.printf("A brand new expensive unit in a beta-test from ZrTG. When killed or gets too close to the tower, it explodes and deals 250% damage to every entity in a 5u radius. Keeping distance from units of this type is crucial for survival.", 820, 1015 + math.floor(statTextScrollState), 330, "left")
    love.graphics.setScissor()

    love.graphics.setColor(accentColors[player.misc.theme].buttons)
    love.graphics.rectangle("fill", 890, 820, 140, 40)
    love.graphics.setColor(accentColors[player.misc.theme].buttonOutlines)
    love.graphics.setLineWidth(2)
    love.graphics.rectangle("line", 890, 820, 140, 40, 2, 2)
    love.graphics.setFont(font_Afacad24)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf("Back", 870, 822, 180, "center")
    love.graphics.setFont(font_Afacad20)
end

function statsMenus.savefile.process(logicStep)
    statTextScrollState = math.max(math.min(statTextScrollState + savefileVel.velx * logicStep, 0), 565-25*36)
    statTextScrollState = math.max(math.min(statTextScrollState + savefileVel.vely * logicStep, 0), 565-25*36)

    -- Gradually reduce the velocity to create smooth scrolling effect.
    savefileVel.velx = savefileVel.velx - savefileVel.velx * math.min(logicStep * 7, 1)
    savefileVel.vely = savefileVel.vely - savefileVel.vely * math.min(logicStep * 7, 1)
end

function statsMenus.battle.process(logicStep)
    statTextScrollState = math.max(math.min(statTextScrollState + battleVel.velx * logicStep, 0), 565-25*39)
    statTextScrollState = math.max(math.min(statTextScrollState + battleVel.vely * logicStep, 0), 565-25*39)

    -- Gradually reduce the velocity to create smooth scrolling effect.
    battleVel.velx = battleVel.velx - battleVel.velx * math.min(logicStep * 7, 1)
    battleVel.vely = battleVel.vely - battleVel.vely * math.min(logicStep * 7, 1)
end

function statsMenus.enemyInfo.process(logicStep)
    statTextScrollState = math.max(math.min(statTextScrollState + enemyInfoVel.velx * logicStep, 0), -350)
    statTextScrollState = math.max(math.min(statTextScrollState + enemyInfoVel.vely * logicStep, 0), -350)

    -- Gradually reduce the velocity to create smooth scrolling effect.
    enemyInfoVel.velx = enemyInfoVel.velx - enemyInfoVel.velx * math.min(logicStep * 7, 1)
    enemyInfoVel.vely = enemyInfoVel.vely - enemyInfoVel.vely * math.min(logicStep * 7, 1)
end

function statsMenus.resetScroll()
    local savefileVel = {velx = 0, vely = 0} -- The scroll velocity
    local battleVel = {velx = 0, vely = 0} -- The scroll velocity
    local enemyInfoVel = {velx = 0, vely = 0} -- The scroll velocity
    statTextScrollState = 0
end

function love.wheelmoved(dx, dy)
    if player.menu.saveStats then
        savefileVel.velx = savefileVel.velx + dx * 480
        savefileVel.vely = savefileVel.vely + dy * 480
    elseif player.menu.battleStats then
        battleVel.velx = battleVel.velx + dx * 480
        battleVel.vely = battleVel.vely + dy * 480
    elseif player.menu.enemyInfo then
        enemyInfoVel.velx = enemyInfoVel.velx + dx * 480
        enemyInfoVel.vely = enemyInfoVel.vely + dy * 480
    end
end