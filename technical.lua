technical = {}

--- Gets the table length, regardless of the type of indexes.
---@param toCount table Table to search through.
function table.len(toCount)
    if type(toCount) ~= "table" then return 0 end
    local count = 0
    for _ in pairs(toCount) do
        count = count + 1
    end
    return count
end

function technical.deepMerge(default, saved)
    for i,v in pairs(saved) do
        if type(v) == "table" and type(default[i]) == "table" then
            technical.deepMerge(default[i], v)
        else
            default[i] = v
        end
    end
end

function technical.findItemInList(item, list)
    local itemFound = false
    for _,v in ipairs(list) do
        if v == item then
            itemFound = true
        end
    end
    return itemFound
end

function technical.copyTable(toCopy)
    local new = {}
    for k, v in pairs(toCopy) do
        new[k] = v
    end
    return new
end

function technical.loggedString(String)
    local now = socket.gettime()
    local curTime = {s=math.floor(now),ms=math.floor((now % 1) * 1000)}
    local formatted = os.date("%X", curTime.s) .. string.format(".%03d",curTime.ms)
    return "[" .. formatted .. "]" .. " " .. String;
end

function technical.formatTime(seconds)
    local totalSeconds = math.floor(seconds or 0)
    local m = math.floor(totalSeconds / 60)
    local s = totalSeconds % 60
    if s > 0 then
        return string.format("%dm %ds", m, s)
    else
        return string.format("%dm", m)
    end
end