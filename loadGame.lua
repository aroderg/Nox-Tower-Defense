function technical.deepMerge(toAlter, template)
    for i,v in pairs(template) do
        if type(template[i]) == "table" and i ~= "menu" then
            toAlter[i] = {}
            technical.deepMerge(toAlter[i], template[i])
        else
            toAlter[i] = template[i]
        end
    end
end

function technical.safeGet(value, placeholder)
    if not value then
        value = placeholder
    end
    return value
end

function loadGame()
    -- Initialize default player state
    player = {
        paused = false,
        location = "round",
        cooldowns = {electrum = 24, tokens = 600, abilityAssembly_min = 400, abilityAssembly_max = 800, abilityAssembly_current = 600},
        timers = {electrum = 0, tokens = 600, abilityAssembly = 0},
        canClaim = {tokens = true, electrum = true, ability = true},
        currencies = {currentSilver = 0, currentGold = 0, currentElectrum = 0, currentTokens = 0},

        --[[ Set upgrade unlocks ]]--
        upgrades = {
            unlocks = {
                crit = false,
                range = false,

                resistance = false,
                shield = false,
                meteor = false,

                resourceBonus = false
            },
            science = {
                attackDamage = {level = 1, cost = 1, value = 1},
                attackSpeed = {level = 1, cost = 1, value = 1},
                critChance = {level = 1, cost = 1, value = 1},
                critFactor = {level = 1, cost = 1, value = 1},
                range = {level = 1, cost = 1, value = 1},

                health = {level = 1, cost = 1, value = 1},
                regeneration = {level = 1, cost = 1, value = 1},
                resistance = {level = 1, cost = 1, value = 1},
                shieldCooldown = {level = 1, cost = 1, value = 1},
                shieldDuration = {level = 1, cost = 1, value = 1},
                meteorAmount = {level = 1, cost = 1, value = 1},
                meteorRPM = {level = 1, cost = 1, value = 1},
                
                copperPerWave = {level = 1, cost = 1, value = 1},
                silverPerWave = {level = 1, cost = 1, value = 1},
                copperBonus = {level = 1, cost = 1, value = 1},
                silverBonus = {level = 1, cost = 1, value = 1},
            },

            nexus = {
                attackDamage = {level = 1, cost = 1, value = 1},
                attackSpeed = {level = 1, cost = 1, value = 1},
                health = {level = 1, cost = 1, value = 1},
                regeneration = {level = 1, cost = 1, value = 1},
            }
        },
        modifiers = {
            waveSkip = {unlocked = false, level = 1, cost = 15, value = 0},
            hyperloop = {unlocked = false, level = 1, cost = 10, value = 0}
        },
        settings = {particleMultiplier = 4, waveSkipMessages = true, notation = "kmbt", tooltips = true, volume = 1},
        bestWaves = {d1 = 0, d2 = 0, d3 = 0, d4 = 0},
        stats = {
            save = {
                enemiesKilled = 0,
                damageDealt = 0,
                silverEarned = 0,
                wavesSkipped = 0,
                projectilesFired = 0,
                upgradesAcquired = {science = 0, nexus = 0},
                wavesBeaten = 0,
                spikedCrystals = {enemiesKilled = 0, damageDealt = 0, spawned = 0},
                scatterFire = {damageDealt = 0, triggered = 0},
                burstFire = {damageDealt = 0, triggered = 0},
                rainforest = {triggered = 0},
                magmaTouch = {enemiesKilled = 0, damageDealt = 0, spawned = 0},
                lightningOrb = {enemiesKilled = 0, damageDealt = 0, spawned = 0},
                JerelosBlessing = {triggered = 0, healthRegenerated = 0}
            },
        },
        abilities = {
            equipped = 0,
            maxEquipped = 1,
            spikedCrystals = {unlocked = false, level = 0, equipped = false, amount = 0},
            scatterFire = {unlocked = false, level = 0, equipped = false, amount = 0},
            burstFire = {unlocked = false, level = 0,equipped = false, amount = 0},
            rainforest = {unlocked = false, level = 0, equipped = false, amount = 0},
            magmaTouch = {unlocked = false, level = 0, equipped = false, amount = 0},
            lightningOrb = {unlocked = false, level = 0, equipped = false, amount = 0},
            JerelosBlessing = {unlocked = false, level = 0, equipped = false, amount = 0},
            berserkerKit = {unlocked = false, level = 0, equipped = false, amount = 0}
        },
        misc = {abilityAssembling = false, tokensRefundable = true}
    }

    -- Check if SAVEFILE.sav is present in the game dir
    if love.filesystem.getInfo("SAVEFILE.sav") and love.filesystem.read("SAVEFILE.sav") ~= "nil" then
        fileContent = love.filesystem.read("SAVEFILE.sav")
        loadedData = lume.deserialize(fileContent)

        player.location = "hub"
        player.cooldowns = {
            electrum = 24,
            tokens = 600,
            abilityAssembly_min = 400,
            abilityAssembly_max = 800,
            abilityAssembly_current = loadedData.cooldowns.abilityAssembly or player.cooldowns.abilityAssembly_current
        }
        player.timers = {
            electrum = loadedData.timers.electrum or player.timers.electrum,
            tokens = loadedData.timers.tokens or player.timers.tokens,
            abilityAssembly = loadedData.timers.abilityAssembly or player.timers.abilityAssembly
        }
        player.canClaim = {
            tokens = (player.timers.tokens <= 0),
            electrum = (player.timers.electrum <= 0),
            ability = (player.timers.abilityAssembly >= player.cooldowns.abilityAssembly_current)
        }
        player.currencies = {
            currentSilver = loadedData.currentSilver or player.currencies.currentSilver,
            currentGold = loadedData.currentGold or player.currencies.currentGold,
            currentElectrum = loadedData.currentElectrum or player.currencies.currentElectrum,
            currentTokens = loadedData.currentTokens or player.currencies.currentTokens,
        }
    --[[ Set upgrade unlocks ]]--
        player.upgrades = {
            unlocks = {
                crit = loadedData.upgrades.unlocks.crit or player.upgrades.unlocks.crit,
                range = loadedData.upgrades.unlocks.range or player.upgrades.unlocks.range,

                resistance = loadedData.upgrades.unlocks.resistance or player.upgrades.unlocks.resistance,
                shield = loadedData.upgrades.unlocks.shield or player.upgrades.unlocks.shield,
                meteor = loadedData.upgrades.unlocks.meteor or player.upgrades.unlocks.meteor,

                resourceBonus = loadedData.upgrades.unlocks.resourceBonus or player.upgrades.unlocks.resourceBonus
            },
            science = {
                attackDamage = {level = loadedData.upgrades.attackDamage or player.upgrades.science.attackDamage.level, cost = 1, value = 1},
                attackSpeed = {level = loadedData.upgrades.attackSpeed or player.upgrades.science.attackSpeed.level, cost = 1, value = 1},
                critChance = {level = loadedData.upgrades.critChance or player.upgrades.science.critChance.level, cost = 1, value = 1},
                critFactor = {level = loadedData.upgrades.critFactor or player.upgrades.science.critFactor.level, cost = 1, value = 1},
                range = {level = loadedData.upgrades.range or player.upgrades.science.range.level, cost = 1, value = 1},

                health = {level = loadedData.upgrades.health or player.upgrades.science.health.level, cost = 1, value = 1},
                regeneration = {level = loadedData.upgrades.regeneration or player.upgrades.science.regeneration.level, cost = 1, value = 1},
                resistance = {level = loadedData.upgrades.resistance or player.upgrades.science.resistance.level, cost = 1, value = 1},
                shieldCooldown = {level = loadedData.upgrades.shieldCooldown or player.upgrades.science.shieldCooldown.level, cost = 1, value = 1},
                shieldDuration = {level = loadedData.upgrades.shieldDuration or player.upgrades.science.shieldDuration.level, cost = 1, value = 1},
                meteorAmount = {level = loadedData.upgrades.meteorAmount or player.upgrades.science.meteorAmount.levelt, cost = 1, value = 1},
                meteorRPM = {level = loadedData.upgrades.meteorRPM or player.upgrades.science.meteorRPM.level, cost = 1, value = 1},

                copperPerWave = {level = loadedData.upgrades.copperPerWave or player.upgrades.science.copperPerWave.level, cost = 1, value = 1},
                silverPerWave = {level = loadedData.upgrades.silverPerWave or player.upgrades.science.silverPerWave.level, cost = 1, value = 1},
                copperBonus = {level = loadedData.upgrades.copperBonus or player.upgrades.science.copperBonus.level, cost = 1, value = 1},
                silverBonus = {level = loadedData.upgrades.silverBonus or player.upgrades.science.silverBonus.level, cost = 1, value = 1},
            },

            nexus = {
                attackDamage = {level = loadedData.upgrades.nexus.attackDamage, cost = 1},
                attackSpeed = {level = loadedData.upgrades.nexus.attackSpeed, cost = 1},
                health = {level = loadedData.upgrades.nexus.health, cost = 1},
                regeneration = {level = loadedData.upgrades.nexus.regeneration, cost = 1},
            }
        }
        player.upgrades.nexus.attackDamage.value = math.min(1 + (player.upgrades.nexus.attackDamage.level - 1) * 10/100, 5)
        player.upgrades.nexus.attackSpeed.value = math.min(1 + (player.upgrades.nexus.attackSpeed.level - 1) * 4/100, 2)
        player.upgrades.nexus.health.value = math.min(1 + (player.upgrades.nexus.health.level - 1) * 10/100, 5)
        player.upgrades.nexus.regeneration.value = math.min(1 + (player.upgrades.nexus.regeneration.level - 1) * 10/100, 5)
        player.modifiers = {
            waveSkip = {
                unlocked = loadedData.modifiers.waveSkip.unlocked,
                level = loadedData.modifiers.waveSkip.level
            },
            hyperloop = {
                unlocked = loadedData.modifiers.hyperloop.unlocked,
                level = loadedData.modifiers.hyperloop.level
            }
        }
        player.modifiers.waveSkip.cost = player.modifiers.waveSkip.unlocked and (player.modifiers.waveSkip.level * (player.modifiers.waveSkip.level - 1)) / 2 + 4 or 10
        player.modifiers.waveSkip.value = player.modifiers.waveSkip.unlocked and math.min(4 * player.modifiers.waveSkip.level, 40) or 0
        player.modifiers.hyperloop.cost = player.modifiers.hyperloop.unlocked and player.modifiers.hyperloop.level^2 - 2 * player.modifiers.hyperloop.level + 11 or 15
        player.modifiers.hyperloop.value = player.modifiers.hyperloop.unlocked and math.min(2 + 8 * player.modifiers.hyperloop.level, 90) or 0
        player.settings = {
            particleMultiplier = loadedData.settings.particleMultiplierIndex or player.settings.particleMultiplierIndex,
            waveSkipMessages = loadedData.settings.waveSkipMessages or player.settings.waveSkipMessages,
            notation = loadedData.settings.notation or player.settings.notation,
            tooltips = loadedData.settings.tooltips or player.settings.tooltips,
            volume = loadedData.settings.volume or player.settings.volume
        }
        player.bestWaves = {d1 = loadedData.pb.d1 or player.bestWaves.d1, d2 = loadedData.pb.d2 or player.bestWaves.d2, d3 = loadedData.pb.d3 or player.bestWaves.d3, d4 = loadedData.pb.d4 or player.bestWaves.d4}
        player.stats = {
            save = {
                enemiesKilled = loadedData.stats.enemiesKilled or player.stats.save.enemiesKilled,
                damageDealt = loadedData.stats.damageDealt or player.stats.save.damageDealt,
                silverEarned = loadedData.stats.silverEarned or player.stats.save.silverEarned,
                wavesSkipped = loadedData.stats.wavesSkipped or player.stats.save.wavesSkipped,
                projectilesFired = loadedData.stats.projectilesFired or player.stats.save.projectilesFired,
                upgradesAcquired = {
                    science = loadedData.stats.upgradesAcquired.science or player.stats.save.upgradesAcquired.science,
                    nexus = loadedData.stats.upgradesAcquired.nexus or player.stats.save.upgradesAcquired.nexus
                },
                wavesBeaten = loadedData.stats.wavesBeaten or player.stats.save.enemiesKilled,
                spikedCrystals = {
                    enemiesKilled = loadedData.stats.spikedCrystals.enemiesKilled or player.stats.save.spikedCrystals.enemiesKilled,
                    damageDealt = loadedData.stats.spikedCrystals.damageDealt or player.stats.save.spikedCrystals.damageDealt,
                    spawned = loadedData.stats.spikedCrystals.spawned or player.stats.save.spikedCrystals.spawned
                },
                scatterFire = {
                    damageDealt = loadedData.stats.scatterFire.damageDealt or player.stats.save.scatterFire.damageDealt,
                    triggered = loadedData.stats.scatterFire.triggered or player.stats.save.scatterFire.triggered
                },
                burstFire = {
                    damageDealt = loadedData.stats.burstFire.damageDealt or player.stats.save.burstFire.damageDealt,
                    triggered = loadedData.stats.burstFire.triggered or player.stats.save.burstFire.triggered
                },
                rainforest = {
                    triggered = loadedData.stats.rainforest.triggered or player.stats.save.rainforest.triggered
                },
                magmaTouch = {
                    enemiesKilled = loadedData.stats.magmaTouch.enemiesKilled or player.stats.save.magmaTouch.triggered,
                    damageDealt = loadedData.stats.magmaTouch.damageDealt or player.stats.save.magmaTouch.triggered,
                    spawned = loadedData.stats.magmaTouch.spawned or player.stats.save.magmaTouch.spawned
                },
                lightningOrb = {
                    enemiesKilled = loadedData.stats.lightningOrb.enemiesKilled or player.stats.save.lightningOrb.enemiesKilled,
                    damageDealt = loadedData.stats.lightningOrb.damageDealt or player.stats.save.lightningOrb.damageDealt,
                    spawned = loadedData.stats.lightningOrb.spawned or player.stats.save.lightningOrb.spawned
                },
                JerelosBlessing = {
                    triggered = loadedData.stats.JerelosBlessing.triggered or player.stats.save.JerelosBlessing.triggered,
                    healthRegenerated = loadedData.stats.JerelosBlessing.healthRegenerated or player.stats.save.JerelosBlessing.healthRegenerated
                }
            }
        }
        player.abilities = {
            equipped = 0,
            maxEquipped = 1
        }
        local abilityNames = {"spikedCrystals", "scatterFire", "burstFire", "rainforest", "magmaTouch", "lightningOrb", "JerelosBlessing", "berserkerKit"}
        for i,v in ipairs(abilityNames) do
            if not loadedData.abilities[abilityNames[i]] then
                loadedData.abilities[abilityNames[i]] = {
                    unlocked = false,
                    level = 0,
                    equipped = false,
                    amount = 0
                }
            end
        end
        for i,v in ipairs(abilityNames) do
            if not player.abilities[abilityNames[i]] then
                player.abilities[abilityNames[i]] = {}
            end
            player.abilities[abilityNames[i]] = {
                unlocked = loadedData.abilities[abilityNames[i]].unlocked,
                level = loadedData.abilities[abilityNames[i]].level,
                equipped = loadedData.abilities[abilityNames[i]].equipped,
                amount = loadedData.abilities[abilityNames[i]].amount
            }
        end
        misc = {abilityAssembling = (loadedData.timers.abilityAssembly <= loadedData.cooldowns.abilityAssembly)}
    end

    --[[ Set Science upgrade costs (in Silver) ]]--
    player.upgrades.science.attackDamage.cost = reloadFormulae(player.upgrades.science.attackDamage.level)["science"]["ATK"][1][1]
    player.upgrades.science.attackSpeed.cost = reloadFormulae(player.upgrades.science.attackSpeed.level)["science"]["ATK"][2][1]
    player.upgrades.science.critChance.cost = reloadFormulae(player.upgrades.science.critChance.level)["science"]["ATK"][3][1]
    player.upgrades.science.critFactor.cost = reloadFormulae(player.upgrades.science.critFactor.level)["science"]["ATK"][4][1]
    player.upgrades.science.range.cost = reloadFormulae(player.upgrades.science.range.level)["science"]["ATK"][5][1]

    player.upgrades.science.health.cost = reloadFormulae(player.upgrades.science.health.level)["science"]["VIT"][1][1]
    player.upgrades.science.regeneration.cost = reloadFormulae(player.upgrades.science.regeneration.level)["science"]["VIT"][2][1]
    player.upgrades.science.resistance.cost = reloadFormulae(player.upgrades.science.resistance.level)["science"]["VIT"][3][1]
    player.upgrades.science.shieldCooldown.cost = reloadFormulae(player.upgrades.science.shieldCooldown.level)["science"]["VIT"][4][1]
    player.upgrades.science.shieldDuration.cost = reloadFormulae(player.upgrades.science.shieldDuration.level)["science"]["VIT"][5][1]
    player.upgrades.science.meteorAmount.cost = reloadFormulae(player.upgrades.science.meteorAmount.level)["science"]["VIT"][6][1]
    player.upgrades.science.meteorRPM.cost = reloadFormulae(player.upgrades.science.meteorRPM.level)["science"]["VIT"][7][1]

    player.upgrades.science.copperPerWave.cost = reloadFormulae(player.upgrades.science.copperPerWave.level)["science"]["UTL"][1][1]
    player.upgrades.science.silverPerWave.cost = reloadFormulae(player.upgrades.science.silverPerWave.level)["science"]["UTL"][2][1]
    player.upgrades.science.copperBonus.cost = reloadFormulae(player.upgrades.science.copperBonus.level)["science"]["UTL"][3][1]
    player.upgrades.science.silverBonus.cost = reloadFormulae(player.upgrades.science.silverBonus.level)["science"]["UTL"][4][1]

    --[[ Set Nexus upgrade costs (in Tokens) ]]--
    player.upgrades.nexus.attackDamage.cost = 20 + ((player.upgrades.nexus.attackDamage.level * (player.upgrades.nexus.attackDamage.level - 1)) / 2) * 5
    player.upgrades.nexus.attackSpeed.cost = 20 + ((player.upgrades.nexus.attackSpeed.level * (player.upgrades.nexus.attackSpeed.level - 1)) / 2) * 5
    player.upgrades.nexus.health.cost = 20 + ((player.upgrades.nexus.health.level * (player.upgrades.nexus.health.level - 1)) / 2) * 5
    player.upgrades.nexus.regeneration.cost = 20 + ((player.upgrades.nexus.regeneration.level * (player.upgrades.nexus.regeneration.level - 1)) / 2) * 5

    player.difficulty = {
        difficulty = 1,
        unlocks = {d1 = true, d2 = player.bestWaves.d1 > 99 and true or false, d3 = player.bestWaves.d2 > 99 and true or false, d4 = player.bestWaves.d3 > 99 and true or false}
    }

    player.menu = {
        abilities = {spikedCrystals = false, scatterFire = false, burstFire = false, rainforest = false, magmaTouch = false, lightningOrb = false, JerelosBlessing = false, berserkerKit = false},
        saveStats = false,
        rolledAbilityDisplay = false
    }

    abilityFunctions.updateInternals()
    abilityFunctions.updateSlotCount()

    if player.abilities.equipped > player.abilities.maxEquipped then
        for i,v in pairs(internalAbilities) do
            if v.equipped then
                player.abilities[v.internalName].equipped = false
            end
        end
    end

    player.maxGameSpeed = 1

    if not player.canClaim.ability and player.misc.abilityAssembling then
        if player.timers.abilityAssembly < player.cooldowns.abilityAssembly_current then
            player.timers.abilityAssembly = player.timers.abilityAssembly + dt * gameplay.gameSpeed
        else
            player.timers.abilityAssembly = player.cooldowns.abilityAssembly_current
            player.canClaim.ability = true
            player.misc.abilityAssembling = false
        end
    end
    if not player.canClaim.ability and not player.misc.abilityAssembling then
        player.timers.abilityAssembly = 0
    end
    
    --saveGame()
