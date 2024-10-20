function saveGame()
    data = {}
    data.player = {
        currentSilver = currentSilver,
        currentGold = currentGold,
        currentElectrum = currentElectrum,
        currentTokens = currentTokens,
        upgrades = {
            unlocks = {
                crit = upgrade_unlock_crit,
                range = upgrade_unlock_range,

                resistance = upgrade_unlock_resistance,
                shield = upgrade_unlock_shield,

                resourceBonus = upgrade_unlock_resourceBonus,
                meteor = upgrade_unlock_meteor
            },
            nexus = {
                attack_damage = upgrade_nexus_attack_damage_level,
                attack_speed = upgrade_nexus_attack_speed_level,
                health = upgrade_nexus_health_level,
                regeneration = upgrade_nexus_regeneration_level,
            },
            attack_damage = upgrade_science_attack_damage_level,
            attack_speed = upgrade_science_attack_speed_level,
            critical_chance = upgrade_science_critChance_level,
            critical_factor = upgrade_science_critFactor_level,
            range = upgrade_science_range_level,
            
            health = upgrade_science_health_level,
            regeneration = upgrade_science_regeneration_level,
            resistance = upgrade_science_resistance_level,
            shield_cooldown = upgrade_science_shieldCooldown_level,
            shield_duration = upgrade_science_shieldDuration_level,
            meteor_amount = upgrade_science_meteor_amount_level,
            meteor_RPM = upgrade_science_meteor_RPM_level,

            copperPerWave = upgrade_science_copperPerWave_level,
            silverPerWave = upgrade_science_silverPerWave_level,
            copperBonus = upgrade_science_copperBonus_level,
            silverBonus = upgrade_science_silverBonus_level,
        },

        cooldowns = {
            tokens = timer_untilTokens
        },

        abilities = {
            unlocks = {
                waveSkip = ability_unlock_waveSkip
            },
            waveSkip = {
                chance = ability_waveSkip_chance_level
            }
        },

        pb = {
            d1 = d1_best_wave,
            d2 = d2_best_wave,
            d3 = d3_best_wave,
            d4 = d4_best_wave,
        }
    }
    data.settings = {
        particleMultiplierIndex = settings_particleMultiplierIndex,
        waveskipMessages = settings_waveSkipMessages,
    }

    serialized = lume.serialize(data)
    love.filesystem.write("SAVEFILE.sav", serialized)
end