function loadGame()
    if love.filesystem.getInfo("SAVEFILE.sav") then
        file = love.filesystem.read("SAVEFILE.sav")
        data = lume.deserialize(file)

        paused = false
        inHub = true
        tokenCooldown = 600
        if data then
            timer_untilTokens = data.player.cooldowns.tokens or 0
            if timer_untilTokens > 0 then
                tokensOnCooldown = true
            else
                tokensOnCooldown = false
            end

            timer_untilElectrum = data.player.cooldowns.electrum or 0
            if timer_untilElectrum > 0 then
                electrumAlloying = true
            else
                electrumAlloying = false
            end

            currentSilver = data.player.currentSilver or 0
            currentGold = data.player.currentGold or 0
            currentElectrum = data.player.currentElectrum or 0
            currentTokens = data.player.currentTokens or 0

            --[[ Set upgrade unlocks ]]--
            if data.player.upgrades.unlocks then
                upgrade_unlock_crit = data.player.upgrades.unlocks.crit or false
                upgrade_unlock_range = data.player.upgrades.unlocks.range or false
                upgrade_unlock_clusterFire = data.player.upgrades.unlocks.clusterFire or false

                upgrade_unlock_resistance = data.player.upgrades.unlocks.resistance or false
                upgrade_unlock_shield = data.player.upgrades.unlocks.shield or false
                upgrade_unlock_meteor = data.player.upgrades.unlocks.meteor or false

                upgrade_unlock_resourceBonus = data.player.upgrades.unlocks.resourceBonus or false
            end

            --[[ Set initial Science upgrade levels ]]--
            if data.player.upgrades then
                upgrade_science_attack_damage_level = data.player.upgrades.attack_damage or 1
                upgrade_science_attack_speed_level = data.player.upgrades.attack_speed or 1
                upgrade_science_critChance_level = data.player.upgrades.critical_chance or 1
                upgrade_science_critFactor_level = data.player.upgrades.critical_factor or 1
                upgrade_science_range_level = data.player.upgrades.range or 1
                upgrade_science_clusterFire_chance_level = data.player.upgrades.clusterFire_chance or 1
                upgrade_science_clusterFire_targets_level = data.player.upgrades.clusterFire_targets or 1
                upgrade_science_clusterFire_factor_level = data.player.upgrades.clusterFire_factor or 1
                upgrade_science_clusterFire_duration_level = data.player.upgrades.clusterFire_duration or 1

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
            end

            if data.player.abilities then
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
            end

            if data.settings then
                settings_particleMultiplierIndex = data.settings.particleMultiplierIndex or 4
                settings_waveSkipMessages = data.settings.waveSkipMessages or true
                settings_notation = data.settings.notation or "kmbt"
                settings_tooltips = data.settings.tooltips or true
            end

            if data.player.pb then
                d1_best_wave = data.player.pb.d1 or 0
                d2_best_wave = data.player.pb.d2 or 0
                d3_best_wave = data.player.pb.d3 or 0
                d4_best_wave = data.player.pb.d4 or 0
            end
        end

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
        upgrade_unlock_clusterFire = false

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
        upgrade_science_clusterFire_chance_level = 1
        upgrade_science_clusterFire_targets_level = 1
        upgrade_science_clusterFire_factor_level = 1
        upgrade_science_clusterFire_duration_level = 1

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
        settings_notation = "kmbt"
        settings_tooltips = true

        d1_best_wave = 0
        d2_best_wave = 0
        d3_best_wave = 0
        d4_best_wave = 0
    end

    --[[ Set Science upgrade costs (in Silver) ]]--
    upgrade_science_attack_damage_cost = math.floor(0.4 * upgrade_science_attack_damage_level^2 + 2.6)
    upgrade_science_attack_speed_cost = math.floor(8^((upgrade_science_attack_speed_level - 1) / 20) + 3 * upgrade_science_attack_speed_level + 4)
    upgrade_science_critChance_cost = math.floor((upgrade_science_critChance_level / 2)^2 + 4 * upgrade_science_critChance_level + 1.75)
    upgrade_science_critFactor_cost = math.floor(0.2 * (upgrade_science_critFactor_level^2) + 1.8)
    upgrade_science_range_cost = math.floor((upgrade_science_range_level^2 + 5 * upgrade_science_range_level) / 3 + 2 * upgrade_science_range_level + 4)
    --[[upgrade_science_clusterFire_chance_cost = math.floor((0.5 * (upgrade_science_clusterFire_chance_level - 1))^2 + 5 * (upgrade_science_clusterFire_chance_level - 1) + 30)
    upgrade_science_clusterFire_targets_cost = math.floor(172 + 28 * (upgrade_science_clusterFire_targets_level^3) + 4 * (upgrade_science_clusterFire_targets_level - 1))
    upgrade_science_clusterFire_factor_cost = math.floor((upgrade_science_clusterFire_factor_level * math.log(upgrade_science_clusterFire_factor_level, 10))^1.75 + 15 + 5 * (upgrade_science_clusterFire_factor_level - 1))
    upgrade_science_clusterFire_duration_cost = math.floor(upgrade_science_clusterFire_duration_level^2 + upgrade_science_clusterFire_duration_level + 23)]]--

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

    --[[ Set Nexus upgrade costs (in Tokens) ]]--
    upgrade_nexus_attack_damage_cost = 50 + ((upgrade_nexus_attack_damage_level * (upgrade_nexus_attack_damage_level - 1)) / 2) * 10
    upgrade_nexus_attack_speed_cost = 50 + ((upgrade_nexus_attack_speed_level * (upgrade_nexus_attack_speed_level - 1)) / 2) * 10
    upgrade_nexus_health_cost = 50 + ((upgrade_nexus_health_level * (upgrade_nexus_health_level - 1)) / 2) * 10
    upgrade_nexus_regeneration_cost = 50 + ((upgrade_nexus_regeneration_level * (upgrade_nexus_regeneration_level - 1)) / 2) * 10

    d2_unlocked = d1_best_wave > 150 and true or false
    d3_unlocked = d2_best_wave > 150 and true or false
    d4_unlocked = d3_best_wave > 150 and true or false

    saveGame()
