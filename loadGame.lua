local SAVE_FILE = "SAVEFILE.sav"
local BACKUP_FILE = "SAVEFILE.sav.bak"

-- Standard recursive deep merge to safely fill missing keys from template into target
function technical.deepMerge(target, template)
    if type(target) ~= "table" then return lume.clone(template) end
    if type(template) ~= "table" then return target end

    for k, v in pairs(template) do
        if target[k] == nil then
            if type(v) == "table" then
                target[k] = technical.deepMerge({}, v)
            else
                target[k] = v
            end
        elseif type(v) == "table" and type(target[k]) == "table" then
            technical.deepMerge(target[k], v)
        end
    end
    return target
end

function getUsername()
    return os.getenv("USERNAME") or os.getenv("USER") or "playername"
end

local function verifyAndDeserialize(fileContent)
    if not fileContent or fileContent == "nil" or #fileContent == 0 then
        return nil
    end

    -- Strip old #CHECKSUM: header if upgrading from legacy saves
    local legacyPayload = fileContent:match("^#CHECKSUM:%w+\n(.*)$")
    if legacyPayload then
        fileContent = legacyPayload
    end

    local success, data = pcall(lume.deserialize, fileContent)
    if success and type(data) == "table" then
        return data
    end
    return nil
end

-- Safely load save data with backup recovery fallback
local function readSaveData()
    if love.filesystem.getInfo(SAVE_FILE) then
        local content = love.filesystem.read(SAVE_FILE)
        local data = verifyAndDeserialize(content)
        if data then return data end
        print("[Save System] Main save corrupt. Attempting backup load...")
    end

    if love.filesystem.getInfo(BACKUP_FILE) then
        local content = love.filesystem.read(BACKUP_FILE)
        local data = verifyAndDeserialize(content)
        if data then 
            print("[Save System] Backup save successfully loaded!")
            return data 
        end
    end

    return nil
end

