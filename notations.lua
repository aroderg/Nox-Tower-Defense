notations = {
    numbers = {
        kmbt = {"K", "M", "B", "T", "Qa", "Qi", "Sx", "Sp", "Oc", "No", "Dc"},
        e = {"e3", "e6", "e9", "e12", "e15", "e18", "e21", "e24", "e27", "e30", "e33"},
        alphabet = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K"},
    },
    kmbt = {},
    e = {},
    alphabet = {}
}

--- Find an entry that matches the number's logarithm and the player's settings.
---@param x number The number to append a notation tag to.
function notations.getLetterForNumber(x)
    local x = x or 0
    if x >= 1000 then
        if player.settings.notation == "kmbt" then
            return notations.numbers.kmbt[math.floor(math.log(x, 10) / 3)]
        elseif player.settings.notation == "e" then
            return notations.numbers.e[math.floor(math.log(x, 10) / 3)]
        elseif player.settings.notation == "alphabet" then
            return notations.numbers.alphabet[math.floor(math.log(x, 10) / 3)]
        end
    else
        return nil
    end
end

--- Formats the number to be in range from 1 to 1000 (not inclusive).
---@param x number The number to be converted.
function notations.formatLargeNumber(x)
    local x = x or 0
    if x >= 1000 then
        return x / 1000^math.floor(math.log(x, 10) / 3)
    else
        return x
    end
end

--- Converts a nummber from the straightforward look (ex. 1616805) to a standard form (ex. 1.61M or 1.61e6).
---@param x number The number to be converted.
---@param precision string Amount of precision the resulting number will have.
function notations.convertToLetterNotation(x, precision)
    local x = x or 0
    local precision = precision or "brief"
    if x <= 1000 then
        if precision == "precise2" then
            return string.format("%.2f", notations.formatLargeNumber(x))
        elseif precision == "precise" then
            return string.format("%.1f", notations.formatLargeNumber(x))
        elseif precision == "brief" then
            return string.format("%d", notations.formatLargeNumber(x))
        end
    else
        return string.format("%.2f%s", notations.formatLargeNumber(x), notations.getLetterForNumber(x))
    end
end