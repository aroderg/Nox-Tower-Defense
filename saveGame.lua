--- Save all settings, upgrades, unlocks, Abilities, cooldowns and timers in the save file.
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
            electrum = player.timers.electrum,
            abilityAssembly = player.timers.abilityAssembly
        },
        cooldowns = {
            abilityAssembly = player.cooldowns.abilityAssembly_current
        },

        modifiers = {
            unlocks = {
                waveSkip = player.modifiers.waveSkip.unlocked,
                hyperloop = player.modifiers.hyperloop.unlocked
            },
            waveSkip = {
                level = player.modifiers.waveSkip.level
            },
            hyperloop = {
                level = player.modifiers.hyperloop.level
            }
        },

        pb = {
            d1 = player.bestWaves.d1,
            d2 = player.bestWaves.d2,
            d3 = player.bestWaves.d3,
            d4 = player.bestWaves.d4,
        },

        stats = {
            enemiesKilled = player.stats.save.enemiesKilled,
            damageDealt = player.stats.save.damageDealt,
            silverEarned = player.stats.save.silverEarned,
            wavesSkipped = player.stats.save.wavesSkipped,
            projectilesFired = player.stats.save.projectilesFired,
            upgradesAcquired = {
                science = player.stats.save.upgradesAcquired.science,
                nexus = player.stats.save.upgradesAcquired.nexus
            },
            wavesBeaten = player.stats.save.wavesBeaten
        },

        abilities = {
            equipped = player.abilities.equipped;
            maxEquipped = player.abilities.maxEquipped,
            spikedCrystals = {
                unlocked = player.abilities.spikedCrystals.unlocked,
                level = player.abilities.spikedCrystals.level,
                equipped = player.abilities.spikedCrystals.equipped,
                amount = player.abilities.spikedCrystals.amount
            },
            scatterFire = {
                unlocked = player.abilities.scatterFire.unlocked,
                level = player.abilities.scatterFire.level,
                equipped = player.abilities.scatterFire.equipped,
                amount = player.abilities.scatterFire.amount
            },
            burstFire = {
                unlocked = player.abilities.burstFire.unlocked,
                level = player.abilities.burstFire.level,
                equipped = player.abilities.burstFire.equipped,
                amount = player.abilities.burstFire.amount
            },
            rainforest = {
                unlocked = player.abilities.rainforest.unlocked,
                level = player.abilities.rainforest.level,
                equipped = player.abilities.rainforest.equipped,
                amount = player.abilities.rainforest.amount
            },
            magmaTouch = {
                unlocked = player.abilities.magmaTouch.unlocked,
                level = player.abilities.magmaTouch.level,
                equipped = player.abilities.magmaTouch.equipped,
                amount = player.abilities.magmaTouch.amount
            },
            lightningOrb = {
                unlocked = player.abilities.lightningOrb.unlocked,
                level = player.abilities.lightningOrb.level,
                equipped = player.abilities.lightningOrb.equipped,
                amount = player.abilities.lightningOrb.amount
            },
            JerelosBlessing = {
                unlocked = player.abilities.JerelosBlessing.unlocked,
                level = player.abilities.JerelosBlessing.level,
                equipped = player.abilities.JerelosBlessing.equipped,
                amount = player.abilities.JerelosBlessing.amount
            }
        },

        misc = {
            abilityAssembling = player.misc.abilityAssembling
        }
    }
    data.settings = {
        particleMultiplierIndex = player.settings.particleMultiplier,
        waveSkipMessages = player.settings.waveSkipMessages,
        notation = player.settings.notation,
        tooltips = player.settings.tooltips,
        volume = player.settings.volume
    }

    serialized = lume.serialize(data)
    love.filesystem.write("SAVEFILE.sav", serialized)
end