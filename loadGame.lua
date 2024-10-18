function loadGame()
    if love.filesystem.getInfo("SAVEFILE.sav") then
        file = love.filesystem.read("SAVEFILE.sav")
        data = lume.deserialize(file)

        paused = false
        inHub = true
        timer_untilTokens = data.player.cooldowns.tokens or 600
        tokenCooldown = 600
        if timer_untilTokens > 0 then
            tokensOnCooldown = true
        else
            tokensOnCooldown = false
        end

        currentSilver = data.player.currentSilver or 0
        currentGold = data.player.currentGold or 0
        currentElectrum = data.player.currentElectrum or 0
        currentTokens = data.player.currentTokens or 0

        --[[ Set upgrade unlocks ]]--
        upgrade_unlock_crit = data.player.upgrades.unlocks.crit or false
        upgrade_unlock_range = data.player.upgrades.unlocks.range or false

        upgrade_unlock_resistance = data.player.upgrades.unlocks.resistance or false
        upgrade_unlock_shield = data.player.upgrades.unlocks.shield or false
        upgrade_unlock_meteor = data.player.upgrades.unlocks.meteor or false

        upgrade_unlock_resourceBonus = data.player.upgrades.unlocks.resourceBonus

        --[[ Set initial Science upgrade levels ]]--
        upgrade_science_attack_damage_level = data.player.upgrades.attack_damage or 1
        upgrade_science_attack_speed_level = data.player.upgrades.attack_speed or 1
        upgrade_science_critChance_level = data.player.upgrades.critical_chance or 1
        upgrade_science_critFactor_level = data.player.upgrades.critical_factor or 1
        upgrade_science_range_level = data.player.upgrades.range or 1

        upgrade_science_health_level = data.player.upgrades.health or 1
        upgrade_science_regeneration_level = data.player.upgrades.regeneration or 1
        upgrade_science_resistance_level = data.player.upgrades.resistance or 1
        upgrade_science_shieldCooldown_level = data.player.upgrades.shield_cooldown or 1
        upgrade_science_shieldDuration_level = data.player.upgrades.shield_duration or 1
        upgrade_science_meteor_amount_level = data.player.upgrades.meteor_amount or 1
        upgrade_science_meteor_RPM_level = data.player.upgrades.meteor_RPM or 1

        upgrade_science_copperPerWave_level = data.player.upgrades.copperPerWave or 1
        upgrade_science_silverPerWave_level = data.player.upgrades.silverPerWave or 1
        upgrade_science_copperBonus_level = data.player.upgrades.copperBonus or 1
        upgrade_science_silverBonus_level = data.player.upgrades.silverBonus or 1

        --[[ Set Science upgrade costs (in Silver) ]]--
        upgrade_science_attack_damage_cost = math.floor(0.4 * upgrade_science_attack_damage_level^2 + 2.6)
        upgrade_science_attack_speed_cost = math.floor(8^((upgrade_science_attack_speed_level - 1) / 20) + 3 * upgrade_science_attack_speed_level + 4)
        upgrade_science_critChance_cost = math.floor((upgrade_science_critChance_level / 2)^2 + 4 * upgrade_science_critChance_level + 1.75)
        upgrade_science_critFactor_cost = math.floor(0.2 * (upgrade_science_critFactor_level^2) + 1.8)
        upgrade_science_range_cost = math.floor((upgrade_science_range_level^2 + 5 * upgrade_science_range_level) / 3 + 2 * upgrade_science_range_level + 4)

        upgrade_science_health_cost = math.floor(0.6 * upgrade_science_health_level^2 + 3.4)
        upgrade_science_regeneration_cost = math.floor(upgrade_science_regeneration_level^1.75 + 2 * upgrade_science_regeneration_level + 3)
        upgrade_science_resistance_cost = math.floor(upgrade_science_resistance_level * math.sqrt(2 * upgrade_science_resistance_level) + 3 - math.sqrt(2))
        upgrade_science_shieldCooldown_cost = math.floor(upgrade_science_shieldCooldown_level^(math.log(upgrade_science_shieldCooldown_level, 10)) + 3)
        upgrade_science_shieldDuration_cost = math.floor((upgrade_science_shieldDuration_level)^(math.log(upgrade_science_shieldDuration_level) / 2) + 3)
        upgrade_science_meteor_amount_cost = math.floor((16 * upgrade_science_meteor_amount_level)^2 + 144)
        upgrade_science_meteor_RPM_cost = math.floor((3 * upgrade_science_meteor_RPM_level)^2 + 41)

        upgrade_science_copperPerWave_cost = math.floor((upgrade_science_copperPerWave_level^2 + upgrade_science_copperPerWave_level + 1) * 3 + 11)
        upgrade_science_silverPerWave_cost = math.floor(((8 * upgrade_science_silverPerWave_level) / 5)^2 + 27.44)
        upgrade_science_copperBonus_cost = math.floor((0.4 * (upgrade_science_copperBonus_level - 1))^1.9 + 8)
        upgrade_science_silverBonus_cost = math.floor(0.4 * upgrade_science_silverBonus_level^2 + upgrade_science_silverBonus_level + 8.6)

        --[[ Set initial Nexus upgrade levels ]]--
        upgrade_nexus_attack_damage_level = data.player.upgrades.nexus.attack_damage or 1
        upgrade_nexus_attack_speed_level = data.player.upgrades.nexus.attack_speed or 1
        upgrade_nexus_health_level = data.player.upgrades.nexus.health or 1
        upgrade_nexus_regeneration_level = data.player.upgrades.nexus.regeneration or 1
        
        --[[ Set Nexus upgrade multipliers ]]--
        upgrade_nexus_attack_damage_buff = math.min(1 + (upgrade_nexus_attack_damage_level - 1) * 10/100, 5)
        upgrade_nexus_attack_speed_buff = math.min(1 + (upgrade_nexus_attack_speed_level - 1) * 4/100, 2)
        upgrade_nexus_health_buff = math.min(1 + (upgrade_nexus_health_level - 1) * 10/100, 5)
        upgrade_nexus_regeneration_buff = math.min(1 + (upgrade_nexus_regeneration_level - 1) * 10/100, 5)

        --[[ Set Nexus upgrade costs (in Tokens) ]]--
        upgrade_nexus_attack_damage_cost = 50 + ((upgrade_nexus_attack_damage_level * (upgrade_nexus_attack_damage_level - 1)) / 2) * 10
        upgrade_nexus_attack_speed_cost = 50 + ((upgrade_nexus_attack_speed_level * (upgrade_nexus_attack_speed_level - 1)) / 2) * 10
        upgrade_nexus_health_cost = 50 + ((upgrade_nexus_health_level * (upgrade_nexus_health_level - 1)) / 2) * 10
        upgrade_nexus_regeneration_cost = 50 + ((upgrade_nexus_regeneration_level * (upgrade_nexus_regeneration_level - 1)) / 2) * 10

        --[[ Set ability unlocks ]]--
        ability_unlock_waveSkip = data.player.abilities.unlocks.waveSkip or false

        --[[ Set ability levels ]]--
        ability_waveSkip_chance_level = data.player.abilities.waveSkip.chance or 1

        --[[ Set ability costs (in Electrum) ]]--
        ability_waveSkip_chance_cost = (ability_waveSkip_chance_level * (ability_waveSkip_chance_level - 1)) / 2 + 4

        --[[ Set ability stats ]]--
        if ability_unlock_waveSkip then
            ability_waveSkip_chance = math.min(2 * ability_waveSkip_chance_level + 3, 35)
        else
            ability_waveSkip_chance = 0
        end

        settings_particleMultiplierIndex = data.settings.particleMultiplierIndex or 4
        settings_waveSkipMessages = data.settings.waveSkipMessages or true

    else

        paused = false
        inHub = false
        currentSilver = 0
        currentGold = 0
        currentElectrum = 0
        currentTokens = 0

        timer_untilTokens = 0
        tokenCooldown = 600
        tokensOnCooldown = false

        --[[ Set upgrade unlocks ]]--
        upgrade_unlock_crit = false
        upgrade_unlock_range = false

        upgrade_unlock_resistance = false
        upgrade_unlock_shield = false
        upgrade_unlock_meteor = false

        upgrade_unlock_resourceBonus = false

        --[[ Set initial Science upgrade levels ]]--
        upgrade_science_attack_damage_level = 1
        upgrade_science_attack_speed_level = 1
        upgrade_science_critChance_level = 1
        upgrade_science_critFactor_level = 1
        upgrade_science_range_level = 1

        upgrade_science_health_level = 1
        upgrade_science_regeneration_level = 1
        upgrade_science_resistance_level = 1
        upgrade_science_shieldCooldown_level = 1
        upgrade_science_shieldDuration_level = 1
        upgrade_science_meteor_amount_level = 1
        upgrade_science_meteor_RPM_level = 1

        upgrade_science_copperPerWave_level = 1
        upgrade_science_silverPerWave_level = 1
        upgrade_science_copperBonus_level = 1
        upgrade_science_silverBonus_level = 1

        --[[ Set Science upgrade costs (in Silver) ]]--
        upgrade_science_attack_damage_cost = math.floor(0.4 * upgrade_science_attack_damage_level^2 + 2.6)
        upgrade_science_attack_speed_cost = math.floor(8^((upgrade_science_attack_speed_level - 1) / 20) + 3 * upgrade_science_attack_speed_level + 4)
        upgrade_science_critChance_cost = math.floor((upgrade_science_critChance_level / 2)^2 + 4 * upgrade_science_critChance_level + 1.75)
        upgrade_science_critFactor_cost = math.floor(0.2 * (upgrade_science_critFactor_level^2) + 1.8)
        upgrade_science_range_cost = math.floor((upgrade_science_range_level^2 + 5 * upgrade_science_range_level) / 3 + 2 * upgrade_science_range_level + 4)

        upgrade_science_health_cost = math.floor(0.6 * upgrade_science_health_level^2 + 3.4)
        upgrade_science_regeneration_cost = math.floor(upgrade_science_regeneration_level^1.75 + 2 * upgrade_science_regeneration_level + 3)
        upgrade_science_resistance_cost = math.floor(upgrade_science_resistance_level * math.sqrt(2 * upgrade_science_resistance_level) + 3 - math.sqrt(2))
        upgrade_science_shieldCooldown_cost = math.floor(upgrade_science_shieldCooldown_level^(math.log(upgrade_science_shieldCooldown_level, 10)) + 3)
        upgrade_science_shieldDuration_cost = math.floor((upgrade_science_shieldDuration_level)^(math.log(upgrade_science_shieldDuration_level) / 2) + 3)
        upgrade_science_meteor_amount_cost = math.floor((16 * upgrade_science_meteor_amount_level)^2 + 144)
        upgrade_science_meteor_RPM_cost = math.floor((3 * upgrade_science_meteor_amount_level)^2 + 41)

        upgrade_science_copperPerWave_cost = math.floor((upgrade_science_copperPerWave_level^2 + upgrade_science_copperPerWave_level + 1) * 3 + 11)
        upgrade_science_silverPerWave_cost = math.floor(((8 * upgrade_science_silverPerWave_level) / 5)^2 + 27.44)
        upgrade_science_copperBonus_cost = math.floor((0.4 * (upgrade_science_copperBonus_level - 1))^1.9 + 8)
        upgrade_science_silverBonus_cost = math.floor(0.4 * upgrade_science_silverBonus_level^2 + upgrade_science_silverBonus_level + 8.6)

        --[[ Set initial Nexus upgrade levels ]]--
        upgrade_nexus_attack_damage_level = 1
        upgrade_nexus_attack_speed_level = 1
        upgrade_nexus_health_level = 1
        upgrade_nexus_regeneration_level = 1

        --[[ Set Nexus upgrade multipliers ]]--
        upgrade_nexus_attack_damage_buff = math.min(1 + (upgrade_nexus_attack_damage_level - 1) * 10/100, 5)
        upgrade_nexus_attack_speed_buff = math.min(1 + (upgrade_nexus_attack_speed_level - 1) * 4/100, 2)
        upgrade_nexus_health_buff = math.min(1 + (upgrade_nexus_health_level - 1) * 10/100, 5)
        upgrade_nexus_regeneration_buff = math.min(1 + (upgrade_nexus_regeneration_level - 1) * 10/100, 5)

        --[[ Set Nexus upgrade costs (in Tokens) ]]--
        upgrade_nexus_attack_damage_cost = 50 + ((upgrade_nexus_attack_damage_level * (upgrade_nexus_attack_damage_level - 1)) / 2) * 10
        upgrade_nexus_attack_speed_cost = 50 + ((upgrade_nexus_attack_speed_level * (upgrade_nexus_attack_speed_level - 1)) / 2) * 10
        upgrade_nexus_health_cost = 50 + ((upgrade_nexus_health_level * (upgrade_nexus_health_level - 1)) / 2) * 10
        upgrade_nexus_regeneration_cost = 50 + ((upgrade_nexus_regeneration_level * (upgrade_nexus_regeneration_level - 1)) / 2) * 10

        --[[ Set ability unlocks ]]--
        ability_unlock_waveSkip = false

        --[[ Set ability levels ]]--
        ability_waveSkip_chance_level = 1

        --[[ Set ability costs (in Electrum) ]]--
        ability_waveSkip_chance_cost = (ability_waveSkip_chance_level * (ability_waveSkip_chance_level - 1)) / 2 + 4

        --[[ Set ability stats ]]--
        ability_waveSkip_chance = 0

        settings_particleMultiplierIndex = 4
        settings_waveSkipMessages = true
    end
