function loadGame()
    -- Initialise player
    player = {}
    if love.filesystem.getInfo("SAVEFILE.sav") then
        file = love.filesystem.read("SAVEFILE.sav")
        data = lume.deserialize(file)

        player.location = "hub"
        player.cooldowns = {
            electrum = 24,
            tokens = 600
        }
        player.timers = {
            electrum = data.player.timers.electrum,
            tokens = data.player.timers.tokens
        }
        player.canClaim = {}
        if data.player.timers.tokens > 0 then
            player.canClaim.tokens = false
        else
            player.canClaim.tokens = true
        end
        if data.player.timers.electrum > 0 then
            player.canClaim.electrum = false
        else
            player.canClaim.electrum = true
        end

        player.currencies = {
            currentSilver = data.player.currentSilver,
            currentGold = data.player.currentGold,
            currentElectrum = data.player.currentElectrum,
            currentTokens = data.player.currentTokens,
        }

        --[[ Set upgrade unlocks ]]--
        player.upgrades = {
            unlocks = {
                crit = data.player.upgrades.unlocks.crit,
                range = data.player.upgrades.unlocks.range,

                resistance = data.player.upgrades.unlocks.resistance,
                shield = data.player.upgrades.unlocks.shield,
                meteor = data.player.upgrades.unlocks.meteor,

                resourceBonus = data.player.upgrades.unlocks.resourceBonus
            },
            science = {
                attackDamage = {
                    level = data.player.upgrades.attackDamage,
                    cost = 1,
                    value = 1
                },
                attackSpeed = {
                    level = data.player.upgrades.attackSpeed,
                    cost = 1,
                    value = 1
                },
                critChance = {
                    level = data.player.upgrades.critChance,
                    cost = 1,
                    value = 1
                },
                critFactor = {
                    level = data.player.upgrades.critFactor,
                    cost = 1,
                    value = 1
                },
                range = {
                    level = data.player.upgrades.range,
                    cost = 1,
                    value = 1
                },

                health = {
                    level = data.player.upgrades.health,
                    cost = 1,
                    value = 1
                },
                regeneration = {
                    level = data.player.upgrades.regeneration,
                    cost = 1,
                    value = 1
                },
                resistance = {
                    level = data.player.upgrades.resistance,
                    cost = 1,
                    value = 1
                },
                shieldCooldown = {
                    level = data.player.upgrades.shieldCooldown,
                    cost = 1,
                    value = 1
                },
                shieldDuration = {
                    level = data.player.upgrades.shieldDuration,
                    cost = 1,
                    value = 1
                },
                meteorAmount = {
                    level = data.player.upgrades.meteorAmount,
                    cost = 1,
                    value = 1
                },
                meteorRPM = {
                    level = data.player.upgrades.meteorRPM,
                    cost = 1,
                    value = 1
                },
                
                copperPerWave = {
                    level = data.player.upgrades.copperPerWave,
                    cost = 1,
                    value = 1
                },
                silverPerWave = {
                    level = data.player.upgrades.silverPerWave,
                    cost = 1,
                    value = 1
                },
                copperBonus = {
                    level = data.player.upgrades.copperBonus,
                    cost = 1,
                    value = 1
                },
                silverBonus = {
                    level = data.player.upgrades.silverBonus,
                    cost = 1,
                    value = 1
                },
            },

            nexus = {
                attackDamage = {
                    level = data.player.upgrades.nexus.attackDamage,
                    cost = 1,
                    value = math.min(1 + (data.player.upgrades.nexus.attackDamage - 1) * 10/100, 5)
                },
                attackSpeed = {
                    level = data.player.upgrades.nexus.attackSpeed,
                    cost = 1,
                    value = math.min(1 + (data.player.upgrades.nexus.attackSpeed - 1) * 4/100, 2)
                },
                health = {
                    level = data.player.upgrades.nexus.health,
                    cost = 1,
                    value = math.min(1 + (data.player.upgrades.nexus.health - 1) * 10/100, 5)
                },
                regeneration = {
                    level = data.player.upgrades.nexus.regeneration,
                    cost = 1,
                    value = math.min(1 + (data.player.upgrades.nexus.regeneration - 1) * 10/100, 5)
                },
            }
        }

        player.modifiers = {
            waveSkip = {
                unlocked = data.player.modifiers.unlocks.waveSkip,
                level = data.player.modifiers.waveSkip.level
            },
            hyperloop = {
                unlocked = data.player.modifiers.unlocks.hyperloop,
                level = data.player.modifiers.hyperloop.level,
            }
        }
        if not data.player.modifiers.unlocks.waveSkip then
            player.modifiers.waveSkip.cost = 10
            player.modifiers.waveSkip.value = 0
        else
            player.modifiers.waveSkip.cost = (player.modifiers.waveSkip.level * (player.modifiers.waveSkip.level - 1)) / 2 + 4
            player.modifiers.waveSkip.value = math.min(4 * player.modifiers.waveSkip.level, 40)
        end
        if not data.player.modifiers.unlocks.hyperloop then
            player.modifiers.hyperloop.cost = 15
            player.modifiers.hyperloop.value = 0
        else
            player.modifiers.hyperloop.cost = player.modifiers.hyperloop.level^2 - 2 * player.modifiers.hyperloop.level + 11
            player.modifiers.hyperloop.value = math.min(2 + 8 * player.modifiers.hyperloop.level, 90)
        end

        player.settings = {
            particleMultiplier = data.settings.particleMultiplierIndex,
            waveSkipMessages = data.settings.waveSkipMessages,
            notation = data.settings.notation,
            tooltips = data.settings.tooltips,
        }

        player.bestWaves = {
            d1 = data.player.pb.d1,
            d2 = data.player.pb.d2,
            d3 = data.player.pb.d3,
            d4 = data.player.pb.d4,
        }

        player.stats = {}
        player.stats.save = {
            enemiesKilled = data.player.stats.enemiesKilled,
            damageDealt = data.player.stats.damageDealt,
            silverEarned = data.player.stats.silverEarned,
            wavesSkipped = data.player.stats.wavesSkipped,
            projectilesFired = data.player.stats.projectilesFired,
            upgradesAcquired = {
                science = data.player.stats.upgradesAcquired.science,
                nexus = data.player.stats.upgradesAcquired.nexus
            },
            wavesBeaten = data.player.stats.wavesBeaten
        }

    else

        player.paused = false
        player.location = "round"
        player.cooldowns = {
            electrum = 24,
            tokens = 600
        }
        player.timers = {
            electrum = 0,
            tokens = 600
        }

        player.canClaim = {}

        player.canClaim.tokens = true
        player.canClaim.electrum = true

        player.currencies = {
            currentSilver = 0,
            currentGold = 0,
            currentElectrum = 0,
            currentTokens = 0,
        }

        --[[ Set upgrade unlocks ]]--
        player.upgrades = {
            unlocks = {
                crit = false,
                range = false,

                resistance = false,
                shield = false,
                meteor = false,

                resourceBonus = false
            },
            science = {
                attackDamage = {
                    level = 1,
                    cost = 1,
                    value = 1
                },
                attackSpeed = {
                    level = 1,
                    cost = 1,
                    value = 1
                },
                critChance = {
                    level = 1,
                    cost = 1,
                    value = 1
                },
                critFactor = {
                    level = 1,
                    cost = 1,
                    value = 1
                },
                range = {
                    level = 1,
                    cost = 1,
                    value = 1
                },

                health = {
                    level = 1,
                    cost = 1,
                    value = 1
                },
                regeneration = {
                    level = 1,
                    cost = 1,
                    value = 1
                },
                resistance = {
                    level = 1,
                    cost = 1,
                    value = 1
                },
                shieldCooldown = {
                    level = 1,
                    cost = 1,
                    value = 1
                },
                shieldDuration = {
                    level = 1,
                    cost = 1,
                    value = 1
                },
                meteorAmount = {
                    level = 1,
                    cost = 1,
                    value = 1
                },
                meteorRPM = {
                    level = 1,
                    cost = 1,
                    value = 1
                },
                
                copperPerWave = {
                    level = 1,
                    cost = 1,
                    value = 1
                },
                silverPerWave = {
                    level = 1,
                    cost = 1,
                    value = 1
                },
                copperBonus = {
                    level = 1,
                    cost = 1,
                    value = 1
                },
                silverBonus = {
                    level = 1,
                    cost = 1,
                    value = 1
                },
            },

            nexus = {
                attackDamage = {
                    level = 1,
                    cost = 1,
                    value = 1
                },
                attackSpeed = {
                    level = 1,
                    cost = 1,
                    value = 1
                },
                health = {
                    level = 1,
                    cost = 1,
                    value = 1
                },
                regeneration = {
                    level = 1,
                    cost = 1,
                    value = 1
                },
            }
        }

        player.modifiers = {
            waveSkip = {
                unlocked = false,
                level = 1,
                cost = 15,
                value = 0
            },
            hyperloop = {
                unlocked = false,
                level = 1,
                cost = 10,
                value = 0
            }
        }

        player.settings = {
            particleMultiplier = 4,
            waveSkipMessages = true,
            notation = "kmbt",
            tooltips = true,
        }

        player.bestWaves = {
            d1 = 0,
            d2 = 0,
            d3 = 0,
            d4 = 0,
        }

        player.stats = {}
        player.stats.save = {
            enemiesKilled = 0,
            damageDealt = 0,
            silverEarned = 0,
            wavesSkipped = 0,
            projectilesFired = 0,
            upgradesAcquired = {
                science = 0,
                nexus = 0
            },
            wavesBeaten = 0
        }
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
        unlocks = {
            d1 = true,
            d2 = player.bestWaves.d1 > 99 and true or false,
            d3 = player.bestWaves.d2 > 99 and true or false,
            d4 = player.bestWaves.d3 > 99 and true or false
        }
    }

    player.menu = {}
    player.menu.saveStats = false

    --saveGame()