end

function resetRoundValues()
    --[[ Reset all properties to initial at the start of the round ]]--
    player.menu.paused = false
    player.menu.settings = false
    player.menu.upgrades = false
    player.menu.gameplayInfo = false
    player.menu.battleStats = false
    player.menu.saveStats = false

    --[[ Copper ]]--
    player.currencies.currentCopper = 0

    --[[ Set Round upgrade levels to initial Science upgrade levels ]]--
    player.upgrades.round = {
        attackDamage = {level = player.upgrades.science.attackDamage.level, cost = 2, value = 1},
        attackSpeed = {level = player.upgrades.science.attackSpeed.level, cost = 5, value = 1},
        critChance = {level = player.upgrades.science.critChance.level, cost = 6, value = 1},
        critFactor = {level = player.upgrades.science.critFactor.level, cost = 2, value = 1},
        range = {level = player.upgrades.science.range.level, cost = 2, value = 1},
        health = {level = player.upgrades.science.health.level, cost = 3, value = 1},
        regeneration = {level = player.upgrades.science.regeneration.level, cost = 5, value = 1},
        resistance = {level = player.upgrades.science.resistance.level, cost = 4, value = 1},
        shieldCooldown = {level = player.upgrades.science.shieldCooldown.level, cost = 4, value = 1},
        shieldDuration = {level = player.upgrades.science.shieldDuration.level, cost = 3, value = 1},
        meteorAmount = {level = player.upgrades.science.meteorAmount.level, cost = 200, value = 1},
        meteorRPM = {level = player.upgrades.science.meteorRPM.level, cost = 20, value = 1},
        copperPerWave = {level = player.upgrades.science.copperPerWave.level, cost = 10, value = 1},
        silverPerWave = {level = player.upgrades.science.silverPerWave.level, cost = 10, value = 1},
        copperBonus = {level = player.upgrades.science.copperBonus.level, cost = 4, value = 1},
        silverBonus = {level = player.upgrades.science.silverBonus.level, cost = 7, value = 1},
    }

    --[[ Tower properties ]]--
    player.tower = {
        attackDamage = reloadFormulae(player.upgrades.round.attackDamage.level)["science"]["ATK"][1][2],
        attackSpeed = reloadFormulae(player.upgrades.round.attackSpeed.level)["science"]["ATK"][2][2],
        critChance = reloadFormulae(player.upgrades.round.critChance.level)["science"]["ATK"][3][2],
        critFactor = reloadFormulae(player.upgrades.round.critFactor.level)["science"]["ATK"][4][2],
        range = reloadFormulae(player.upgrades.round.range.level)["science"]["ATK"][5][2],
        health = reloadFormulae(player.upgrades.round.health.level)["science"]["VIT"][1][2],
        currentHealth = reloadFormulae(player.upgrades.round.health.level)["science"]["VIT"][1][2],
        regeneration = reloadFormulae(player.upgrades.round.regeneration.level)["science"]["VIT"][2][2],
        resistance = reloadFormulae(player.upgrades.round.resistance.level)["science"]["VIT"][3][2],
        shieldCooldown = reloadFormulae(player.upgrades.round.shieldCooldown.level)["science"]["VIT"][4][2],
        shieldDuration = reloadFormulae(player.upgrades.round.shieldDuration.level)["science"]["VIT"][5][2],
        meteorAmount = reloadFormulae(player.upgrades.round.meteorAmount.level)["science"]["VIT"][6][2],
        meteorRPM = reloadFormulae(player.upgrades.round.meteorRPM.level)["science"]["VIT"][7][2],
        
        copperPerWave = reloadFormulae(player.upgrades.round.copperPerWave.level)["science"]["UTL"][1][2],
        silverPerWave = reloadFormulae(player.upgrades.round.silverPerWave.level)["science"]["UTL"][2][2],
        copperBonus = reloadFormulae(player.upgrades.round.copperBonus.level)["science"]["UTL"][3][2],
        silverBonus = reloadFormulae(player.upgrades.round.silverBonus.level)["science"]["UTL"][4][2],
    }

    --[[ Gameplay properties ]]--
    gameplay = {difficulty = player.difficulty.difficulty, wave = 1, gameSpeed = player.maxGameSpeed}
    misc = {
        copperBuffer = 0,
        silverBuffer = 0,
        copperAtStart = player.currencies.currentCopper,
        silverAtStart = player.currencies.currentSilver,
        goldAtStart = player.currencies.currentGold,
        JerelosBlessingVisuals = {vines = love.math.random(1, 4), waves = love.math.random(1, 4)}
    }
    player.stats.battle = {
        gameTime = 0,
        realTime = 0,
        enemiesKilled = 0,
        damageTaken = 0,
        damageDealt = 0,
        copperEarned = 0,
        silverEarned = 0,
        shieldDamageAbsorb = 0,
        wavesSkipped = 0,
        projectilesFired = 0,
        upgradesAcquired = 0,
        goldEarned = 0,
        spikedCrystals = {enemiesKilled = 0, damageDealt = 0, spawned = 0},
        scatterFire = {damageDealt = 0, triggered = 0},
        burstFire = {damageDealt = 0, triggered = 0},
        rainforest = {triggered = 0},
        magmaTouch = {enemiesKilled = 0, damageDealt = 0, spawned = 0},
        lightningOrb = {enemiesKilled = 0, damageDealt = 0, spawned = 0},
        JerelosBlessing = {triggered = 0, healthRegenerated = 0}
    }
    player.stats.wave = {enemiesKilled = 0}
    enemyAttributes = {}
    --[[ Enemy properties ]]--

    updateEnemyStats(gameplay.difficulty, gameplay.wave)

    --[[ Timers ]]--
    timers = {projectile = 0, enemy = 0, nextWave = 0, shieldActivation = 0, shieldActive = 0, waveSkip = 3, crystal = 0, magmaPool = 0, lightningOrb = 0}

    --[[ Misc ]]--
    waveSkipMessage = false
    projectilesOnField = {}
    enemiesOnField = {}
    killParticles = {}
    collapseParticles = {}
    hitTextParticles = {}
    meteorParticles = {}
    crystalExplosionParticles = {}
    burnParticles = {}
    meteors = {}
    for i=1,player.tower.meteorAmount do
        createMeteor(((i-1) * (2 * math.pi) / player.tower.meteorAmount) - 0.5 * math.pi)
    end
    spikedCrystals = {}
    magmaPools = {}
    lightningOrbs = {}
    lightningOrb_lasers = {}
    sentryAlive = false
    centurionAlive = false
end