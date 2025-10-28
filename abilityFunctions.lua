abilityFunctions = {
    showInfo = {}
}

--- Calculates an offset that is used to center all the Abilities while in the "Ability" Hub section.
---@param n number The number of the Ability.
function abilityFunctions.calculateOffset(n)
    local cols = {525, 705, 885, 1065, 1245}
    return cols[(n - 1) % 5 + 1]
    --local alignmentOffset = 0
    --if n <= 5 then
        --alignmentOffset = (1920 - ((math.min(#internalAbilities, 6) * 150) + ((math.min(#internalAbilities - 1, 5)) * 30))) / 2
        --return alignmentOffset + (n % 6 - 0.5 + math.floor(n / 5)) * 180
    --[[else
        alignmentOffset = 1920 - (((n + 1) * 150) + ((n - 0.5) * 30))
        return alignmentOffset + (n % 6 - 0.5) * 360]]--
    --end
end

--- Draw the detailed ("Panel") appearance of the Ability.
---@param ability table The Ability to draw.
function abilityFunctions.showInfo.draw(ability)
    if ability.menu then
        local roleColors = {
            active = {0.98, 0.44, 0.24},
            link = {0.5, 0.99, 0.52},
            passive = {0.45, 0.61, 0.89},
        }
        love.graphics.setColor(0, 0, 0, 0.5)
        love.graphics.rectangle("fill", 0, 0, 1920, 1080)
        love.graphics.setColor(accentColors[player.misc.theme].menus)
        love.graphics.rectangle("fill", 660, 340, 600, 400, 2, 2)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setLineStyle("smooth")
        love.graphics.setLineWidth(1)
        love.graphics.setFont(font_Afacad24)
        love.graphics.setColor(1, 1, 1, 0.25 + 0.75 * (ability.unlocked and 1 or 0))
        love.graphics.draw(ability.preview, 885, 360)
        love.graphics.setFont(font_AfacadBold24)
        love.graphics.printf(ability.name, 810, 470, 300, "center")
        local roleTagColor = roleColors[(tostring(ability.tags.role)):sub(1, 1):lower() .. (tostring(ability.tags.role)):sub(2, -1)]
        love.graphics.setColor(roleTagColor)
        love.graphics.rectangle("fill", 890, 440, 15, 15, 2, 2)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setFont(font_Afacad24)
        if ability.level < #ability.levelRequirements - 1 then
            love.graphics.printf("Level " .. ability.level .. string.format(" (%d/%d)", ability.amount, ability.nextLevelRequirement), 670, 355, 216, "center")
        else
            love.graphics.printf("Level " .. ability.level .. string.format(" (%d)", ability.amount), 670, 355, 216, "center")
        end
        love.graphics.setFont(font_Afacad20)
        love.graphics.setLineWidth(1)
        if ability.level < #ability.levelRequirements - 1 then
            love.graphics.setColor(1, 0, 0, 1)
            love.graphics.rectangle("fill", 708, 390, 140, 8)
            love.graphics.setColor(0, 1, 0, 1)
            love.graphics.rectangle("fill", 708, 390, math.min(ability.amount / ability.levelRequirements[ability.level + 1], 1) * 140, 8)
        end
        love.graphics.setLineStyle("rough")
        love.graphics.setColor(0.25, 0, 0.4, 1)
        love.graphics.rectangle("fill", 700, 418, 156, 40)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.rectangle("line", 700, 418, 156, 40)
        if ability.level < #ability.levelRequirements - 1 then
            love.graphics.printf(string.format("Enhance (lvl %d)", ability.level + 1), 700, 424, 156, "center")
        else
            love.graphics.printf("Max level!", 700, 424, 156, "center")
        end
        local classColor =
            ability.class == "D" and {0.6, 0.5, 0.3, 1} or
            ability.class == "C" and {0.45, 0.66, 0.75, 1} or
            ability.class == "B" and {0.35, 0.8, 0.75, 1} or
            ability.class == "A" and {0.25, 0.9, 0.75, 1} or
            {1, 1, 1, 1}
        local freqSuffix = ability.tags.condition == "Time" and "s" or (ability.tags.condition == "Projectile Fired" or ability.tags.condition == "Wave Start") and "%" or ""
        if ability.name == "Ice Domain" then
            freqSuffix = " waves"
        end
        local rowOffset = freqSuffix ~= "" and -16 or 0
        love.graphics.printf({{1, 1, 1, 1}, "Class: ", classColor, ability.class}, 1035, 381 + rowOffset, 224, "center")
        love.graphics.printf({{1, 0.75, 0.5, 1}, table.len(ability.tags), {1, 1, 1, 1}, " tags"}, 1035, 411 + rowOffset, 224, "center")
        love.graphics.draw(img_button_questionMark, 1180, 414 + rowOffset)
        --love.graphics.printf("Event: " .. ability.event, 1035, 385, 224, "center")
        --love.graphics.printf({{1, 1, 1, 1}, "Frequency: ", {0.35, 0.95, 0.7, 1}, not ability.guaranteed and ability.frequency or string.format("1/%d", ability.frequency), {1, 1, 1, 1}, ability.guaranteed and "(G)" or "", {1, 1, 1, 1}, ability.event == "Time" and "s" or not ability.guaranteed and "%" or ""}, 1035, 415, 224, "center")
        if freqSuffix ~= "" then
            love.graphics.printf(freqSuffix == "s" and string.format("Frequency: %.1f", ability.frequency) .. freqSuffix or freqSuffix == " waves" and string.format("Frequency: %d", ability.frequency) .. freqSuffix or string.format("Frequency: %.2f", ability.frequency) .. freqSuffix, 1035, 441 + rowOffset, 224, "center")
        end
        love.graphics.setLineWidth(1)
        love.graphics.setLineStyle("smooth")
        love.graphics.printf(ability.effect, 680, 510, 560, "left")
        love.graphics.rectangle("line", 885, 360, 150, 100, 2, 2)
        love.graphics.rectangle("line", 660, 340, 600, 400, 2, 2)
        love.graphics.setColor(accentColors[player.misc.theme].buttons)
        love.graphics.rectangle("fill", 910, 680, 100, 40, 2, 2)
        love.graphics.setColor(accentColors[player.misc.theme].buttonOutlines)
        love.graphics.setLineWidth(2)
        love.graphics.rectangle("line", 910, 680, 100, 40, 2, 2)
        love.graphics.setFont(font_Afacad24)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf("Back", 910, 682, 100, "center")
        tooltips.displayAbilityTags()
    end
end

--- Equip or unequip the given Ability.
---@param x number Mouse cursor position (horizontal).
---@param y number Mouse cursor position (vertical).
---@param ax number The horizontal position of the Ability.
---@param ay number The vertical position of the Ability.
---@param ability table The Ability to equip or unequip.
function abilityFunctions.changeEquipState(x, y, ax, ay, ability)
    if x >= ax and x <= ax + 70 and y >= ay and y <= ay + 25 then
        if ability.unlocked and (ability.equipped and (player.abilities.equipped <= player.abilities.maxEquipped) or (player.abilities.equipped < player.abilities.maxEquipped)) and not abilityFunctions.checkMenuDisplay() and not player.menu.rolledAbilityDisplay and abilityFunctions.checkForCompatibility(ability) then
            return not ability.equipped
        else
            return ability.equipped
        end
    else
        return ability.equipped
    end
end

function abilityFunctions.checkForCompatibility(ability)
    local compatible = true
    if ability.tags.incompatibilities then
        for i,v in pairs(ability.tags.incompatibilities) do
            if player.abilities[v].equipped then
                compatible = false
            end
        end
    end
    return compatible
end

--- Returns true if any Ability info menu is shown, used for checking if a click on any other button is valid.
function abilityFunctions.checkMenuDisplay()
    local abilityMenuShown = false

    for i=1,#internalAbilities do
        if internalAbilities[i].menu == true then
            abilityMenuShown = true
        end
    end
    return abilityMenuShown
end

--- Process if the Info button is pressed and open the Ability info menu if so. Additionally, processes the Back button press if the menu is opened.
---@param x number Mouse cursor position (horizontal).
---@param y number Mouse cursor position (vertical).
---@param ax number The horizontal position of the Ability.
---@param ay number The horizontal position of the Ability.
---@param ability table The Ability which menu is influenced.
function abilityFunctions.showInfo.process(x, y, ax, ay, ability)
    if ability.unlocked then
        if x >= ax and x <= ax + 70 and y >= ay and y <= ay + 25 and not ability.menu and not abilityFunctions.checkMenuDisplay() then
            return true
        end
        if x >= 910 and x <= 1010 and y >= 680 and y <= 720 and ability.menu and abilityFunctions.checkMenuDisplay() then
            return false
        elseif ability.menu then
            return true
        end
    end
end

function abilityFunctions.updateLeveling()
    levelingInfo = {
        {
            --| SPIKED CRYSTALS - LEVELS FROM 0 to 11 |--
            quantity =          {4,   4,   5,   5,   6,    6,    7,   7,   8,   8,   9,   10},
            damage =            {250, 275, 300, 325, 350,  375,  400, 450, 500, 550, 600, 600}, -- %
            frequency =         {16,  15,  14,  13,  12.2, 11.6, 10,  9.5, 9,   8.6, 8.2, 8}, -- seconds
            levelRequirements = {2,   2,   2,   3,   3,    4,    5,   6,   8,   10,  12,  15}
        },
        {
            --| SCATTER FIRE - LEVELS FROM 0 to 11 |--
            quantity =          {4, 4,   4, 6, 6,   6, 8,  8,   10,  10, 12, 16},
            frequency =         {1, 1.5, 2, 2, 2.5, 3, 3,  3.5, 3.5, 4,  4,  4}, -- % (chance)
            levelRequirements = {2, 2,   3, 3, 4,   4, 5,  6,   7,   8,  10, 15}
        },
        {
            --| BURST FIRE - LEVELS FROM 0 to 8 |--
            quantity =          {4,   4, 4,   6,   6, 8, 8,   12,   12, 12},
            frequency =         {1.5, 2, 2.5, 2.5, 3, 3, 3.5, 3.5,  4,  5}, -- % (chance)
            levelRequirements = {2,   3, 4,   5,   6, 8, 10,  15,   15, 18}
        },
        {
            --| RAINFOREST - LEVELS FROM 0 to 10 |--
            density =           {10, 12, 14, 16, 18, 20, 22.5, 25, 27.5, 30, 32.5}, -- % (slowdown)
            frequency =         10, -- waves
            levelRequirements = {1,  1,  2,  2,  3,  3,  4,    5,  6,    7,  8}
        },
        {
            --| MAGMA TOUCH - LEVELS FROM 0 to 9 |--
            frequency =         {33,  30,  27, 25, 23, 21, 19, 18, 17,   16}, -- seconds
            damage =            {7.5, 8.5, 10, 12, 14, 16, 18, 20, 23.5, 27.5}, -- %
            levelRequirements = {3,   3,   4,  4,  5,  7,  9,  12, 16,   20}
        },
        {
            --| LIGHTNING ORB - LEVELS FROM 0 to 8 |--
            frequency =         {30, 27,   24,  22,  20,  18,  17,  16,  15}, -- seconds
            damage =            {60, 65,   75,  85,  100, 115, 130, 145, 160}, -- %/s, constant damage
            range =             {4,  4.25, 4.5, 4.8, 5.1, 5.5, 5.9, 6.4, 7}, -- units
            levelRequirements = {2,  2,    3,   3,   4,   5,   6,   7,   9}
        },
        {
            --| JERELO'S BLESSING - LEVELS FROM 0 to 12 |--
            regenChance =       {0.1, 0.2,  0.3,  0.4,  0.6,  0.8,  1,    1.2,  1.4,  1.6,  1.8,  2,    2.25}, -- %
            healthIncrease =    {1.1, 1.15, 1.21, 1.28, 1.36, 1.45, 1.55, 1.66, 1.78, 1.91, 2.05, 2.25, 2.5}, -- multiplier (1 = 100%)
            levelRequirements = {1,   1,    1,    2,    2,    3,    3,    4,    4,    6,    8,    10,   12}
        },
        {
            --| BERSERKER'S KIT - LEVELS FROM 0 to 6 |--
            healthDecrease =       25, -- %
            resistanceDecrease =   25, -- %
            attackDamageIncrease = {15,  20,   25,   30,   35,   40,   50}, -- %
            attackSpeedIncrease =  {10,  12.5, 15,   17.5, 20,   22.5, 27.5}, -- %
            levelRequirements =    {4,   4,    5,    6,    7,    8,    11}
        },
        {
            --| SNIPER'S KIT - LEVELS FROM 0 to 8 |--
            attackSpeedDecrease =  40, -- %
            rangeIncrease =        {6, 8, 10, 12.5, 15, 17.5, 20, 22.5, 25}, -- %
            levelRequirements =    {4, 4, 5,  6,    7,  8,    11, 14,   18}
        },
        {
            --| TANK KIT - LEVELS FROM 0 to 6 |--
            attackDamageDecrease =  30, -- %
            attackSpeedDecrease =  10, -- %
            healthStatsIncrease =  {15, 18,   21,   24,  27,  30,   36}, -- %
            resistanceIncrease =   {1,  2.05, 3.15, 4.3, 5.5, 6.75, 7.05}, -- %
            levelRequirements =    {4,  4,    5,    6,   7,   8,    11}
        },
        {
            --| SUPERCRITICAL - LEVELS FROM 0 to 9 |--
            criticalChanceIncrease = {6,   7,    8,    10,   12,   14,   16,   19,   22,    25}, -- %
            criticalFactorIncrease = {1,   1.02, 1.05, 1.08, 1.12, 1.16, 1.2,  1.24, 1.28,  1.32}, -- multiplier (1 = 100%)
            supercriticalChance =    {1,   1.6,  2.2,  2.8,  3.4,  4,    4.75, 5.5,  6.3,   7.15}, -- %
            supercriticalFactor =    {2.5, 2.6,  2.7,  2.85, 3,    3.15, 3.35, 3.6,  3.85,  4.1}, -- multiplier (1 = 100%)
            levelRequirements =      {1,   1,    2,    3,    4,    6,    8,    10,   12,    16}
        },
        {
            --| DISRUPTANCE WAVE - LEVELS FROM 0 to 12 |--
            frequency =         8, -- seconds
            damage =            {15, 18, 21, 25, 29, 36, 45, 56, 69, 85, 105, 135, 180}, -- %
            levelRequirements = {1,  1,  1,  1,  1,  2,  2,  3,  5,  7,  9,   12,  15}
        }
    }
end

--- Update the ability levels and leveling info
function abilityFunctions.updateInternals()
    internalAbilities = {
        {
            name = "Spiked Crystals",
            internalName = "spikedCrystals",
            effect = {{1, 1, 1, 1}, "Spawn up to ", {1, 0.5, 0.4, 1}, levelingInfo[1].quantity[player.abilities.spikedCrystals.level + 1], {1, 1, 1, 1}, " crystals inside the tower's range. Upon getting touched by an enemy, the crystal explodes and deals ", {1, 0.4, 0.8, 1}, levelingInfo[1].damage[player.abilities.spikedCrystals.level + 1], {1, 1, 1, 1}, "% damage to nearby enemies."},
            tags = {condition = "Time", role = "Active", AoE = true, category = "VIT"},
            frequency = levelingInfo[1].frequency[player.abilities.spikedCrystals.level + 1] / player.upgrades.nexus.abilityCooldown.value,
            level = player.abilities.spikedCrystals.level,
            preview = img_ability_preview_spikedCrystals,
            equipped = player.abilities.spikedCrystals.equipped,
            unlocked = player.abilities.spikedCrystals.unlocked,
            menu = player.menu.abilities.spikedCrystals,
            amount = player.abilities.spikedCrystals.amount,
            class = "A",
            nextLevelRequirement = levelingInfo[1].levelRequirements[player.abilities.spikedCrystals.level + 1],
            levelRequirements = levelingInfo[1].levelRequirements
        },
        {
            name = "Scatter Fire",
            internalName = "scatterFire",
            effect = {{1, 1, 1, 1}, "Shoot out ", {0.5, 0.9, 0.8, 1}, levelingInfo[2].quantity[player.abilities.scatterFire.level + 1], {1, 1, 1, 1}, " projectiles going from a random point on the screen."},
            tags = {condition = "Projectile Fired", role = "Link", AoE = false, category = "ATK"},
            frequency = levelingInfo[2].frequency[player.abilities.scatterFire.level + 1] * player.upgrades.nexus.abilityChance.value,
            level = player.abilities.scatterFire.level,
            preview = img_ability_preview_scatterFire,
            equipped = player.abilities.scatterFire.equipped,
            unlocked = player.abilities.scatterFire.unlocked,
            menu = player.menu.abilities.scatterFire,
            amount = player.abilities.scatterFire.amount,
            class = "D",
            nextLevelRequirement = levelingInfo[2].levelRequirements[player.abilities.scatterFire.level + 1],
            levelRequirements = levelingInfo[2].levelRequirements
        },
        {
            name = "Burst Fire",
            internalName = "burstFire",
            effect = {{1, 1, 1, 1}, "Shoot out ", {0.75, 0.75, 0.75, 1}, levelingInfo[3].quantity[player.abilities.burstFire.level + 1], {1, 1, 1, 1}, " projectiles going from the center of the tower."},
            tags = {condition = "Projectile Fired", role = "Link", AoE = false, category = "ATK"},
            frequency = levelingInfo[3].frequency[player.abilities.burstFire.level + 1] * player.upgrades.nexus.abilityChance.value,
            level = player.abilities.burstFire.level,
            preview = img_ability_preview_burstFire,
            equipped = player.abilities.burstFire.equipped,
            unlocked = player.abilities.burstFire.unlocked,
            menu = player.menu.abilities.burstFire,
            amount = player.abilities.burstFire.amount,
            class = "D",
            nextLevelRequirement = levelingInfo[3].levelRequirements[player.abilities.burstFire.level + 1],
            levelRequirements = levelingInfo[3].levelRequirements
        },
        {
            name = "Ice Domain",
            internalName = "iceDomain",
            effect = {{1, 1, 1, 1}, "Cover the tower's range by an icy catalyst, slowing all enemies' move and attack speed by ", {0.5, 0.85, 1, 1}, levelingInfo[4].density[player.abilities.iceDomain.level + 1], {1, 1, 1, 1}, "%.\nFirst covering happens at wave 20."},
            tags = {condition = "Wave Start", role = "Passive", AoE = true, category = "VIT", incompatibilities = {"magmaTouch"}},
            frequency = levelingInfo[4].frequency,
            level = player.abilities.iceDomain.level,
            preview = img_ability_preview_iceDomain,
            equipped = player.abilities.iceDomain.equipped,
            unlocked = player.abilities.iceDomain.unlocked,
            menu = player.menu.abilities.iceDomain,
            amount = player.abilities.iceDomain.amount,
            class = "A",
            nextLevelRequirement = levelingInfo[4].levelRequirements[player.abilities.iceDomain.level + 1],
            levelRequirements = levelingInfo[4].levelRequirements
        },
        {
            name = "Magma Touch",
            internalName = "magmaTouch",
            effect = {{1, 1, 1, 1}, "Summon a magma pool in a random position on the screen. Applies a burning effect on any enemy touching it, dealing ", {1, 0.6, 0.15, 1}, levelingInfo[5].damage[player.abilities.magmaTouch.level + 1], {1, 1, 1, 1}, "% damage each second for 4 seconds before disappearing. Maximum of 20 magma pools."},
            tags = {condition = "Time", role = "Active", AoE = true, category = "VIT", incompatibilities = {"JerelosBlessing", "iceDomain"}},
            frequency = levelingInfo[5].frequency[player.abilities.magmaTouch.level + 1] / player.upgrades.nexus.abilityCooldown.value,
            level = player.abilities.magmaTouch.level,
            preview = img_ability_preview_magmaTouch,
            equipped = player.abilities.magmaTouch.equipped,
            unlocked = player.abilities.magmaTouch.unlocked,
            menu = player.menu.abilities.magmaTouch,
            amount = player.abilities.magmaTouch.amount,
            class = "C",
            nextLevelRequirement = levelingInfo[5].levelRequirements[player.abilities.magmaTouch.level + 1],
            levelRequirements = levelingInfo[5].levelRequirements
        },
        {
            name = "Lightning Orb",
            internalName = "lightningOrb",
            effect = {{1, 1, 1, 1}, "The tower shoots a flying lightning orb, shooting a laser to the farthest enemy within ", {1, 0.95, 0.55, 1}, levelingInfo[6].range[player.abilities.lightningOrb.level + 1], {1, 1, 1, 1}, "u, continuously dealing damage equal to ", {0.65, 0.45, 0.9, 1}, levelingInfo[6].damage[player.abilities.lightningOrb.level + 1], {1, 1, 1, 1}, "% damage per second."},
            tags = {condition = "Time", role = "Active", AoE = false, category = "ATK"},
            frequency = levelingInfo[6].frequency[player.abilities.lightningOrb.level + 1] / player.upgrades.nexus.abilityCooldown.value,
            level = player.abilities.lightningOrb.level,
            preview = img_ability_preview_lightningOrb,
            equipped = player.abilities.lightningOrb.equipped,
            unlocked = player.abilities.lightningOrb.unlocked,
            menu = player.menu.abilities.lightningOrb,
            amount = player.abilities.lightningOrb.amount,
            class = "B",
            nextLevelRequirement = levelingInfo[6].levelRequirements[player.abilities.lightningOrb.level + 1],
            levelRequirements = levelingInfo[6].levelRequirements
        },
        {
            name = "Jerelo's Blessing",
            internalName = "JerelosBlessing",
            effect = {{1, 1, 1, 1}, "The tower gathers energy from Jerelo, the Nature elemental, which provides it with a x", {0.4, 0.8, 1, 1}, levelingInfo[7].healthIncrease[player.abilities.JerelosBlessing.level + 1], {1, 1, 1, 1}, " increase of its maximum health and a ", {0.1, 0.75, 0.65, 1}, levelingInfo[7].regenChance[player.abilities.JerelosBlessing.level + 1] * player.upgrades.nexus.abilityChance.value, {1, 1, 1, 1}, "% chance to restore all health at the end of a wave."},
            tags = {condition = "None, Wave Finish", role = "Passive", AoE = false, category = "VIT", incompatibilities = {"magmaTouch"}},
            frequency = 1,
            level = player.abilities.JerelosBlessing.level,
            preview = img_ability_preview_JerelosBlessing,
            equipped = player.abilities.JerelosBlessing.equipped,
            unlocked = player.abilities.JerelosBlessing.unlocked,
            menu = player.menu.abilities.JerelosBlessing,
            amount = player.abilities.JerelosBlessing.amount,
            class = "A",
            nextLevelRequirement = levelingInfo[7].levelRequirements[player.abilities.JerelosBlessing.level + 1],
            levelRequirements = levelingInfo[7].levelRequirements
        },
        {
            name = "Berserker Kit",
            internalName = "berserkerKit",
            effect = {{1, 1, 1, 1}, "The tower sacrifices ", {0, 0.9, 0.75, 1}, levelingInfo[8].healthDecrease, {1, 1, 1, 1}, "% of its maximum health and ", {0, 0.1, 0.85, 1}, levelingInfo[8].resistanceDecrease, {1, 1, 1, 1}, "% of its resistance to instead increase its attack damage and attack speed by ", {0.6, 0.4, 0.75, 1}, levelingInfo[8].attackDamageIncrease[player.abilities.berserkerKit.level + 1], {1, 1, 1, 1}, "% and ", {0.45, 0.95, 0.8, 1}, levelingInfo[8].attackSpeedIncrease[player.abilities.berserkerKit.level + 1], {1, 1, 1, 1}, "% respectively.\nNegative Resistance = damage amplification."},
            tags = {condition = "None", role = "Passive", AoE = false, category = "ATK", incompatibilities = {"sniperKit", "tankKit"}},
            frequency = 1,
            level = player.abilities.berserkerKit.level,
            preview = img_ability_preview_berserkerKit,
            equipped = player.abilities.berserkerKit.equipped,
            unlocked = player.abilities.berserkerKit.unlocked,
            menu = player.menu.abilities.berserkerKit,
            amount = player.abilities.berserkerKit.amount,
            class = "B",
            nextLevelRequirement = levelingInfo[8].levelRequirements[player.abilities.berserkerKit.level + 1],
            levelRequirements = levelingInfo[8].levelRequirements
        },
        {
            name = "Sniper Kit",
            internalName = "sniperKit",
            effect = {{1, 1, 1, 1}, "Decreases the tower's attack speed by ", {0.8, 0.4, 0.45}, levelingInfo[9].attackSpeedDecrease, {1, 1, 1, 1}, "% but increases its attack range by ", {0.8, 0.35, 0.55}, levelingInfo[9].rangeIncrease[player.abilities.sniperKit.level + 1], {1, 1, 1, 1}, "%."},
            tags = {condition = "None", role = "Passive", AoE = false, category = "ATK", incompatibilities = {"berserkerKit", "tankKit"}},
            frequency = 1,
            level = player.abilities.sniperKit.level,
            preview = img_ability_preview_sniperKit,
            equipped = player.abilities.sniperKit.equipped,
            unlocked = player.abilities.sniperKit.unlocked,
            menu = player.menu.abilities.sniperKit,
            amount = player.abilities.sniperKit.amount,
            class = "B",
            nextLevelRequirement = levelingInfo[9].levelRequirements[player.abilities.sniperKit.level + 1],
            levelRequirements = levelingInfo[9].levelRequirements
        },
        {
            name = "Tank Kit",
            internalName = "tankKit",
            effect = {{1, 1, 1, 1}, "Exchange ", {0.44, 0.46, 1, 1}, levelingInfo[10].attackDamageDecrease, {1, 1, 1, 1}, "% of the tower's attack damage and ", {0, 0.95, 1}, levelingInfo[10].attackSpeedDecrease, {1, 1, 1, 1}, "% of attack speed for a ", {0.68, 0.35, 1, 1}, levelingInfo[10].healthStatsIncrease[player.abilities.tankKit.level + 1], {1, 1, 1, 1}, "% additional HP and regeneration, and a ", {0, 1, 0.63, 1}, levelingInfo[10].resistanceIncrease[player.abilities.tankKit.level + 1], {1, 1, 1, 1}, "% resistance bonus."},
            tags = {condition = "None", role = "Passive", AoE = false, category = "VIT", incompatibilities = {"berserkerKit", "sniperKit", "supercritical"}},
            frequency = 1,
            level = player.abilities.tankKit.level,
            preview = img_ability_preview_tankKit,
            equipped = player.abilities.tankKit.equipped,
            unlocked = player.abilities.tankKit.unlocked,
            menu = player.menu.abilities.tankKit,
            amount = player.abilities.tankKit.amount,
            class = "B",
            nextLevelRequirement = levelingInfo[10].levelRequirements[player.abilities.tankKit.level + 1],
            levelRequirements = levelingInfo[10].levelRequirements
        },
        {
            name = "Supercritical",
            internalName = "supercritical",
            effect = {{1, 1, 1, 1}, "Gives the tower a ", {1, 0.85, 0.58, 1}, levelingInfo[11].criticalChanceIncrease[player.abilities.supercritical.level + 1], {1, 1, 1, 1}, "% Critical Chance increase, x", {1, 0.71, 0.47}, levelingInfo[11].criticalFactorIncrease[player.abilities.supercritical.level + 1], {1, 1, 1, 1}, " Critical Factor increase, and ", {1, 0.29, 0.84, 1}, levelingInfo[11].supercriticalChance[player.abilities.supercritical.level + 1], {1, 1, 1, 1}, "% chance to deal additional x", {1, 0.2, 0.63, 1}, levelingInfo[11].supercriticalFactor[player.abilities.supercritical.level + 1], {1, 1, 1, 1}, " amount of critical damage on a Critical hit."},
            tags = {condition = "None, Projectile Fired", role = "Active", AoE = false, category = "ATK", incompatibilities = {"tankKit"}},
            frequency = 1,
            level = player.abilities.supercritical.level,
            preview = img_ability_preview_supercritical,
            equipped = player.abilities.supercritical.equipped,
            unlocked = player.abilities.supercritical.unlocked,
            menu = player.menu.abilities.supercritical,
            amount = player.abilities.supercritical.amount,
            class = "A",
            nextLevelRequirement = levelingInfo[11].levelRequirements[player.abilities.supercritical.level + 1],
            levelRequirements = levelingInfo[11].levelRequirements
        },
        {
            name = "Disruptance Wave",
            internalName = "disruptWave",
            effect = {{1, 1, 1, 1}, "Launch a blast wave dealing ", {0.28, 0.98, 0.48}, levelingInfo[12].damage[player.abilities.disruptWave.level + 1], {1, 1, 1, 1}, "% damage to all enemies within the tower's range."},
            tags = {condition = "Time", role = "Active", AoE = true, category = "ATK"},
            frequency = levelingInfo[12].frequency / player.upgrades.nexus.abilityCooldown.value,
            level = player.abilities.disruptWave.level,
            preview = img_ability_preview_disruptWave,
            equipped = player.abilities.disruptWave.equipped,
            unlocked = player.abilities.disruptWave.unlocked,
            menu = player.menu.abilities.disruptWave,
            amount = player.abilities.disruptWave.amount,
            class = "B",
            nextLevelRequirement = levelingInfo[12].levelRequirements[player.abilities.disruptWave.level + 1],
            levelRequirements = levelingInfo[12].levelRequirements
        }
        
    }

    abilityClasses = {"D", "C", "B", "A"}
    abilityClassProbabilities = {D = 60, C = 25, B = 10, A = 5}

    equipSlotRequirements = {
        {difficulty = 1, wave = 50},
        {difficulty = 1, wave = 100},
        {difficulty = 2, wave = 100},
        {difficulty = 2, wave = 200},
        {difficulty = 3, wave = 50},
        {difficulty = 4, wave = 50},
    }
end

function abilityFunctions.updateSlotCount()
    player.abilities.maxEquipped = 0
    for i,v in ipairs(equipSlotRequirements) do
        if player.bestWaves["d" .. v.difficulty] >= v.wave then
            player.abilities.maxEquipped = player.abilities.maxEquipped + 1
        else
            break
        end
    end
end

function abilityFunctions.upgrade(x, y, ability)
    if x >= 700 and x <= 856 and y >= 418 and y <= 458 then
        if ability.menu and ability.unlocked and ability.amount >= ability.levelRequirements[ability.level + 1] and ability.level < #ability.levelRequirements - 1 then
            ability.amount = ability.amount - ability.levelRequirements[ability.level + 1]
            ability.level = ability.level + 1
        end
    end
    return ability.level, ability.amount
end