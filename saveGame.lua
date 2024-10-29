function saveGame()
    data = {}
    data.player = {
        currentSilver = player.currencies.currentSilver,
        currentGold = player.currencies.currentGold,
        currentElectrum = player.currencies.currentElectrum,
        currentTokens = player.currencies.currentTokens,
        upgrades = {
            unlocks = {
                crit = player.upgrades.unlocks.crit,
                range = player.upgrades.unlocks.range,
                clusterFire = player.upgrades.unlocks.clusterFire,

                resistance = player.upgrades.unlocks.resistance,
                shield = player.upgrades.unlocks.shield,
                meteor = player.upgrades.unlocks.meteor,

                resourceBonus = player.upgrades.unlocks.resourceBonus,
            },
            nexus = {
                attackDamage = player.upgrades.nexus.attackDamage.level,
                attackSpeed = player.upgrades.nexus.attackSpeed.level,
                health = player.upgrades.nexus.health.level,
                regeneration = player.upgrades.nexus.regeneration.level,
            },
            attackDamage = player.upgrades.science.attackDamage.level,
            attackSpeed = player.upgrades.science.attackSpeed.level,
            critChance = player.upgrades.science.critChance.level,
            critFactor = player.upgrades.science.critFactor.level,
            range = player.upgrades.science.range.level,
            
            health = player.upgrades.science.health.level,
            regeneration = player.upgrades.science.regeneration.level,
            resistance = player.upgrades.science.resistance.level,
            shieldCooldown = player.upgrades.science.shieldCooldown.level,
            shieldDuration = player.upgrades.science.shieldDuration.level,
            meteorAmount = player.upgrades.science.meteorAmount.level,
            meteorRPM = player.upgrades.science.meteorRPM.level,

            copperPerWave = player.upgrades.science.copperPerWave.level,
            silverPerWave = player.upgrades.science.silverPerWave.level,
            copperBonus = player.upgrades.science.copperBonus.level,
            silverBonus = player.upgrades.science.silverBonus.level,
        },

        timers = {
            tokens = player.timers.tokens,
            electrum = player.timers.electrum
        },

        abilities = {
            unlocks = {
                waveSkip = player.abilities.waveSkip.unlocked
            },
            waveSkip = {
                chance = player.abilities.waveSkip.level
            }
        },

        pb = {
            d1 = player.bestWaves.d1,
            d2 = player.bestWaves.d2,
            d3 = player.bestWaves.d3,
            d4 = player.bestWaves.d4,
        }
    }
    data.settings = {
        particleMultiplierIndex = player.settings.particleMultiplier,
        waveSkipMessages = player.settings.waveSkipMessages,
        notation = player.settings.notation,
        tooltips = player.settings.tooltips
    }

    serialized = lume.serialize(data)
    love.filesystem.write("SAVEFILE.sav", serialized)
end