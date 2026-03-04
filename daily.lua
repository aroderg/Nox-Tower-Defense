daily = {day = {}, week = {}}

function daily.init()
    local DAILY_CYCLE_DURATION = 24 * 60 * 60 --24 HOURS
    local WEEKLY_CYCLE_DURATION = 7 * 24 * 60 * 60 --168 HOURS
    local WEEK_OFFSET = 3 * DAILY_CYCLE_DURATION 
    local nowTime = socket.gettime()
    daily.day.startTime = math.floor(nowTime / DAILY_CYCLE_DURATION) * DAILY_CYCLE_DURATION
    daily.day.endTime = daily.day.startTime + DAILY_CYCLE_DURATION
    local adjustedTime = nowTime - WEEK_OFFSET
    daily.week.startTime = (math.floor(adjustedTime / WEEKLY_CYCLE_DURATION) * WEEKLY_CYCLE_DURATION) + WEEK_OFFSET
    daily.week.endTime = daily.week.startTime + WEEKLY_CYCLE_DURATION

    local trades = {
        {sellCurrency = "token", buyCurrency = "electrum", sellAmount = 100, buyAmount = 25, weight = 1, active = true},
        {sellCurrency = "token", buyCurrency = "gold", sellAmount = 80, buyAmount = 50, weight = 1, active = true},
        {sellCurrency = "token", buyCurrency = "silver", sellAmount = 50, buyAmount = 16000, weight = 1, active = true},
    }
    love.math.setRandomSeed(nowTime - math.floor(nowTime % DAILY_CYCLE_DURATION))
    for i=1,3 do
        local trade = dropTable.draw(trades)
        table.insert(player.activeDailyTrades, technical.copyTable(trade))
        if player.tradesBought.daily[i] then
            player.activeDailyTrades[i].active = false
        end
    end
    for i=1,4 do
        local trade = dropTable.draw(trades)
        table.insert(player.activeWeeklyTrades, technical.copyTable(trade))
        if player.tradesBought.weekly[i] then
            player.activeWeeklyTrades[i].active = false
        end
    end
end

function daily.update(dt)
    local currentTime = socket.gettime()
    if currentTime >= daily.day.endTime then
        daily.init()
    elseif currentTime >= daily.week.endTime then
        daily.init()
    end
end