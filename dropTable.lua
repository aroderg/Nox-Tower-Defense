dropTable = {}
function dropTable.draw(tbl)
    local totalItemWeight = 0
    for _,v in pairs(tbl) do
        totalItemWeight = totalItemWeight + v.weight
    end
    local weightLeftToDraw = love.math.random(0, totalItemWeight)
    for _,v in pairs(tbl) do
        weightLeftToDraw = weightLeftToDraw - v.weight
        if weightLeftToDraw <= 0 then
            return v
        end
    end
end