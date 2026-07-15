technical = {}

--- Gets the table length, regardless of the type of indexes.
---@param toCount table Table to search through.
function table.len(toCount)
    local _ = 0
    for i in pairs(toCount) do
        _ = _ + 1
    end
    return _
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