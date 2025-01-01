technical = {}

--- Gets the table length, regardless of the type of indexes.
---@param toCount table Table to search through.
function table.len(toCount)
    local long = 0
    for i in pairs(toCount) do
        long = long + 1
    end
    return long
end