function loadGame()
    -- Initialize default player state structure
    defaultPlayerState = {
        saveVersion = 10202,
        activeDailyTrades = {},
        activeWeeklyTrades = {},
        paused = false,
        location = "round",
        cooldowns = {electrum = 24, tokens = 600, abilityAssembly_min = 400, abilityAssembly_max = 800, abilityAssembly_current = 600},
        timers = {electrum = 0, tokens = 600, abilityAssembly = 0},
        canClaim = {tokens = true, electrum = true, ability = true},
        currencies = {currentSilver = 0, currentGold = 0, currentElectrum = 0, currentTokens = 0, currentJade = 0},
        idleGains = {silver = 0, gold = 0},
        idleTimeCap = 21600,
        idleTime = 0,
        timeModified = socket.gettime(),
        storedGains = {silver = 0, gold = 0},

        upgrades = {
            unlocks = {
                crit = false, range = false, clusterFire = false,
                resistance = false, shield = false, meteor = false, lifesteal = false,
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
                attackDamage = {level = 1, cost = 20, value = 1},
                attackSpeed = {level = 1, cost = 20, value = 1},
                health = {level = 1, cost = 20, value = 1},
                regeneration = {level = 1, cost = 20, value = 1},
                abilityChance = {level = 1, cost = 20, value = 1},
                abilityCooldown = {level = 1, cost = 20, value = 1},
            },
            jade = {
                jadeBonus = {level = 1, cost = 1, value = 1},
                jadePerLogin = {level = 1, cost = 1, value = 1},
                autobroker = {level = 1, cost = 1, value = 1},
                silverGain = {level = 1, cost = 1, value = 1},
                silverEquivalent = {level = 1, cost = 1, value = 1}
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
                enemiesKilled = 0, damageDealt = 0, silverEarned = 0, goldEarned = 0,
                wavesSkipped = 0, projectilesFired = 0, wavesBeaten = 0,
                upgradesAcquired = {science = 0, nexus = 0, jade = 0},
                idleGains = {silverCollected = 0, goldCollected = 0},
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
            maxEquipped = 1
        },
        misc = {abilityAssembling = false, tokensRefundable = true, theme = "polaris", silverBuffer = 0, jadeBuffer = 0},
        tradesBought = {daily = {false, false, false}, weekly = {false, false, false, false}, dailySeed = 0, weeklySeed = 0}
    }

    -- Populate ability defaults dynamically
    local defaultAbilityNames = {"spikedCrystals", "scatterFire", "burstFire", "iceDomain", "magmaTouch", "lightningOrb", "JerelosBlessing", "berserkerKit", "sniperKit", "tankKit", "supercritical", "disruptWave", "enemyBalancing", "waveDash"}
    for _, name in ipairs(defaultAbilityNames) do
        defaultPlayerState.abilities[name] = {unlocked = false, level = 0, equipped = false, amount = 0}
    end

    -- 1. Read & deserialize raw save data
    local loadedData = readSaveData() or {}

    -- 2. Safely merge loaded state on top of default template (fills missing tables/keys automatically)
    player = technical.deepMerge(loadedData, defaultPlayerState)

    -- 3. Calculate dynamic runtime values & state adjustments
    player.location = "hub"
    player.canClaim = {
        tokens = (player.timers.tokens <= 0),
        electrum = (player.timers.electrum <= 0),
        ability = (player.timers.abilityAssembly >= player.cooldowns.abilityAssembly_current)
    }

    -- Idle time calculations
    local now = socket.gettime()
    local elapsedTime = math.max(0, now - (player.timeModified or now))
    local oldIdleTime = player.idleTime or 0
    player.idleTime = math.min(oldIdleTime + elapsedTime, player.idleTimeCap)
    player.timeModified = now

    local minutesPassed = math.floor(player.idleTime / 60) - math.floor(oldIdleTime / 60)
    if minutesPassed > 0 then
        player.storedGains.silver = player.storedGains.silver + (player.idleGains.silver * minutesPassed)
        player.storedGains.gold = player.storedGains.gold + (player.idleGains.gold * minutesPassed)
    end

    -- Nexus values and costs recalculation
    local nexus = player.upgrades.nexus
    for _, upgrade in pairs(nexus) do
        if type(upgrade) == "table" and upgrade.level then
            upgrade.cost = 20 + ((upgrade.level * (upgrade.level - 1)) / 2) * 5
        end
    end
    nexus.attackDamage.value = math.min(1 + (nexus.attackDamage.level - 1) * 0.10, 5)
    nexus.attackSpeed.value = math.min(1 + (nexus.attackSpeed.level - 1) * 0.04, 2)
    nexus.health.value = math.min(1 + (nexus.health.level - 1) * 0.10, 5)
    nexus.regeneration.value = math.min(1 + (nexus.regeneration.level - 1) * 0.10, 5)
    nexus.abilityChance.value = math.min(1 + (nexus.abilityChance.level - 1) * 0.02, 1.8)
    nexus.abilityCooldown.value = math.min(1 + (nexus.abilityCooldown.level - 1) * 0.012, 1.36)

    -- Modifier values recalculation
    local mods = player.modifiers
    mods.waveSkip.cost = mods.waveSkip.unlocked and ((mods.waveSkip.level * (mods.waveSkip.level - 1)) / 2 + 4) or 10
    mods.waveSkip.value = mods.waveSkip.unlocked and math.min(4 * mods.waveSkip.level, 40) or 0
    mods.hyperloop.cost = mods.hyperloop.unlocked and (mods.hyperloop.level^2 - 2 * mods.hyperloop.level + 11) or 15
    mods.hyperloop.value = mods.hyperloop.unlocked and math.min(2 + 8 * mods.hyperloop.level, 90) or 0
    mods.acceleration.cost = mods.acceleration.unlocked and math.floor(5 * (2^(mods.acceleration.level))^0.21) or 15
    mods.acceleration.value = mods.acceleration.unlocked and math.min(0.04 * mods.acceleration.level, 0.8) or 0

    -- Define layout metadata for science categories and index positions
    local SCIENCE_MAPPING = {
        ATK = {
            "attackDamage", "attackSpeed", "critChance", "critFactor",
            "range", "clusterFireChance", "clusterFireTargets", "clusterFireEfficiency"
        },
        VIT = {
            "health", "regeneration", "resistance", "shieldCooldown",
            "shieldDuration", "meteorAmount", "meteorRPM", "lifestealChance", "lifestealPercent"
        },
        UTL = {
            "copperPerWave", "silverPerWave", "copperBonus", "silverBonus"
        }
    }

    -- Recalculate costs dynamically
    for category, upgrades in pairs(SCIENCE_MAPPING) do
        for index, upgradeKey in ipairs(upgrades) do
            local upgrade = player.upgrades.science[upgradeKey]
            if upgrade then
                local formulae = upgradeModuleFuncs.reloadFormulae(upgrade.level)
                upgrade.cost = formulae["science"][category][index][1]
            end
        end
    end

    player.difficulty = {
        difficulty = 1,
        unlocks = {
            d1 = true,
            d2 = player.bestWaves.d1 > 99,
            d3 = player.bestWaves.d2 > 99,
            d4 = player.bestWaves.d3 > 99,
            d5 = player.bestWaves.d4 > 99
        }
    }

    player.menu = {abilities = {}, saveStats = false, rolledAbilityDisplay = false, debugInfo = false, shopSection = "Trading"}

    abilityFunctions.updateLeveling()
    abilityFunctions.updateInternals()
    abilityFunctions.updateSlotCount()

    player.maxGameSpeed = 1 + player.modifiers.acceleration.value
    player.idleGains.silver, player.idleGains.gold = reloadIdleGains()

    accentColors = {
        main = {buttons = {0.1, 0.15, 0.5, 1}, buttonOutlines = {0.3, 0.75, 0.85, 1}, towerInfo = {0.106, 0.11, 0.22, 1}, upgradeModule = {0, 0.1, 0.2}, menus = {0.15, 0, 0.3, 1}, background = love.graphics.newImage("assets/background.png")},
        stellar = {buttons = {0.1, 0.15, 0.5, 1}, buttonOutlines = {0.3, 0.75, 0.85, 1}, towerInfo = {0.106, 0.11, 0.22, 1}, upgradeModule = {0, 0.1, 0.2}, menus = {0.15, 0, 0.3, 1}, background = love.graphics.newImage("assets/background_stellar.png")},
        eclipse = {buttons = {0.33, 0, 0, 1}, buttonOutlines = {0.81, 0, 0, 1}, towerInfo = {0.13, 0.05, 0, 1}, upgradeModule = {0.16, 0.06, 0}, menus = {0.12, 0.05, 0, 1}, background = love.graphics.newImage("assets/background_eclipse.png")},
        nova = {buttons = {0.19, 0.32, 0.33, 1}, buttonOutlines = {0.29, 0.71, 0.75, 1}, towerInfo = {0, 0.004, 0.1}, upgradeModule = {0.04, 0.07, 0.07}, menus = {0.09, 0.15, 0.15, 1}, background = love.graphics.newImage("assets/background_nova.png")},
        aurora = {buttons = {0.28, 0.1, 0.5, 1}, buttonOutlines = {0.83, 0.5, 1, 1}, towerInfo = {0.27, 0, 0.33}, upgradeModule = {0.13, 0, 0.2}, menus = {0.16, 0, 0.19, 1}, background = love.graphics.newImage("assets/background_aurora.png")},
        polaris = {buttons = {0.20, 0, 0.38, 1}, buttonOutlines = {0.62, 0.27, 0.79, 1}, towerInfo = {0.14, 0, 0.19}, upgradeModule = {0.1, 0, 0.15}, menus = {0.08, 0.04, 0.11, 1}, background = love.graphics.newImage("assets/background_polaris.png")}
    }

    player.debug = {updateTimer = 0, updateInterval = 1, memUsage = 0, currentUpdates = 0, UPS = 0}
    player.username = getUsername()
end

function resetRoundValues()
    player.menu.paused = false
    player.menu.settings = false
    player.menu.upgrades = false
    player.menu.gameplayInfo = false
    player.menu.battleStats = false
    player.menu.saveStats = false
    player.menu.enemyInfo = false

    player.currencies.currentCopper = 0

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

    updateTowerStats()

    gameplay = {difficulty = player.difficulty.difficulty, wave = 1, gameSpeed = player.maxGameSpeed}
    misc = {
        copperBuffer = 0,
        silverBuffer = 0,
        copperAtStart = player.currencies.currentCopper,
        silverAtStart = player.currencies.currentSilver,
        goldAtStart = player.currencies.currentGold,
        JerelosBlessingVisuals = {vines = love.math.random(1, 4), waves = love.math.random(1, 4)},
        copperAdded = 0,
        silverAdded = 0
    }
    
    player.stats.battle = {
        gameTime = 0, realTime = 0, enemiesKilled = 0, damageTaken = 0, damageDealt = 0,
        copperEarned = 0, silverEarned = 0, shieldDamageAbsorb = 0, wavesSkipped = 0,
        projectilesFired = 0, upgradesAcquired = 0, goldEarned = 0,
        clusterFire = {triggered = 0}, lifesteal = {triggered = 0, healed = 0},
        spikedCrystals = {enemiesKilled = 0, damageDealt = 0, spawned = 0},
        scatterFire = {damageDealt = 0, triggered = 0}, burstFire = {damageDealt = 0, triggered = 0},
        iceDomain = {triggered = 0}, magmaTouch = {enemiesKilled = 0, damageDealt = 0, spawned = 0},
        lightningOrb = {enemiesKilled = 0, damageDealt = 0, spawned = 0},
        JerelosBlessing = {triggered = 0, healthRegenerated = 0},
        supercritical = {triggered = 0, damageDealt = 0},
        disruptWave = {triggered = 0, damageDealt = 0, enemiesKilled = 0}
    }
    player.stats.wave = {enemiesKilled = 0}
    enemyAttributes = {}

    enemyFuncs.updateEnemyStats(gameplay.difficulty, gameplay.wave)

    timers = {projectile = 0, enemy = 0, nextWave = 0, shieldActivation = 0, shieldActive = 0, waveSkip = 3, copperAdd = 2, silverAdd = 2, crystal = 0, magmaPool = 0, lightningOrb = 0, disruptWave = 0}

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
    for i = 1, player.tower.meteorAmount do
        createMeteor(((i - 1) * (2 * math.pi) / player.tower.meteorAmount) - 0.5 * math.pi)
    end
    spikedCrystals = {}
    magmaPools = {}
    lightningOrbs = {}
    lightningOrb_lasers = {}
    sentryAlive = false
    centurionAlive = false

    upgradeModuleFuncs.load()
end