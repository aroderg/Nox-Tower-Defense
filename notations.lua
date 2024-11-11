notations = {
    numbers = {
        kmbt = {"K", "M", "B", "T", "Qa", "Qi", "Sx", "Sp", "Oc", "No", "Dc"},
        e = {"e3", "e6", "e9", "e12", "e15", "e18", "e21", "e24", "e27", "e30", "e33"},
        alphabet = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k"},
    },
    kmbt = {},
    e = {},
    alphabet = {}
}

function notations.getLetterForNumber(x)
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

function notations.formatLargeNumber(x)
    if x >= 1000 then
        return x / 1000^math.floor(math.log(x, 10) / 3)
    else
        return x
    end
end

function notations.convertToLetterNotation(x, precision)
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