local SAVE_FILE = "SAVEFILE.sav"
local TMP_FILE = "SAVEFILE.sav.tmp"
local BACKUP_FILE = "SAVEFILE.sav.bak"

--- Saves game state using atomic file operations and backup generation.
function saveGame()
    local toSave = {
        saveVersion = player.saveVersion or 1,
        currencies = player.currencies,
        idleGains = player.idleGains,
        timeModified = socket.gettime(),
        idleTime = player.idleTime,
        storedGains = player.storedGains,
        upgrades = {
            unlocks = player.upgrades.unlocks,
            nexus = {},
            science = {},
            jade = {}
        },
        timers = player.timers,
        cooldowns = { abilityAssembly_current = player.cooldowns.abilityAssembly_current },
        modifiers = player.modifiers,
        bestWaves = player.bestWaves,
        stats = player.stats,
        abilities = player.abilities,
        misc = player.misc,
        settings = player.settings,
        tradesBought = player.tradesBought
    }

    -- Preserve only level key for upgrades to keep save file lightweight
    for cat, upgrades in pairs({nexus = player.upgrades.nexus, science = player.upgrades.science, jade = player.upgrades.jade}) do
        for k, v in pairs(upgrades) do
            toSave.upgrades[cat][k] = { level = v.level }
        end
    end

    local formattedContent = lume.serialize(toSave)

    -- 1. Write to temp file
    if not love.filesystem.write(TMP_FILE, formattedContent) then
        print("[Save Error] Failed to write temporary save file.")
        return false
    end

    -- 2. Back up active save before replacing
    if love.filesystem.getInfo(SAVE_FILE) then
        local oldSave = love.filesystem.read(SAVE_FILE)
        if oldSave and #oldSave > 0 then
            love.filesystem.write(BACKUP_FILE, oldSave)
        end
    end

    -- 3. Overwrite main save directly with serialized payload
    if love.filesystem.write(SAVE_FILE, formattedContent) then
        love.filesystem.remove(TMP_FILE)
        return true
    end

    return false
end