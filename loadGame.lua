function technical.deepMerge(toAlter, template)
    if type(toAlter) ~= "table" or type(template) ~= "table" then
        return template
    end
    for key, value in pairs(template) do
        local toAlterValue = toAlter[key]
        if type(value) == "table" and type(toAlterValue) == "table" then
            technical.deepMerge(toAlterValue, value)
        elseif type(value) == "table" then
            toAlter[key] = {}
            technical.deepMerge(toAlter[key], value)
        else
            toAlter[key] = value
        end
    end

    return toAlter
end

socket = require "socket"

function loadGame()
    -- Initialize default player state
    defaultPlayerState = {
        paused = false,
        location = "round",
        cooldowns = {electrum = 24, tokens = 600, abilityAssembly_min = 400, abilityAssembly_max = 800, abilityAssembly_current = 600},
        timers = {electrum = 0, tokens = 600, abilityAssembly = 0},
        canClaim = {tokens = true, electrum = true, ability = true},
        currencies = {currentSilver = 0, currentGold = 0, currentElectrum = 0, currentTokens = 0},
        idleGains = {silver = 0, gold = 0}, -- Idle Gains per minute.
        idleTimeCap = 21600,
        idleTime = 0, -- Idle Time in seconds.
        timeModified = socket.gettime(),
        storedGains = {silver = 0, gold = 0}, -- Total claimable resources as a result of Idle Gains.

        --[[ Set upgrade unlocks ]]--
        upgrades = {
            unlocks = {
                crit = false,
                range = false,
                clusterFire = false,

                resistance = false,
                shield = false,
                meteor = false,
                lifesteal = false,

                resourceBonus = false
            },
            science = {
                attackDamage = {level = 1, cost = 1, value = 1},
                attackSpeed = {level = 1, cost = 1, value = 1},
                critChance = {level = 1, cost = 1, value = 1},
                critFactor = {level = 1, cost = 1, value = 1},
                range = {level = 1, cost = 1, value = 1},
                clusterFireChance = {level = 1, cost = 1, value = 1},
                clusterFireTargets = {level = 1, cost = 1, value = 1},
                clusterFireEfficiency = {level = 1, cost = 1, value = 1},

                health = {level = 1, cost = 1, value = 1},
                regeneration = {level = 1, cost = 1, value = 1},
                resistance = {level = 1, cost = 1, value = 1},
                shieldCooldown = {level = 1, cost = 1, value = 1},
                shieldDuration = {level = 1, cost = 1, value = 1},
                meteorAmount = {level = 1, cost = 1, value = 1},
                meteorRPM = {level = 1, cost = 1, value = 1},
                lifestealChance = {level = 1, cost = 1, value = 1},
                lifestealPercent = {level = 1, cost = 1, value = 1},
                
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
                abilityChance = {level = 1, cost = 1, value = 1},
                abilityCooldown = {level = 1, cost = 1, value = 1},
            }
        },
        modifiers = {
            waveSkip = {unlocked = false, level = 1, cost = 10, value = 0},
            hyperloop = {unlocked = false, level = 1, cost = 15, value = 0},
            acceleration = {unlocked = false, level = 1, cost = 15, value = 0}
        },
        settings = {particleMultiplierIndex = 4, waveSkipMessages = true, notation = "kmbt", tooltips = true, volume = 1},
        bestWaves = {d1 = 0, d2 = 0, d3 = 0, d4 = 0, d5 = 0},
        stats = {
            save = {
                enemiesKilled = 0,
                damageDealt = 0,
                silverEarned = 0,
                goldEarned = 0,
                wavesSkipped = 0,
                projectilesFired = 0,
                upgradesAcquired = {science = 0, nexus = 0},
                wavesBeaten = 0,
                clusterFire = {triggered = 0},
                lifesteal = {triggered = 0, healed = 0},
                spikedCrystals = {enemiesKilled = 0, damageDealt = 0, spawned = 0},
                scatterFire = {damageDealt = 0, triggered = 0},
                burstFire = {damageDealt = 0, triggered = 0},
                iceDomain = {triggered = 0},
                magmaTouch = {enemiesKilled = 0, damageDealt = 0, spawned = 0},
                lightningOrb = {enemiesKilled = 0, damageDealt = 0, spawned = 0},
                JerelosBlessing = {triggered = 0, healthRegenerated = 0},
                supercritical = {triggered = 0, damageDealt = 0},
                disruptWave = {triggered = 0, damageDealt = 0, enemiesKilled = 0}
            },
        },
        abilities = {
            equipped = 0,
            maxEquipped = 1,
            spikedCrystals = {unlocked = false, level = 0, equipped = false, amount = 0},
            scatterFire = {unlocked = false, level = 0, equipped = false, amount = 0},
            burstFire = {unlocked = false, level = 0,equipped = false, amount = 0},
            iceDomain = {unlocked = false, level = 0, equipped = false, amount = 0},
            magmaTouch = {unlocked = false, level = 0, equipped = false, amount = 0},
            lightningOrb = {unlocked = false, level = 0, equipped = false, amount = 0},
            JerelosBlessing = {unlocked = false, level = 0, equipped = false, amount = 0},
            berserkerKit = {unlocked = false, level = 0, equipped = false, amount = 0},
            sniperKit = {unlocked = false, level = 0, equipped = false, amount = 0},
            tankKit = {unlocked = false, level = 0, equipped = false, amount = 0},
            supercritical = {unlocked = false, level = 0, equipped = false, amount = 0},
            disruptWave = {unlocked = false, level = 0, equipped = false, amount = 0}
        },
        misc = {abilityAssembling = false, tokensRefundable = true, theme = "aurora", currentOrbital = love.math.random(1, 39)}
    }

    local loadedData = nil
    -- Check if SAVEFILE.sav is present in the game dir
    if love.filesystem.getInfo("SAVEFILE.sav") and love.filesystem.read("SAVEFILE.sav") ~= "nil" then
        local fileContent = love.filesystem.read("SAVEFILE.sav")
        loadedData = lume.deserialize(fileContent)
    end
    if loadedData == nil then
        loadedData = defaultPlayerState
    end
    player = technical.deepMerge({}, defaultPlayerState)
    
    --player = {}
    player.location = "hub"
    player.cooldowns = {
        electrum = 24,
        tokens = 600,
        abilityAssembly_min = 400,
        abilityAssembly_max = 800,
        abilityAssembly_current = loadedData.cooldowns.abilityAssembly_current or defaultPlayerState.cooldowns.abilityAssembly_current
    }
    player.timers = {
        electrum = loadedData.timers.electrum or defaultPlayerState.timers.electrum,
        tokens = loadedData.timers.tokens or defaultPlayerState.timers.tokens,
        abilityAssembly = loadedData.timers.abilityAssembly or defaultPlayerState.timers.abilityAssembly
    }
    player.canClaim = {
        tokens = (player.timers.tokens <= 0),
        electrum = (player.timers.electrum <= 0),
        ability = (player.timers.abilityAssembly >= player.cooldowns.abilityAssembly_current)
    }
    player.currencies = {
        currentSilver = loadedData.currentSilver or defaultPlayerState.currencies.currentSilver,
        currentGold = loadedData.currentGold or defaultPlayerState.currencies.currentGold,
        currentElectrum = loadedData.currentElectrum or defaultPlayerState.currencies.currentElectrum,
        currentTokens = loadedData.currentTokens or defaultPlayerState.currencies.currentTokens,
    }

    player.idleTimeCap = player.idleTimeCap or 21600
    player.idleGains = {silver = loadedData.idleGains.silver or defaultPlayerState.idleGains.silver, gold = loadedData.idleGains.gold or defaultPlayerState.idleGains.gold}
    player.timeModified = loadedData.timeModified or defaultPlayerState.timeModified
    local oldIdleTime = loadedData.idleTime
    player.idleTime = math.min(loadedData.idleTime + socket.gettime() - player.timeModified, player.idleTimeCap)
    player.storedGains = {silver = loadedData.storedGains.silver or defaultPlayerState.storedGains.silver, gold = loadedData.storedGains.gold or defaultPlayerState.storedGains.gold}
    player.storedGains.silver = player.storedGains.silver + player.idleGains.silver * (math.floor(player.idleTime / 60) - math.floor(oldIdleTime / 60))
    player.storedGains.gold = player.storedGains.gold + player.idleGains.gold * (math.floor(player.idleTime / 60) - math.floor(oldIdleTime / 60))

