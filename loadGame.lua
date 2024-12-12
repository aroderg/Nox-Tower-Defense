function loadGame()
    -- Initialise player
    player = {}
    if love.filesystem.getInfo("SAVEFILE.sav") then
        file = love.filesystem.read("SAVEFILE.sav")
        data = lume.deserialize(file)

        player.location = "hub"
        player.cooldowns = {
            electrum = 24,
            tokens = 600,
            abilityAssembly_min = 400,
            abilityAssembly_max = 800,
            abilityAssembly_current = data.player.cooldowns.abilityAssembly
        }
        player.timers = {
            electrum = data.player.timers.electrum,
            tokens = data.player.timers.tokens,
            abilityAssembly = data.player.timers.abilityAssembly
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
        if data.player.timers.abilityAssembly > 0 then
            player.canClaim.ability = false
        else
            player.canClaim.ability = true
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
            volume = data.settings.volume
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

        player.abilities = {
            equipped = 0,
            maxEquipped = 1,
            spikedCrystals = {
                unlocked = data.player.abilities.spikedCrystals.unlocked,
                level = data.player.abilities.spikedCrystals.level,
                equipped = data.player.abilities.spikedCrystals.equipped,
                amount = data.player.abilities.spikedCrystals.amount
            },
            scatterFire = {
                unlocked = data.player.abilities.scatterFire.unlocked,
                level = data.player.abilities.scatterFire.level,
                equipped = data.player.abilities.scatterFire.equipped,
                amount = data.player.abilities.scatterFire.amount
            },
            burstFire = {
                unlocked = data.player.abilities.burstFire.unlocked,
                level = data.player.abilities.burstFire.level,
                equipped = data.player.abilities.burstFire.equipped,
                amount = data.player.abilities.burstFire.amount
            },
            rainforest = {
                unlocked = data.player.abilities.rainforest.unlocked,
                level = data.player.abilities.rainforest.level,
                equipped = data.player.abilities.rainforest.equipped,
                amount = data.player.abilities.rainforest.amount
            },
            magmaTouch = {
                unlocked = data.player.abilities.magmaTouch.unlocked,
                level = data.player.abilities.magmaTouch.level,
                equipped = data.player.abilities.magmaTouch.equipped,
                amount = data.player.abilities.magmaTouch.amount
            },
        }

        player.misc = {}
        player.misc.abilityAssembling = data.player.misc.abilityAssembling

    else

        player.paused = false
        player.location = "round"
        player.cooldowns = {
            electrum = 24,
            tokens = 600,
            abilityAssembly_min = 400,
            abilityAssembly_max = 800,
            abilityAssembly_current = 600
        }
        player.timers = {
            electrum = 0,
            tokens = 600,
            abilityAssembly = 0
        }

        player.canClaim = {}

        player.canClaim.tokens = true
        player.canClaim.electrum = true
        player.canClaim.ability = true

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
            volume = 1
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

        player.abilities = {
            equipped = 0,
            maxEquipped = 1,
            spikedCrystals = {
                unlocked = false,
                level = 0,
                equipped = false,
                amount = 0
            },
            scatterFire = {
                unlocked = false,
                level = 0,
                equipped = false,
                amount = 0
            },
            burstFire = {
                unlocked = false,
                level = 0,
                equipped = false,
                amount = 0
            },
            rainforest = {
                unlocked = false,
                level = 0,
                equipped = false,
                amount = 0
            },
            magmaTouch = {
                unlocked = false,
                level = 0,
                equipped = false,
                amount = 0
            }
        }

        player.misc = {}
        player.misc.abilityAssembling = false
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

    player.menu = {
        abilities = {
            spikedCrystals = false,
            scatterFire = false,
            burstFire = false,
            rainforest = false,
            magmaTouch = false
        }
    }
    player.menu.saveStats = false
    player.menu.rolledAbilityDisplay = false

    function abilityFunctions.updateInternals() --update the ability levels and leveling info

        levelingInfo = {
            {
                --| SPIKED CRYSTALS - LEVELS FROM 0 to 11 |--
                quantity =          {4,   4,   5,   5,   6,    6,    7,   7,   8,   8,   9,   10},
                damage =            {250, 275, 300, 325, 350,  375,  400, 450, 500, 550, 600, 600}, -- %
                frequency =         {16,  15,  14,  13,  12.2, 11.6, 10,  9.5, 9,   8.6, 8.2, 8},
                levelRequirements = {2,   2,   2,   3,   3,    4,    5,   6,   8,   10,  12,  15}
            },
            {
                --| SCATTER FIRE - LEVELS FROM 0 to 11 |--
                quantity =          {4, 4,   4, 6, 6,   6, 8,  8,   10,  10, 12, 16},
                frequency =         {1, 1.5, 2, 2, 2.5, 3, 3,  3.5, 3.5, 4,  4,  4}, -- %
                levelRequirements = {2, 2,   3, 3, 4,   4, 5,  6,   7,   8,  10, 15}
            },
            {
                --| BURST FIRE - LEVELS FROM 0 to 8 |--
                quantity =          {4,   4, 4,   6,   6, 8, 8,   12,   12, 12},
                frequency =         {1.5, 2, 2.5, 2.5, 3, 3, 3.5, 3.5,  4,  5}, -- %
                levelRequirements = {2,   3, 4,   5,   6, 8, 10,  15,   15, 18}
            },
            {
                --| RAINFOREST - LEVELS FROM 0 to 10 |--
                density =           {10, 12, 14, 16, 18, 20, 22.5, 25, 27.5, 30, 32.5},
                frequency =         10, -- waves
                levelRequirements = {1,  1,  2,  2,  3,  3,  4,    5,  6,    7,  8}
            },
            {
                --| MAGMA TOUCH - LEVELS FROM 0 to 9 |--
                frequency =         {20,  18.5, 16, 14.5, 13.5, 12.5, 11.5, 11,   10.5, 10},
                damage =            {7.5, 8.5,  10, 12,   14,   16,   18,   20,   23.5, 27.5}, -- %
                levelRequirements = {3,   3,    4,  4,    5,    7,    9,    12,   16,   20}
            }
        }

        internalAbilities = {
            {
                name = "Spiked Crystals",
                internalName = "spikedCrystals",
                effect = {{1, 1, 1, 1}, "Spawn up to ", {1, 0.5, 0.4, 1}, levelingInfo[1].quantity[player.abilities.spikedCrystals.level + 1], {1, 1, 1, 1}, " crystals inside the tower's range. Upon getting touched by an enemy, the crystal explodes and deals ", {1, 0.4, 0.8, 1}, levelingInfo[1].damage[player.abilities.spikedCrystals.level + 1], {1, 1, 1, 1}, "% damage to nearby enemies."},
                event = "Time",
                frequency = levelingInfo[1].frequency[player.abilities.spikedCrystals.level + 1],
                level = player.abilities.spikedCrystals.level,
                preview = img_ability_preview_spikedCrystals,
                equipped = player.abilities.spikedCrystals.equipped,
                unlocked = player.abilities.spikedCrystals.unlocked,
                menu = player.menu.abilities.spikedCrystals,
                amount = player.abilities.spikedCrystals.amount,
                class = "B",
                nextLevelRequirement = levelingInfo[1].levelRequirements[player.abilities.spikedCrystals.level + 1],
                levelRequirements = levelingInfo[1].levelRequirements
            },
            {
                name = "Scatter Fire",
                internalName = "scatterFire",
                effect = {{1, 1, 1, 1}, "Shoot out ", {0.5, 0.9, 0.8, 1}, levelingInfo[2].quantity[player.abilities.scatterFire.level + 1], {1, 1, 1, 1}, " projectiles going from a random point on the screen."},
                event = "Projectile",
                frequency = levelingInfo[2].frequency[player.abilities.scatterFire.level + 1],
                level = player.abilities.scatterFire.level,
                preview = img_ability_preview_scatterFire,
                equipped = player.abilities.scatterFire.equipped,
                unlocked = player.abilities.scatterFire.unlocked,
                menu = player.menu.abilities.scatterFire,
                amount = player.abilities.scatterFire.amount,
                class = "C",
                nextLevelRequirement = levelingInfo[2].levelRequirements[player.abilities.scatterFire.level + 1],
                levelRequirements = levelingInfo[2].levelRequirements
            },
            {
                name = "Burst Fire",
                internalName = "burstFire",
                effect = {{1, 1, 1, 1}, "Shoot out ", {0.75, 0.75, 0.75, 1}, levelingInfo[3].quantity[player.abilities.burstFire.level + 1], {1, 1, 1, 1}, " projectiles going from the center of the tower."},
                event = "Projectile",
                frequency = levelingInfo[3].frequency[player.abilities.burstFire.level + 1],
                level = player.abilities.burstFire.level,
                preview = img_ability_preview_burstFire,
                equipped = player.abilities.burstFire.equipped,
                unlocked = player.abilities.burstFire.unlocked,
                menu = player.menu.abilities.burstFire,
                amount = player.abilities.burstFire.amount,
                class = "C",
                nextLevelRequirement = levelingInfo[3].levelRequirements[player.abilities.burstFire.level + 1],
                levelRequirements = levelingInfo[3].levelRequirements
            },
            {
                name = "Rainforest",
                internalName = "rainforest",
                effect = {{1, 1, 1, 1}, "Cover the tower's range in a dense rainforest for 5 waves, slowing all enemies' move and attack speed by ", {0.5, 0.85, 1, 1}, levelingInfo[4].density[player.abilities.rainforest.level + 1], {1, 1, 1, 1}, "%.\nFirst covering happens at wave 20."},
                event = "Wave",
                guaranteed = true,
                frequency = levelingInfo[4].frequency,
                level = player.abilities.rainforest.level,
                preview = img_ability_preview_rainforest,
                equipped = player.abilities.rainforest.equipped,
                unlocked = player.abilities.rainforest.unlocked,
                menu = player.menu.abilities.rainforest,
                amount = player.abilities.rainforest.amount,
                class = "A",
                nextLevelRequirement = levelingInfo[4].levelRequirements[player.abilities.rainforest.level + 1],
                levelRequirements = levelingInfo[4].levelRequirements
            },
            {
                name = "Magma Touch",
                internalName = "magmaTouch",
                effect = {{1, 1, 1, 1}, "Summon a magma pool in a random position on the screen. Applies a burning effect on any enemy touching it, dealing ", {1, 0.6, 0.15, 1}, levelingInfo[5].damage[player.abilities.magmaTouch.level], {1, 1, 1, 1}, "% damage each second for 4 seconds before disappearing. Maximum of 20 magma pools."},
                event = "Time",
                frequency = levelingInfo[5].frequency[player.abilities.magmaTouch.level + 1],
                level = player.abilities.magmaTouch.level,
                preview = img_ability_preview_magmaTouch,
                equipped = player.abilities.magmaTouch.equipped,
                unlocked = player.abilities.rainforest.unlocked,
                menu = player.menu.abilities.magmaTouch,
                amount = player.abilities.magmaTouch.amount,
                class = "D",
                nextLevelRequirement = levelingInfo[5].levelRequirements[player.abilities.magmaTouch.level + 1],
                levelRequirements = levelingInfo[5].levelRequirements
            }
        }

        abilityClasses = {
            "D", "C", "B", "A"
        }
        abilityClassProbabilities = {
            D = 60,
            C = 25,
            B = 10,
            A = 5
        }

        equipSlotRequirements = {
            {difficulty = 1, wave = 100},
            {difficulty = 2, wave = 100},
            {difficulty = 2, wave = 200},
            {difficulty = 3, wave = 50},
            {difficulty = 4, wave = 50}
        }
        function abilityFunctions.updateSlotCount()
            player.abilities.maxEquipped = 0
            for i,v in ipairs(equipSlotRequirements) do
                if player.bestWaves["d" .. v.difficulty] >= v.wave then
                    player.abilities.maxEquipped = player.abilities.maxEquipped + 1
                else
                    break
                end
            end
        end
    end

    function abilityFunctions.upgrade(x, y, ability)
        if x >= 700 and x <= 856 and y >= 418 and y <= 458 then
            if ability.menu and ability.unlocked and ability.amount >= ability.levelRequirements[ability.level] and ability.level < #ability.levelRequirements - 1 then
                ability.amount = ability.amount - ability.levelRequirements[ability.level]
                ability.level = ability.level + 1
            end
        end
        return ability.level, ability.amount
    end

    abilityFunctions.updateInternals()
    abilityFunctions.updateSlotCount()

    player.maxGameSpeed = 1

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
        wave = 1,
        gameSpeed = player.maxGameSpeed
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
        waveSkip = 3,
        crystal = 0,
        magmaPool = 0
    }

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
    sentryAlive = false
    centurionAlive = false
end