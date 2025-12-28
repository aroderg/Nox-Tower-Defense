daily = {day = {}, week = {}}

function daily.init()
    local DAILY_CYCLE_DURATION = 24 * 60 * 60 -- 24 HOURS
    local WEEKLY_CYCLE_DURATION = 7 * 24 * 60 * 60 -- 168 HOURS
    local nowTime = socket.gettime()
    daily.day.startTime = nowTime - math.floor(nowTime % DAILY_CYCLE_DURATION)
    daily.day.endTime = daily.day.startTime + DAILY_CYCLE_DURATION
    daily.week.startTime = nowTime - math.floor(nowTime % WEEKLY_CYCLE_DURATION)
    daily.week.endTime = daily.week.startTime + WEEKLY_CYCLE_DURATION
    local trades = {
        {sellCurrency = "token", buyCurrency = "electrum", sellAmount = 100, buyAmount = 25, weight = 1},
        {sellCurrency = "token", buyCurrency = "gold", sellAmount = 80, buyAmount = 50, weight = 1},
        {sellCurrency = "token", buyCurrency = "silver", sellAmount = 50, buyAmount = 16000, weight = 1},
    }
    for i=1,3 do
        player.activeTrades[i] = dropTable.draw(trades)
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