--[[ Set upgrade unlocks ]]--
    player.upgrades = {
        unlocks = {
            crit = loadedData.upgrades.unlocks.crit or defaultPlayerState.upgrades.unlocks.crit,
            range = loadedData.upgrades.unlocks.range or defaultPlayerState.upgrades.unlocks.range,
            clusterFire = loadedData.upgrades.unlocks.clusterFire or defaultPlayerState.upgrades.unlocks.clusterFire,

            resistance = loadedData.upgrades.unlocks.resistance or defaultPlayerState.upgrades.unlocks.resistance,
            shield = loadedData.upgrades.unlocks.shield or defaultPlayerState.upgrades.unlocks.shield,
            meteor = loadedData.upgrades.unlocks.meteor or defaultPlayerState.upgrades.unlocks.meteor,
            lifesteal = loadedData.upgrades.unlocks.lifesteal or defaultPlayerState.upgrades.unlocks.lifesteal,

            resourceBonus = loadedData.upgrades.unlocks.resourceBonus or defaultPlayerState.upgrades.unlocks.resourceBonus
        },
        science = {
            attackDamage = {level = loadedData.upgrades.attackDamage or defaultPlayerState.upgrades.science.attackDamage.level, cost = 1, value = 1},
            attackSpeed = {level = loadedData.upgrades.attackSpeed or defaultPlayerState.upgrades.science.attackSpeed.level, cost = 1, value = 1},
            critChance = {level = loadedData.upgrades.critChance or defaultPlayerState.upgrades.science.critChance.level, cost = 1, value = 1},
            critFactor = {level = loadedData.upgrades.critFactor or defaultPlayerState.upgrades.science.critFactor.level, cost = 1, value = 1},
            range = {level = loadedData.upgrades.range or defaultPlayerState.upgrades.science.range.level, cost = 1, value = 1},
            clusterFireChance = {level = loadedData.upgrades.clusterFireChance or defaultPlayerState.upgrades.science.clusterFireChance.level, cost = 1, value = 1},
            clusterFireTargets = {level = loadedData.upgrades.clusterFireTargets or defaultPlayerState.upgrades.science.clusterFireTargets.level, cost = 1, value = 1},
            clusterFireEfficiency = {level = loadedData.upgrades.clusterFireEfficiency or defaultPlayerState.upgrades.science.clusterFireEfficiency.level, cost = 1, value = 1},

            health = {level = loadedData.upgrades.science.health.level or defaultPlayerState.upgrades.science.health.level, cost = 1, value = 1},
            regeneration = {level = loadedData.upgrades.science.regeneration.level or defaultPlayerState.upgrades.science.regeneration.level, cost = 1, value = 1},
            resistance = {level = loadedData.upgrades.science.resistance.level or defaultPlayerState.upgrades.science.resistance.level, cost = 1, value = 1},
            shieldCooldown = {level = loadedData.upgrades.science.shieldCooldown.level or defaultPlayerState.upgrades.science.shieldCooldown.level, cost = 1, value = 1},
            shieldDuration = {level = loadedData.upgrades.science.shieldDuration.level or defaultPlayerState.upgrades.science.shieldDuration.level, cost = 1, value = 1},
            meteorAmount = {level = loadedData.upgrades.science.meteorAmount.level or defaultPlayerState.upgrades.science.meteorAmount.levelt, cost = 1, value = 1},
            meteorRPM = {level = loadedData.upgrades.science.meteorRPM.level or defaultPlayerState.upgrades.science.meteorRPM.level, cost = 1, value = 1},
            lifestealChance = {level = loadedData.upgrades.science.lifestealChance.level or defaultPlayerState.upgrades.science.lifestealChance.level, cost = 1, value = 1},
            lifestealPercent = {level = loadedData.upgrades.science.lifestealPercent.level or defaultPlayerState.upgrades.science.lifestealPercent.level, cost = 1, value = 1},

            copperPerWave = {level = loadedData.upgrades.science.copperPerWave.level or defaultPlayerState.upgrades.science.copperPerWave.level, cost = 1, value = 1},
            silverPerWave = {level = loadedData.upgrades.science.silverPerWave.level or defaultPlayerState.upgrades.science.silverPerWave.level, cost = 1, value = 1},
            copperBonus = {level = loadedData.upgrades.science.copperBonus.level or defaultPlayerState.upgrades.science.copperBonus.level, cost = 1, value = 1},
            silverBonus = {level = loadedData.upgrades.science.silverBonus.level or defaultPlayerState.upgrades.science.silverBonus.level, cost = 1, value = 1},
        },

        nexus = {
            attackDamage = {level = loadedData.upgrades.nexus.attackDamage.level or defaultPlayerState.upgrades.nexus.attackDamage, cost = 1},
            attackSpeed = {level = loadedData.upgrades.nexus.attackSpeed.level or defaultPlayerState.upgrades.nexus.attackSpeed, cost = 1},
            health = {level = loadedData.upgrades.nexus.health.level or defaultPlayerState.upgrades.nexus.health, cost = 1},
            regeneration = {level = loadedData.upgrades.nexus.regeneration.level or defaultPlayerState.upgrades.nexus.regeneration, cost = 1},
            abilityChance = {level = loadedData.upgrades.nexus.abilityChance.level or defaultPlayerState.upgrades.nexus.abilityChance, cost = 1},
            abilityCooldown = {level = loadedData.upgrades.nexus.abilityCooldown.level or defaultPlayerState.upgrades.nexus.abilityCooldown, cost = 1},
        }
    }
    player.upgrades.nexus.attackDamage.value = math.min(1 + (player.upgrades.nexus.attackDamage.level - 1) * 10/100, 5)
    player.upgrades.nexus.attackSpeed.value = math.min(1 + (player.upgrades.nexus.attackSpeed.level - 1) * 4/100, 2)
    player.upgrades.nexus.health.value = math.min(1 + (player.upgrades.nexus.health.level - 1) * 10/100, 5)
    player.upgrades.nexus.regeneration.value = math.min(1 + (player.upgrades.nexus.regeneration.level - 1) * 10/100, 5)
    player.upgrades.nexus.abilityChance.value = math.min(1 + (player.upgrades.nexus.abilityChance.level - 1) * 2/100, 1.8)
    player.upgrades.nexus.abilityCooldown.value = math.min(1 + (player.upgrades.nexus.abilityCooldown.level - 1) * 1.2/100, 1.36)
    player.modifiers = {
        waveSkip = {
            unlocked = loadedData.modifiers.waveSkip.unlocked,
            level = loadedData.modifiers.waveSkip.level
        },
        hyperloop = {
            unlocked = loadedData.modifiers.hyperloop.unlocked,
            level = loadedData.modifiers.hyperloop.level
        },
        acceleration = {
            unlocked = loadedData.modifiers.acceleration.unlocked,
            level = loadedData.modifiers.acceleration.level
        }
    }
    player.modifiers.waveSkip.cost = player.modifiers.waveSkip.unlocked and (player.modifiers.waveSkip.level * (player.modifiers.waveSkip.level - 1)) / 2 + 4 or 10
    player.modifiers.waveSkip.value = player.modifiers.waveSkip.unlocked and math.min(4 * player.modifiers.waveSkip.level, 40) or 0
    player.modifiers.hyperloop.cost = player.modifiers.hyperloop.unlocked and player.modifiers.hyperloop.level^2 - 2 * player.modifiers.hyperloop.level + 11 or 15
    player.modifiers.hyperloop.value = player.modifiers.hyperloop.unlocked and math.min(2 + 8 * player.modifiers.hyperloop.level, 90) or 0
    player.modifiers.acceleration.cost = player.modifiers.acceleration.unlocked and math.floor(5 * (2^(player.modifiers.acceleration.level))^0.21) or 15
    player.modifiers.acceleration.value = player.modifiers.acceleration.unlocked and math.min(0.04 * (player.modifiers.acceleration.level), 0.8) or 0
    player.settings = {
        particleMultiplierIndex = loadedData.settings.particleMultiplierIndex or defaultPlayerState.settings.particleMultiplierIndex,
        waveSkipMessages = loadedData.settings.waveSkipMessages == nil and defaultPlayerState.settings.waveSkipMessages or loadedData.settings.waveSkipMessages,
        notation = loadedData.settings.notation or defaultPlayerState.settings.notation,
        tooltips = loadedData.settings.tooltips == nil and defaultPlayerState.settings.waveSkipMessage or loadedData.settings.tooltips,
        volume = loadedData.settings.volume or defaultPlayerState.settings.volume
    }
    player.bestWaves = {d1 = loadedData.bestWaves.d1 or defaultPlayerState.bestWaves.d1, d2 = loadedData.bestWaves.d2 or defaultPlayerState.bestWaves.d2, d3 = loadedData.bestWaves.d3 or defaultPlayerState.bestWaves.d3, d4 = loadedData.bestWaves.d4 or defaultPlayerState.bestWaves.d4, d5 = loadedData.bestWaves.d5 or defaultPlayerState.bestWaves.d5}
    player.stats = {}
    player.stats.save = {}
    player.stats.save.enemiesKilled = loadedData.stats.enemiesKilled or defaultPlayerState.stats.save.enemiesKilled
    player.stats.save.damageDealt = loadedData.stats.damageDealt or defaultPlayerState.stats.save.damageDealt
    player.stats.save.silverEarned = loadedData.stats.silverEarned or defaultPlayerState.stats.save.silverEarned
    player.stats.save.goldEarned = loadedData.stats.goldEarned or defaultPlayerState.stats.save.goldEarned
    player.stats.save.wavesSkipped = loadedData.stats.wavesSkipped or defaultPlayerState.stats.save.wavesSkipped
    player.stats.save.projectilesFired = loadedData.stats.projectilesFired or defaultPlayerState.stats.save.projectilesFired
    player.stats.save.wavesBeaten = loadedData.stats.wavesBeaten or defaultPlayerState.stats.save.wavesBeaten
    player.stats.save.clusterFire = {
        triggered = loadedData.stats.save.clusterFire.triggered or defaultPlayerState.stats.save.clusterFire.triggered,
    }
    player.stats.save.lifesteal = {
        triggered = loadedData.stats.save.lifesteal.triggered,
        healed = loadedData.stats.save.lifesteal.healed,
    }
    player.stats.save.upgradesAcquired = {
        science = loadedData.stats.save.upgradesAcquired.science or defaultPlayerState.stats.save.upgradesAcquired.science,
        nexus = loadedData.stats.save.upgradesAcquired.nexus or defaultPlayerState.stats.save.upgradesAcquired.nexus
    }
    player.stats.save.spikedCrystals = {
        enemiesKilled = loadedData.stats.save.spikedCrystals.enemiesKilled or defaultPlayerState.stats.save.spikedCrystals.enemiesKilled,
        damageDealt = loadedData.stats.save.spikedCrystals.damageDealt or defaultPlayerState.stats.save.spikedCrystals.damageDealt,
        spawned = loadedData.stats.save.spikedCrystals.spawned or defaultPlayerState.stats.save.spikedCrystals.spawned
    }
    player.stats.save.scatterFire = {
        damageDealt = loadedData.stats.save.scatterFire.damageDealt or defaultPlayerState.stats.save.scatterFire.damageDealt,
        triggered = loadedData.stats.save.scatterFire.triggered or defaultPlayerState.stats.save.scatterFire.triggered
    }
    player.stats.save.burstFire = {
        damageDealt = loadedData.stats.save.burstFire.damageDealt or defaultPlayerState.stats.save.burstFire.damageDealt,
        triggered = loadedData.stats.save.burstFire.triggered or defaultPlayerState.stats.save.burstFire.triggered
    }
    player.stats.save.iceDomain = {
        triggered = loadedData.stats.save.iceDomain.triggered or defaultPlayerState.stats.save.iceDomain.triggered
    }
    player.stats.save.magmaTouch = {
        enemiesKilled = loadedData.stats.save.magmaTouch.enemiesKilled or defaultPlayerState.stats.save.magmaTouch.triggered,
        damageDealt = loadedData.stats.save.magmaTouch.damageDealt or defaultPlayerState.stats.save.magmaTouch.triggered,
        spawned = loadedData.stats.save.magmaTouch.spawned or defaultPlayerState.stats.save.magmaTouch.spawned
    }
    player.stats.save.lightningOrb = {
        enemiesKilled = loadedData.stats.save.lightningOrb.enemiesKilled or defaultPlayerState.stats.save.lightningOrb.enemiesKilled,
        damageDealt = loadedData.stats.save.lightningOrb.damageDealt or defaultPlayerState.stats.save.lightningOrb.damageDealt,
        spawned = loadedData.stats.save.lightningOrb.spawned or defaultPlayerState.stats.save.lightningOrb.spawned
    }
    player.stats.save.JerelosBlessing = {
        triggered = loadedData.stats.save.JerelosBlessing.triggered or defaultPlayerState.stats.save.JerelosBlessing.triggered,
        healthRegenerated = loadedData.stats.save.JerelosBlessing.healthRegenerated or defaultPlayerState.stats.save.JerelosBlessing.healthRegenerated
    }
    player.stats.save.supercritical = {
        triggered = loadedData.stats.save.supercritical.triggered or defaultPlayerState.stats.save.supercritical.triggered,
        damageDealt = loadedData.stats.save.supercritical.damageDealt or defaultPlayerState.stats.save.supercritical.damageDealt
    }
    player.stats.save.disruptWave =
    {
        triggered = loadedData.stats.save.disruptWave.triggered or defaultPlayerState.stats.save.disruptWave.triggered,
        damageDealt = loadedData.stats.save.disruptWave.damageDealt or defaultPlayerState.stats.save.disruptWave.damageDealt,
        enemiesKilled = loadedData.stats.save.disruptWave.enemiesKilled or defaultPlayerState.stats.save.disruptWave.enemiesKilled,
    }
    player.abilities = {
        equipped = 0,
        maxEquipped = 1
    }
    local abilityNames = {"spikedCrystals", "scatterFire", "burstFire", "iceDomain", "magmaTouch", "lightningOrb", "JerelosBlessing", "berserkerKit", "sniperKit", "tankKit", "supercritical", "disruptWave"}
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
    player.misc = {
        abilityAssembling = (loadedData.timers.abilityAssembly > 0 and loadedData.timers.abilityAssembly < loadedData.cooldowns.abilityAssembly_current), currentOrbital = love.math.random(1, 39)
    }
    player.misc.theme = loadedData.misc.theme or player.misc.theme

    -- --[[ Set Science upgrade costs (in Silver) ]]--
    player.upgrades.science.attackDamage.cost = reloadFormulae(player.upgrades.science.attackDamage.level)["science"]["ATK"][1][1]
    player.upgrades.science.attackSpeed.cost = reloadFormulae(player.upgrades.science.attackSpeed.level)["science"]["ATK"][2][1]
    player.upgrades.science.critChance.cost = reloadFormulae(player.upgrades.science.critChance.level)["science"]["ATK"][3][1]
    player.upgrades.science.critFactor.cost = reloadFormulae(player.upgrades.science.critFactor.level)["science"]["ATK"][4][1]
    player.upgrades.science.range.cost = reloadFormulae(player.upgrades.science.range.level)["science"]["ATK"][5][1]
    player.upgrades.science.clusterFireChance.cost = reloadFormulae(player.upgrades.science.clusterFireChance.level)["science"]["ATK"][6][1]
    player.upgrades.science.clusterFireTargets.cost = reloadFormulae(player.upgrades.science.clusterFireTargets.level)["science"]["ATK"][7][1]
    player.upgrades.science.clusterFireEfficiency.cost = reloadFormulae(player.upgrades.science.clusterFireEfficiency.level)["science"]["ATK"][8][1]

    player.upgrades.science.health.cost = reloadFormulae(player.upgrades.science.health.level)["science"]["VIT"][1][1]
    player.upgrades.science.regeneration.cost = reloadFormulae(player.upgrades.science.regeneration.level)["science"]["VIT"][2][1]
    player.upgrades.science.resistance.cost = reloadFormulae(player.upgrades.science.resistance.level)["science"]["VIT"][3][1]
    player.upgrades.science.shieldCooldown.cost = reloadFormulae(player.upgrades.science.shieldCooldown.level)["science"]["VIT"][4][1]
    player.upgrades.science.shieldDuration.cost = reloadFormulae(player.upgrades.science.shieldDuration.level)["science"]["VIT"][5][1]
    player.upgrades.science.meteorAmount.cost = reloadFormulae(player.upgrades.science.meteorAmount.level)["science"]["VIT"][6][1]
    player.upgrades.science.meteorRPM.cost = reloadFormulae(player.upgrades.science.meteorRPM.level)["science"]["VIT"][7][1]
    player.upgrades.science.lifestealChance.cost = reloadFormulae(player.upgrades.science.lifestealChance.level)["science"]["VIT"][8][1]
    player.upgrades.science.lifestealPercent.cost = reloadFormulae(player.upgrades.science.lifestealPercent.level)["science"]["VIT"][9][1]

    player.upgrades.science.copperPerWave.cost = reloadFormulae(player.upgrades.science.copperPerWave.level)["science"]["UTL"][1][1]
    player.upgrades.science.silverPerWave.cost = reloadFormulae(player.upgrades.science.silverPerWave.level)["science"]["UTL"][2][1]
    player.upgrades.science.copperBonus.cost = reloadFormulae(player.upgrades.science.copperBonus.level)["science"]["UTL"][3][1]
    player.upgrades.science.silverBonus.cost = reloadFormulae(player.upgrades.science.silverBonus.level)["science"]["UTL"][4][1]

    --[[ Set Nexus upgrade costs (in Tokens) ]]--
    player.upgrades.nexus.attackDamage.cost = 20 + ((player.upgrades.nexus.attackDamage.level * (player.upgrades.nexus.attackDamage.level - 1)) / 2) * 5
    player.upgrades.nexus.attackSpeed.cost = 20 + ((player.upgrades.nexus.attackSpeed.level * (player.upgrades.nexus.attackSpeed.level - 1)) / 2) * 5
    player.upgrades.nexus.health.cost = 20 + ((player.upgrades.nexus.health.level * (player.upgrades.nexus.health.level - 1)) / 2) * 5
    player.upgrades.nexus.regeneration.cost = 20 + ((player.upgrades.nexus.regeneration.level * (player.upgrades.nexus.regeneration.level - 1)) / 2) * 5
    player.upgrades.nexus.abilityChance.cost = 20 + ((player.upgrades.nexus.abilityChance.level * (player.upgrades.nexus.abilityChance.level - 1)) / 2) * 5
    player.upgrades.nexus.abilityCooldown.cost = 20 + ((player.upgrades.nexus.abilityCooldown.level * (player.upgrades.nexus.abilityCooldown.level - 1)) / 2) * 5

    player.difficulty = {
        difficulty = 1,
        unlocks = {d1 = true, d2 = player.bestWaves.d1 > 99 and true or false, d3 = player.bestWaves.d2 > 99 and true or false, d4 = player.bestWaves.d3 > 99 and true or false, d5 = player.bestWaves.d4 > 99 and true or false}
    }

    player.menu = {
        abilities = {},
        saveStats = false,
        rolledAbilityDisplay = false,
        debugInfo = false
    }

    abilityFunctions.updateLeveling()
    abilityFunctions.updateInternals()
    abilityFunctions.updateSlotCount()

    if player.abilities.equipped > player.abilities.maxEquipped then
        for i,v in pairs(internalAbilities) do
            if v.equipped then
                player.abilities[v.internalName].equipped = false
            end
        end
    end

    player.maxGameSpeed = 1 + player.modifiers.acceleration.value

    if player.canClaim.ability and player.misc.abilityAssembling then
        player.timers.abilityAssembly = player.cooldowns.abilityAssembly_current
        player.canClaim.ability = false
        player.misc.abilityAssembling = true
    end
    player.idleGains.silver, player.idleGains.gold = reloadIdleGains()

    accentColors = {
        main = {
            buttons = {0.1, 0.15, 0.5, 1},
            buttonOutlines = {0.3, 0.75, 0.85, 1},
            towerInfo = {0.106, 0.11, 0.22, 1},
            upgradeModule = {0, 0.1, 0.2},
            menus = {0.15, 0, 0.3, 1},
            background = love.graphics.newImage("assets/background.png")
        },
        stellar = {
            buttons = {0.1, 0.15, 0.5, 1},
            buttonOutlines = {0.3, 0.75, 0.85, 1},
            towerInfo = {0.106, 0.11, 0.22, 1},
            upgradeModule = {0, 0.1, 0.2},
            menus = {0.15, 0, 0.3, 1},
            background = love.graphics.newImage("assets/background_stellar.png")
        },
        eclipse = {
            buttons = {0.33, 0, 0, 1},
            buttonOutlines = {0.81, 0, 0, 1},
            towerInfo = {0.13, 0.05, 0, 1},
            upgradeModule = {0.16, 0.06, 0},
            menus = {0.12, 0.05, 0, 1},
            background = love.graphics.newImage("assets/background_eclipse.png")
        },
        nova = {
            buttons = {0.19, 0.32, 0.33, 1},
            buttonOutlines = {0.29, 0.71, 0.75, 1},
            towerInfo = {0, 0.004, 0.1},
            upgradeModule = {0.04, 0.07, 0.07},
            menus = {0.09, 0.15, 0.15, 1},
            background = love.graphics.newImage("assets/background_nova.png")
        },
        aurora = {
            buttons = {0.28, 0.1, 0.5, 1},
            buttonOutlines = {0.83, 0.5, 1, 1},
            towerInfo = {0.27, 0, 0.33},
            upgradeModule = {0.13, 0, 0.2},
            menus = {0.16, 0, 0.19, 1},
            background = love.graphics.newImage("assets/background_aurora.png")
        }
    }

    player.debug = {
        updateTimer = 0,
        updateInterval = 1,
        memUsage = 0,
        currentUpdates = 0,
        UPS = 0
    }
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
    player.menu.enemyInfo = false

    --[[ Copper ]]--
    player.currencies.currentCopper = 0

    --[[ Set Round upgrade levels to initial Science upgrade levels ]]--
    player.upgrades.round = {
        attackDamage = {level = player.upgrades.science.attackDamage.level, cost = 2, value = 1},
        attackSpeed = {level = player.upgrades.science.attackSpeed.level, cost = 5, value = 1},
        critChance = {level = player.upgrades.science.critChance.level, cost = 6, value = 1},
        critFactor = {level = player.upgrades.science.critFactor.level, cost = 2, value = 1},
        range = {level = player.upgrades.science.range.level, cost = 2, value = 1},
        clusterFireChance = {level = player.upgrades.science.clusterFireChance.level, cost = 10, value = 1},
        clusterFireTargets = {level = player.upgrades.science.clusterFireTargets.level, cost = 400, value = 1},
        clusterFireEfficiency = {level = player.upgrades.science.clusterFireEfficiency.level, cost = 3, value = 1},

        health = {level = player.upgrades.science.health.level, cost = 3, value = 1},
        regeneration = {level = player.upgrades.science.regeneration.level, cost = 5, value = 1},
        resistance = {level = player.upgrades.science.resistance.level, cost = 4, value = 1},
        shieldCooldown = {level = player.upgrades.science.shieldCooldown.level, cost = 4, value = 1},
        shieldDuration = {level = player.upgrades.science.shieldDuration.level, cost = 3, value = 1},
        meteorAmount = {level = player.upgrades.science.meteorAmount.level, cost = 200, value = 1},
        meteorRPM = {level = player.upgrades.science.meteorRPM.level, cost = 20, value = 1},
        lifestealChance = {level = player.upgrades.science.lifestealChance.level, cost = 20, value = 1},
        lifestealPercent = {level = player.upgrades.science.lifestealPercent.level, cost = 10, value = 1},

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
        clusterFireChance = reloadFormulae(player.upgrades.round.clusterFireChance.level)["science"]["ATK"][6][2],
        clusterFireTargets = reloadFormulae(player.upgrades.round.clusterFireTargets.level)["science"]["ATK"][7][2],
        clusterFireEfficiency = reloadFormulae(player.upgrades.round.clusterFireEfficiency.level)["science"]["ATK"][8][2],

        health = reloadFormulae(player.upgrades.round.health.level)["science"]["VIT"][1][2],
        currentHealth = reloadFormulae(player.upgrades.round.health.level)["science"]["VIT"][1][2],
        regeneration = reloadFormulae(player.upgrades.round.regeneration.level)["science"]["VIT"][2][2],
        resistance = reloadFormulae(player.upgrades.round.resistance.level)["science"]["VIT"][3][2],
        shieldCooldown = reloadFormulae(player.upgrades.round.shieldCooldown.level)["science"]["VIT"][4][2],
        shieldDuration = reloadFormulae(player.upgrades.round.shieldDuration.level)["science"]["VIT"][5][2],
        meteorAmount = reloadFormulae(player.upgrades.round.meteorAmount.level)["science"]["VIT"][6][2],
        meteorRPM = reloadFormulae(player.upgrades.round.meteorRPM.level)["science"]["VIT"][7][2],
        lifestealChance = reloadFormulae(player.upgrades.round.lifestealChance.level)["science"]["VIT"][8][2],
        lifestealPercent = reloadFormulae(player.upgrades.round.lifestealPercent.level)["science"]["VIT"][9][2],
        
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
        clusterFire = {triggered = 0},
        lifesteal = {triggered = 0, healed = 0},
        spikedCrystals = {enemiesKilled = 0, damageDealt = 0, spawned = 0},
        scatterFire = {damageDealt = 0, triggered = 0},
        burstFire = {damageDealt = 0, triggered = 0},
        iceDomain = {triggered = 0},
        magmaTouch = {enemiesKilled = 0, damageDealt = 0, spawned = 0},
        lightningOrb = {enemiesKilled = 0, damageDealt = 0, spawned = 0},
        JerelosBlessing = {triggered = 0, healthRegenerated = 0},
        supercritical = {triggered = 0, damageDealt = 0},
        disruptWave = {triggered = 0, damageDealt = 0, enemiesKilled = 0}
    }
    player.stats.wave = {enemiesKilled = 0}
    enemyAttributes = {}
    --[[ Enemy properties ]]--

    updateEnemyStats(gameplay.difficulty, gameplay.wave)

    --[[ Timers ]]--
    timers = {projectile = 0, enemy = 0, nextWave = 0, shieldActivation = 0, shieldActive = 0, waveSkip = 3, copperAdd = 2, silverAdd = 2, crystal = 0, magmaPool = 0, lightningOrb = 0, disruptWave = 0}

    --[[ Misc ]]--
    player.misc.waveSkipMessage = false
    player.misc.copperAddedMessage = false
    player.misc.silverAddedMessage = false
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

    processUpgradeModule.reload()
end