end

function resetRoundValues()
    --[[ Reset all properties to initial at the start of the round ]]--

    player.menu = {}
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
        attackDamage = {
            level = player.upgrades.science.attackDamage.level,
            cost = 2,
            value = 1
        },
        attackSpeed = {
            level = player.upgrades.science.attackSpeed.level,
            cost = 5,
            value = 1
        },
        critChance = {
            level = player.upgrades.science.critChance.level,
            cost = 6,
            value = 1
        },
        critFactor = {
            level = player.upgrades.science.critFactor.level,
            cost = 2,
            value = 1
        },
        range = {
            level = player.upgrades.science.range.level,
            cost = 2,
            value = 1
        },

        health = {
            level = player.upgrades.science.health.level,
            cost = 3,
            value = 1
        },
        regeneration = {
            level = player.upgrades.science.regeneration.level,
            cost = 5,
            value = 1
        },
        resistance = {
            level = player.upgrades.science.resistance.level,
            cost = 4,
            value = 1
        },
        shieldCooldown = {
            level = player.upgrades.science.shieldCooldown.level,
            cost = 4,
            value = 1
        },
        shieldDuration = {
            level = player.upgrades.science.shieldDuration.level,
            cost = 3,
            value = 1
        },
        meteorAmount = {
            level = player.upgrades.science.meteorAmount.level,
            cost = 200,
            value = 1
        },
        meteorRPM = {
            level = player.upgrades.science.meteorRPM.level,
            cost = 20,
            value = 1
        },
        
        copperPerWave = {
            level = player.upgrades.science.copperPerWave.level,
            cost = 10,
            value = 1
        },
        silverPerWave = {
            level = player.upgrades.science.silverPerWave.level,
            cost = 10,
            value = 1
        },
        copperBonus = {
            level = player.upgrades.science.copperBonus.level,
            cost = 4,
            value = 1
        },
        silverBonus = {
            level = player.upgrades.science.silverBonus.level,
            cost = 7,
            value = 1
        },
    }

    local maxHealth = reloadFormulae(player.upgrades.round.health.level)["science"]["VIT"][1][2]
    --[[ Tower properties ]]--
    player.tower = {
        attackDamage = reloadFormulae(player.upgrades.round.attackDamage.level)["science"]["ATK"][1][2],
        attackSpeed = reloadFormulae(player.upgrades.round.attackSpeed.level)["science"]["ATK"][2][2],
        critChance = reloadFormulae(player.upgrades.round.critChance.level)["science"]["ATK"][3][2],
        critFactor = reloadFormulae(player.upgrades.round.critFactor.level)["science"]["ATK"][4][2],
        range = reloadFormulae(player.upgrades.round.range.level)["science"]["ATK"][5][2],
        maxHealth = reloadFormulae(player.upgrades.round.health.level)["science"]["VIT"][1][2],
        currentHealth = maxHealth,
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
    gameplay = {
        difficulty = player.difficulty.difficulty,
        wave = 1
    }
    misc = {
        copperBuffer = 0,
        silverBuffer = 0,
        copperAtStart = player.currencies.currentCopper,
        silverAtStart = player.currencies.currentSilver
    }
    player.stats.battle = {
        time = 0,
        enemiesKilled = 0,
        damageTaken = 0,
        damageDealt = 0,
        copperEarned = 0,
        silverEarned = 0,
        shieldDamageAbsorb = 0,
        wavesSkipped = 0,
        projectilesFired = 0,
        upgradesAcquired = 0,
        goldEarned = 0
    }
    player.stats.wave = {
        enemiesKilled = 0
    }
    enemyAttributes = {}
    --[[ Enemy properties ]]--

    updateEnemyStats(gameplay.difficulty, gameplay.wave)

    --[[ Timers ]]--
    timers = {
        projectile = 0,
        enemy = 0,
        nextWave = 0,
        shieldActivation = 0,
        shieldActive = 0,
        waveSkip = 3
    }

    --[[ Misc ]]--
    waveSkipMessage = false
    projectilesOnField = {}
    enemiesOnField = {}
    particles = {}
    collapseParticles = {}
    hitTextParticles = {}
    meteors = {}
    for i=1,player.tower.meteorAmount do
        createMeteor(((i-1) * (2 * math.pi) / player.tower.meteorAmount) - 0.5 * math.pi)
    end
    sentryAlive = false
    centurionAlive = false
end