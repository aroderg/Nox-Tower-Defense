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

        player.abilities = {
            waveSkip = {
                unlocked = data.player.abilities.unlocks.waveSkip,
                level = data.player.abilities.waveSkip.chance
            }
        }
        if not data.player.abilities.unlocks.waveSkip then
            player.abilities.waveSkip.cost = 20
            player.abilities.waveSkip.value = 0
        else
            player.abilities.waveSkip.cost = (player.abilities.waveSkip.level * (player.abilities.waveSkip.level - 1)) / 2 + 4
            player.abilities.waveSkip.value = math.min(6 * player.abilities.waveSkip.level - 1, 65)
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

        player.abilities = {
            waveSkip = {
                unlocked = false,
                level = 1,
                cost = 20,
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
    end

    --[[ Set Science upgrade costs (in Silver) ]]--
    player.upgrades.science.attackDamage.cost = math.floor(0.4 * player.upgrades.science.attackDamage.level^2 + 2.6)
    player.upgrades.science.attackSpeed.cost = math.floor(8^((player.upgrades.science.attackSpeed.level - 1) / 20) + 3 * player.upgrades.science.attackSpeed.level + 4)
    player.upgrades.science.critChance.cost = math.floor((player.upgrades.science.critChance.level / 2)^2 + 4 * player.upgrades.science.critChance.level + 1.75)
    player.upgrades.science.critFactor.cost = math.floor(0.2 * (player.upgrades.science.critFactor.level^2) + 1.8)
    player.upgrades.science.range.cost = math.floor((player.upgrades.science.range.level^2 + 5 * player.upgrades.science.range.level) / 3 + 2 * player.upgrades.science.range.level + 4)

    player.upgrades.science.health.cost = math.floor(0.6 * player.upgrades.science.health.level^2 + 3.4)
    player.upgrades.science.regeneration.cost = math.floor(player.upgrades.science.regeneration.level^1.75 + 2 * player.upgrades.science.regeneration.level + 3)
    player.upgrades.science.resistance.cost = math.floor(player.upgrades.science.resistance.level * math.sqrt(2 * player.upgrades.science.resistance.level) + 3 - math.sqrt(2))
    player.upgrades.science.shieldCooldown.cost = math.floor(player.upgrades.science.shieldCooldown.level^(math.log(player.upgrades.science.shieldCooldown.level, 10)) + 3)
    player.upgrades.science.shieldDuration.cost = math.floor((player.upgrades.science.shieldDuration.level)^(math.log(player.upgrades.science.shieldDuration.level) / 2) + 3)
    player.upgrades.science.meteorAmount.cost = math.floor((16 * player.upgrades.science.meteorAmount.level)^2 + 144)
    player.upgrades.science.meteorRPM.cost = math.floor((3 * player.upgrades.science.meteorRPM.level)^2 + 41)

    player.upgrades.science.copperPerWave.cost = math.floor((player.upgrades.science.copperPerWave.level^2 + player.upgrades.science.copperPerWave.level + 1) * 3 + 11)
    player.upgrades.science.silverPerWave.cost = math.floor(((8 * player.upgrades.science.silverPerWave.level) / 5)^2 + 27.44)
    player.upgrades.science.copperBonus.cost = math.floor((0.4 * (player.upgrades.science.copperBonus.level - 1))^1.9 + 8)
    player.upgrades.science.silverBonus.cost = math.floor(0.4 * player.upgrades.science.silverBonus.level^2 + player.upgrades.science.silverBonus.level + 8.6)

    --[[ Set Nexus upgrade costs (in Tokens) ]]--
    player.upgrades.nexus.attackDamage.cost = 50 + ((player.upgrades.nexus.attackDamage.level * (player.upgrades.nexus.attackDamage.level - 1)) / 2) * 10
    player.upgrades.nexus.attackSpeed.cost = 50 + ((player.upgrades.nexus.attackSpeed.level * (player.upgrades.nexus.attackSpeed.level - 1)) / 2) * 10
    player.upgrades.nexus.health.cost = 50 + ((player.upgrades.nexus.health.level * (player.upgrades.nexus.health.level - 1)) / 2) * 10
    player.upgrades.nexus.regeneration.cost = 50 + ((player.upgrades.nexus.regeneration.level * (player.upgrades.nexus.regeneration.level - 1)) / 2) * 10

    player.difficulty = {
        difficulty = 1,
        unlocks = {
            d1 = true,
            d2 = player.bestWaves.d1 > 150 and true or false,
            d3 = player.bestWaves.d2 > 150 and true or false,
            d4 = player.bestWaves.d3 > 150 and true or false
        }
    }

    player.stats = {}

    --saveGame()
end

function resetRoundValues()
    --[[ Reset all properties to initial at the start of the round ]]--

    player.menu = {}
    player.menu.paused = false
    player.menu.settings = false
    player.menu.upgrades = false

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

    local maxHealth = ((0.3 * player.upgrades.round.health.level - 0.3)^3.75 + 14.6 + 0.4 * player.upgrades.round.health.level) * player.upgrades.nexus.health.value
    --[[ Tower properties ]]--
    player.tower = {
        attackDamage = ((0.25 * player.upgrades.round.attackDamage.level - 0.25)^3 + 4 + player.upgrades.round.attackDamage.level) * player.upgrades.nexus.attackDamage.value,
        attackSpeed = (math.min(0.5 + 0.04 * (player.upgrades.round.attackSpeed.level - 1), 4.5)) * player.upgrades.nexus.attackSpeed.value,
        critChance = math.min((player.upgrades.round.critChance.level - 1) / 2, 50),
        critFactor = 1 + ((player.upgrades.round.critFactor.level - 1) / 20),
        range = math.min(240 + 2 * (player.upgrades.round.range.level - 1), 360),
        maxHealth = ((0.3 * player.upgrades.round.health.level - 0.3)^3.75 + 14.6 + 0.4 * player.upgrades.round.health.level) * player.upgrades.nexus.health.value,
        currentHealth = maxHealth,
        regeneration = (((0.8 * player.upgrades.round.regeneration.level - 0.8)^2.75) / 50) * player.upgrades.nexus.regeneration.value,
        resistance = math.min(0.75 * (player.upgrades.round.resistance.level - 1), 90),
        shieldCooldown = math.max(120 - 0.6 * (player.upgrades.round.shieldCooldown.level - 1), 45),
        shieldDuration = math.min(0.05 * (player.upgrades.round.shieldDuration.level - 1) + 0.5, 6),
        meteorAmount = math.min(player.upgrades.round.meteorAmount.level - 1, 5),
        meteorRPM = math.min(0.15 * player.upgrades.round.meteorRPM.level + 0.25, 6.25),
        copperPerWave = 4 * (player.upgrades.round.copperPerWave.level - 1),
        silverPerWave = 3 * (player.upgrades.round.silverPerWave.level - 1),
        copperBonus = math.min(1 + 0.02 * (player.upgrades.round.copperBonus.level - 1), 10),
        silverBonus = math.min(1 + 0.01 * (player.upgrades.round.silverBonus.level - 1), 4),
    }

    --[[ Gameplay properties ]]--
    gameplay = {
        difficulty = player.difficulty.difficulty,
        wave = 1
    }
    misc = {
        copperBuffer = 0,
        silverBuffer = 0
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