end

function resetRoundValues()
    --[[ Reset all properties to initial at the start of the round ]]--

    paused = false

    --[[ Copper ]]--
    currentCopper = 0

    --[[ Set Round upgrade levels to initial Science upgrade levels ]]--
    upgrade_round_attack_damage_level = upgrade_science_attack_damage_level
    upgrade_round_attack_speed_level = upgrade_science_attack_speed_level
    upgrade_round_critChance_level = upgrade_science_critChance_level
    upgrade_round_critFactor_level = upgrade_science_critFactor_level
    upgrade_round_range_level = upgrade_science_range_level

    upgrade_round_health_level = upgrade_science_health_level
    upgrade_round_regeneration_level = upgrade_science_regeneration_level
    upgrade_round_resistance_level = upgrade_science_resistance_level
    upgrade_round_shieldCooldown_level = upgrade_science_shieldCooldown_level
    upgrade_round_shieldDuration_level = upgrade_science_shieldDuration_level
    upgrade_round_meteor_amount_level = upgrade_science_meteor_amount_level
    upgrade_round_meteor_RPM_level = upgrade_science_meteor_RPM_level

    upgrade_round_copperPerWave_level = upgrade_science_copperPerWave_level
    upgrade_round_silverPerWave_level = upgrade_science_silverPerWave_level
    upgrade_round_copperBonus_level = upgrade_science_copperBonus_level
    upgrade_round_silverBonus_level = upgrade_science_silverBonus_level

    --[[ Set Round upgrade costs to what they would've costed at level 1 ]]--
    upgrade_round_attack_damage_cost = 2
    upgrade_round_attack_speed_cost = 5
    upgrade_round_critChance_cost = 6
    upgrade_round_critFactor_cost = 2
    upgrade_round_range_cost = 2

    upgrade_round_health_cost = 3
    upgrade_round_resistance_cost = 5
    upgrade_round_regeneration_cost = 4
    upgrade_round_shieldCooldown_cost = 4
    upgrade_round_shieldDuration_cost = 3
    upgrade_round_meteor_amount_cost = 200
    upgrade_round_meteor_RPM_cost = 20

    upgrade_round_copperPerWave_cost = 10
    upgrade_round_silverPerWave_cost = 10
    upgrade_round_copperBonus_cost = 4
    upgrade_round_silverBonus_cost = 7

    --[[ Tower properties ]]--
    tower_value_attack_damage = ((0.2 * upgrade_round_attack_damage_level - 0.2)^2.75 + 2.2 + upgrade_round_attack_damage_level) * upgrade_nexus_attack_damage_buff
    tower_value_attack_speed = (math.min(0.5 + 0.04 * (upgrade_round_attack_speed_level - 1), 4.5)) * upgrade_nexus_attack_speed_buff
    tower_value_critical_chance = math.min((upgrade_round_critChance_level - 1) / 2, 50)
    tower_value_critical_factor = 1 + ((upgrade_round_critFactor_level - 1) / 20)
    tower_value_range = math.min(240 + 3 * (upgrade_round_range_level - 1), 360)

    tower_value_maxHealth = ((0.2 * upgrade_round_health_level - 0.2)^3.75 + 4 + upgrade_round_health_level) * upgrade_nexus_health_buff
    tower_value_currentHealth = tower_value_maxHealth
    tower_value_healthRegen = (((2 * upgrade_round_regeneration_level + 1)^2) / 50 - 0.18) * upgrade_nexus_regeneration_buff
    tower_value_resistance = math.min(0.4 * (upgrade_round_resistance_level - 1), 80)
    tower_value_shield_cooldown = math.max(120 - 0.6 * (upgrade_round_shieldCooldown_level - 1), 45)
    tower_value_shield_duration = math.min(0.05 * (upgrade_round_shieldDuration_level - 1) + 0.5, 6)
    tower_value_meteor_amount = math.min(upgrade_round_meteor_amount_level - 1, 5)
    tower_value_meteor_RPM = math.min(0.15 * upgrade_round_meteor_RPM_level + 0.25, 6.25)

    --[[ Gameplay properties ]]--
    gameplay_wave = 1
    gameplay_wave_cooldown = 6
    gameplay_copperPerWave = 4 * (upgrade_round_copperPerWave_level - 1)
    gameplay_silverPerWave = 3 * (upgrade_round_silverPerWave_level - 1)
    gameplay_copperBonus = math.min(1 + 0.02 * (upgrade_science_copperBonus_level - 1), 10)
    gameplay_silverBonus = math.min(1 + 0.01 * (upgrade_science_silverBonus_level - 1), 4)
    gameplay_copperBuffer = 0
    gameplay_silverBuffer = 0

    --[[ Enemy properties ]]--
    enemySpawnRate = 0.6 + math.floor(gameplay_wave / 15) * 0.1
    pendingEnemies = 6 + math.floor(gameplay_wave / 15) * 3
    enemiesKilledThisWave = 0
    enemy_value_health = (1.95 + (gameplay_wave^2.25 / 20)) * (1.2^(math.floor(gameplay_wave / 100)))
    enemy_value_attack_damage = (1 + (gameplay_wave^2 / 40) - 0.024) * (1.1^math.floor(gameplay_wave / 100))
    enemy_value_attack_speed = 1

    --[[ Timers ]]--
    timer_untilProjectile = 0
    timer_untilEnemy = 0
    timer_untilNextWave = 0
    timer_untilShieldActive = 0
    timer_shieldActive = 0
    timer_waveSkipMessage = 0

    --[[ Misc ]]--
    waveSkipMessage = false
    projectilesOnField = {}
    enemiesOnField = {}
    particles = {}
    collapseParticles = {}
    meteorInitialAngles = {(0 * (2 * math.pi) / tower_value_meteor_amount) - 0.5 * math.pi,
        (1 * (2 * math.pi) / tower_value_meteor_amount) - 0.5 * math.pi,
        (2 * (2 * math.pi) / tower_value_meteor_amount) - 0.5 * math.pi,
        (3 * (2 * math.pi) / tower_value_meteor_amount) - 0.5 * math.pi,
        (4 * (2 * math.pi) / tower_value_meteor_amount) - 0.5 * math.pi
    }
    meteors = {}
    for i=1,tower_value_meteor_amount do
        createMeteor(meteorInitialAngles[i])
    end
    sentryAlive = false
    centurionAlive = false
end