end

function resetRoundValues()
    --[[ Reset all properties to initial at the start of the round ]]--

    paused = false

    --[[ Copper ]]--
    currentCopper = 555555

    --[[ Set Round upgrade levels to initial Science upgrade levels ]]--
    upgrade_round_attack_damage_level = upgrade_science_attack_damage_level
    upgrade_round_attack_speed_level = upgrade_science_attack_speed_level
    upgrade_round_critChance_level = upgrade_science_critChance_level
    upgrade_round_critFactor_level = upgrade_science_critFactor_level
    upgrade_round_range_level = upgrade_science_range_level
    upgrade_round_clusterFire_chance_level = upgrade_science_clusterFire_chance_level
    upgrade_round_clusterFire_targets_level = upgrade_science_clusterFire_targets_level
    upgrade_round_clusterFire_factor_level = upgrade_science_clusterFire_factor_level
    upgrade_round_clusterFire_duration_level = upgrade_science_clusterFire_duration_level

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
    upgrade_round_clusterFire_chance_cost = 20
    upgrade_round_clusterFire_targets_cost = 100
    upgrade_round_clusterFire_factor_cost = 15
    upgrade_round_clusterFire_duration_cost = 25

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
    tower_value_attack_damage = math.huge--((0.25 * upgrade_round_attack_damage_level - 0.25)^3 + 4) * upgrade_nexus_attack_damage_buff
    tower_value_attack_speed = (math.min(0.5 + 0.04 * (upgrade_round_attack_speed_level - 1), 4.5)) * upgrade_nexus_attack_speed_buff
    tower_value_critical_chance = math.min((upgrade_round_critChance_level - 1) / 2, 50)
    tower_value_critical_factor = 1 + ((upgrade_round_critFactor_level - 1) / 20)
    tower_value_range = math.min(240 + 2 * (upgrade_round_range_level - 1), 360)
    tower_value_clusterFire_chance = math.min(0.3 * (upgrade_round_clusterFire_chance_level - 1), 30)
    tower_value_clusterFire_targets = math.min(upgrade_round_clusterFire_targets_level + 1, 6)
    tower_value_clusterFire_factor = math.min(1 + (upgrade_round_clusterFire_factor_level - 1) / 50, 2)
    tower_value_clusterFire_duration = math.min(0.2 + 0.02 * (upgrade_round_clusterFire_duration_level - 1), 0.8)

    tower_value_maxHealth = ((0.3 * upgrade_round_health_level - 0.3)^3.75 + 14.6 + 0.4 * upgrade_round_health_level) * upgrade_nexus_health_buff
    tower_value_currentHealth = tower_value_maxHealth
    tower_value_healthRegen = (((0.8 * upgrade_round_regeneration_level - 0.8)^2.75) / 50) * upgrade_nexus_regeneration_buff
    tower_value_resistance = math.min(0.75 * (upgrade_round_resistance_level - 1), 90)
    tower_value_shield_cooldown = math.max(120 - 0.6 * (upgrade_round_shieldCooldown_level - 1), 45)
    tower_value_shield_duration = math.min(0.05 * (upgrade_round_shieldDuration_level - 1) + 0.5, 6)
    tower_value_meteor_amount = math.min(upgrade_round_meteor_amount_level - 1, 5)
    tower_value_meteor_RPM = math.min(0.15 * upgrade_round_meteor_RPM_level + 0.25, 6.25)

    --[[ Gameplay properties ]]--
    gameplay_wave = 1000
    gameplay_copperPerWave = 4 * (upgrade_round_copperPerWave_level - 1)
    gameplay_silverPerWave = 3 * (upgrade_round_silverPerWave_level - 1)
    gameplay_copperBonus = math.min(1 + 0.02 * (upgrade_science_copperBonus_level - 1), 10)
    gameplay_silverBonus = math.min(1 + 0.01 * (upgrade_science_silverBonus_level - 1), 4)
    gameplay_copperBuffer = 0
    gameplay_silverBuffer = 0

    --[[ Enemy properties ]]--
    updateEnemyStats(gameplay_difficulty, gameplay_wave)
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
    hitTextParticles = {}
    meteors = {}
    for i=1,tower_value_meteor_amount do
        createMeteor(((i-1) * (2 * math.pi) / tower_value_meteor_amount) - 0.5 * math.pi)
    end
    sentryAlive = false
    centurionAlive = false
end