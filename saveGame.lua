--- Save all settings, upgrades, unlocks, Abilities, cooldowns and timers in the save file.
function saveGame()
    toSave = {
        currentSilver = player.currencies.currentSilver,
        currentGold = player.currencies.currentGold,
        currentElectrum = player.currencies.currentElectrum,
        currentTokens = player.currencies.currentTokens,
        idleGains = {silver = player.idleGains.silver, gold = player.idleGains.gold},
        timeModified = socket.gettime(),
        idleTime = player.idleTime,
        storedGains = {silver = player.storedGains.silver, gold = player.storedGains.gold},
        upgrades = {
            unlocks = {
                crit = player.upgrades.unlocks.crit,
                range = player.upgrades.unlocks.range,
                clusterFire = player.upgrades.unlocks.clusterFire,

                resistance = player.upgrades.unlocks.resistance,
                shield = player.upgrades.unlocks.shield,
                meteor = player.upgrades.unlocks.meteor,
                lifesteal = player.upgrades.unlocks.lifesteal,

                resourceBonus = player.upgrades.unlocks.resourceBonus,
            },
            nexus = {
                attackDamage = {level = player.upgrades.nexus.attackDamage.level},
                attackSpeed = {level = player.upgrades.nexus.attackSpeed.level},
                health = {level = player.upgrades.nexus.health.level},
                regeneration = {level = player.upgrades.nexus.regeneration.level},
                abilityChance = {level = player.upgrades.nexus.abilityChance.level},
                abilityCooldown = {level = player.upgrades.nexus.abilityCooldown.level}
            },
            science = {
                attackDamage = {level = player.upgrades.science.attackDamage.level},
                attackSpeed = {level = player.upgrades.science.attackSpeed.level},
                critChance = {level = player.upgrades.science.critChance.level},
                critFactor = {level = player.upgrades.science.critFactor.level},
                range = {level = player.upgrades.science.range.level},
                clusterFireChance = {level = player.upgrades.science.clusterFireChance.level},
                clusterFireTargets = {level = player.upgrades.science.clusterFireTargets.level},
                clusterFireEfficiency = {level = player.upgrades.science.clusterFireEfficiency.level},
                
                health = {level = player.upgrades.science.health.level},
                regeneration = {level = player.upgrades.science.regeneration.level},
                resistance = {level = player.upgrades.science.resistance.level},
                shieldCooldown = {level = player.upgrades.science.shieldCooldown.level},
                shieldDuration = {level = player.upgrades.science.shieldDuration.level},
                meteorAmount = {level = player.upgrades.science.meteorAmount.level},
                meteorRPM = {level = player.upgrades.science.meteorRPM.level},
                lifestealChance = {level = player.upgrades.science.lifestealChance.level},
                lifestealPercent = {level = player.upgrades.science.lifestealPercent.level},

                copperPerWave = {level = player.upgrades.science.copperPerWave.level},
                silverPerWave = {level = player.upgrades.science.silverPerWave.level},
                copperBonus = {level = player.upgrades.science.copperBonus.level},
                silverBonus = {level = player.upgrades.science.silverBonus.level}
            }
        },

        timers = {
            tokens = player.timers.tokens,
            electrum = player.timers.electrum,
            abilityAssembly = player.timers.abilityAssembly
        },
        cooldowns = {
            abilityAssembly_current = player.cooldowns.abilityAssembly_current
        },

        modifiers = {
            waveSkip = {
                unlocked = player.modifiers.waveSkip.unlocked,
                level = player.modifiers.waveSkip.level
            },
            hyperloop = {
                unlocked = player.modifiers.hyperloop.unlocked,
                level = player.modifiers.hyperloop.level
            },
            acceleration = {
                unlocked = player.modifiers.acceleration.unlocked,
                level = player.modifiers.acceleration.level
            }
        },

        bestWaves = {
            d1 = player.bestWaves.d1,
            d2 = player.bestWaves.d2,
            d3 = player.bestWaves.d3,
            d4 = player.bestWaves.d4,
            d5 = player.bestWaves.d5,
        },

        stats = {
            save = {
                enemiesKilled = player.stats.save.enemiesKilled,
                damageDealt = player.stats.save.damageDealt,
                silverEarned = player.stats.save.silverEarned,
                goldEarned = player.stats.save.goldEarned,
                wavesSkipped = player.stats.save.wavesSkipped,
                projectilesFired = player.stats.save.projectilesFired,
                upgradesAcquired = {
                    science = player.stats.save.upgradesAcquired.science,
                    nexus = player.stats.save.upgradesAcquired.nexus
                },
                wavesBeaten = player.stats.save.wavesBeaten,
                clusterFire = {
                    triggered = player.stats.save.clusterFire.triggered
                },
                lifesteal = {
                    triggered = player.stats.save.lifesteal.triggered,
                    healed = player.stats.save.lifesteal.healed,
                },
                spikedCrystals = {
                    enemiesKilled = player.stats.save.spikedCrystals.enemiesKilled,
                    damageDealt = player.stats.save.spikedCrystals.damageDealt,
                    spawned = player.stats.save.spikedCrystals.spawned
                },
                scatterFire = {
                    damageDealt = player.stats.save.scatterFire.damageDealt,
                    triggered = player.stats.save.scatterFire.triggered
                },
                burstFire = {
                    damageDealt = player.stats.save.burstFire.damageDealt,
                    triggered = player.stats.save.burstFire.triggered
                },
                iceDomain = {
                    triggered = player.stats.save.iceDomain.triggered
                },
                magmaTouch = {
                    enemiesKilled = player.stats.save.magmaTouch.enemiesKilled,
                    damageDealt = player.stats.save.magmaTouch.damageDealt,
                    spawned = player.stats.save.magmaTouch.spawned
                },
                lightningOrb = {
                    enemiesKilled = player.stats.save.lightningOrb.enemiesKilled,
                    damageDealt = player.stats.save.lightningOrb.damageDealt,
                    spawned = player.stats.save.lightningOrb.spawned
                },
                JerelosBlessing = {
                    triggered = player.stats.save.JerelosBlessing.triggered,
                    healthRegenerated = player.stats.save.JerelosBlessing.healthRegenerated
                },
                supercritical = {
                    triggered = player.stats.save.supercritical.triggered,
                    damageDealt = player.stats.save.supercritical.damageDealt
                },
                disruptWave = {
                    triggered = player.stats.save.disruptWave.triggered,
                    damageDealt = player.stats.save.disruptWave.damageDealt,
                    enemiesKilled = player.stats.save.disruptWave.enemiesKilled
                }
            }
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
            iceDomain = {
                unlocked = player.abilities.iceDomain.unlocked,
                level = player.abilities.iceDomain.level,
                equipped = player.abilities.iceDomain.equipped,
                amount = player.abilities.iceDomain.amount
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
            },
            berserkerKit = {
                unlocked = player.abilities.berserkerKit.unlocked,
                level = player.abilities.berserkerKit.level,
                equipped = player.abilities.berserkerKit.equipped,
                amount = player.abilities.berserkerKit.amount
            },
            sniperKit = {
                unlocked = player.abilities.sniperKit.unlocked,
                level = player.abilities.sniperKit.level,
                equipped = player.abilities.sniperKit.equipped,
                amount = player.abilities.sniperKit.amount
            },
            tankKit = {
                unlocked = player.abilities.tankKit.unlocked,
                level = player.abilities.tankKit.level,
                equipped = player.abilities.tankKit.equipped,
                amount = player.abilities.tankKit.amount
            },
            supercritical = {
                unlocked = player.abilities.supercritical.unlocked,
                level = player.abilities.supercritical.level,
                equipped = player.abilities.supercritical.equipped,
                amount = player.abilities.supercritical.amount
            },
            disruptWave = {
                unlocked = player.abilities.disruptWave.unlocked,
                level = player.abilities.disruptWave.level,
                equipped = player.abilities.disruptWave.equipped,
                amount = player.abilities.disruptWave.amount
            }
        },

        misc = {
            abilityAssembling = player.misc.abilityAssembling,
            theme = player.misc.theme
        },
        settings = {
            particleMultiplierIndex = player.settings.particleMultiplierIndex,
            waveSkipMessages = player.settings.waveSkipMessages,
            notation = player.settings.notation,
            tooltips = player.settings.tooltips,
            volume = player.settings.volume
        }
    }

    serialized = lume.serialize(toSave)
    love.filesystem.write("SAVEFILE.sav", serialized)
end