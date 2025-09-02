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