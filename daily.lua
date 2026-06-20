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
        {sellCurrency = "token", buyCurrency = "electrum", sellAmount = 100, buyAmount = 15, weight = 1, active = true},
        {sellCurrency = "token", buyCurrency = "gold", sellAmount = 80, buyAmount = 40, weight = 1, active = true},
        {sellCurrency = "token", buyCurrency = "silver", sellAmount = 50, buyAmount = 16000, weight = 1, active = true},
        {sellCurrency = "token", buyCurrency = "electrum", sellAmount = 80, buyAmount = 10, weight = 2, active = true},
        {sellCurrency = "token", buyCurrency = "gold", sellAmount = 15, buyAmount = 6, weight = 2, active = true},
        {sellCurrency = "token", buyCurrency = "silver", sellAmount = 30, buyAmount = 9000, weight = 2, active = true},
    }
    love.math.setRandomSeed(nowTime - math.floor(nowTime % DAILY_CYCLE_DURATION))
    for i=1,3 do
        local trade = dropTable.draw(trades)
        table.insert(player.activeDailyTrades, technical.copyTable(trade))
        if player.tradesBought.daily[i] then
            player.activeDailyTrades[i].active = false
        end
    end
    love.math.setRandomSeed(nowTime - math.floor(nowTime % WEEKLY_CYCLE_DURATION))
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
        daily.triggerUpgrades()
    elseif currentTime >= daily.week.endTime then
        daily.init()
    end
end

function daily.triggerUpgrades()
    if math.floor(socket.gettime() / (24 * 60 * 60)) * (24 * 60 * 60) ~= player.tradesBought.dailySeed then
        if player.upgrades.jade.jadePerLogin.level == 2 then
            player.misc.jadeBuffer = player.misc.jadeBuffer + 1 * player.upgrades.jade.jadeBonus.value
            player.currencies.currentJade = player.currencies.currentJade + math.floor(player.misc.jadeBuffer)
            player.misc.jadeBuffer = player.misc.jadeBuffer - math.floor(player.misc.jadeBuffer)
        end
        local tradesForAutobroker = {}
        if player.upgrades.jade.autobroker.level == 2 then
            for i=1,3 do
                if player.activeDailyTrades[i].active then
                    table.insert(tradesForAutobroker, i)
                end
            end
            if #tradesForAutobroker > 0 then
                love.math.setRandomSeed(socket.gettime())
                local randomIndex = love.math.random(1, #tradesForAutobroker)
                local tradeIndex = tradesForAutobroker[randomIndex]
                local trade = player.activeDailyTrades[tradeIndex]
                if player.currencies.currentTokens >= trade.sellAmount then
                    trade.active = false
                    player.misc.jadeBuffer = player.misc.jadeBuffer + 1 * player.upgrades.jade.jadeBonus.value
                    if not player.activeDailyTrades[1].active and not player.activeDailyTrades[2].active and not player.activeDailyTrades[3].active then
                        player.misc.jadeBuffer = player.misc.jadeBuffer + 3 * player.upgrades.jade.jadeBonus.value
                    end
                    player.currencies.currentJade = player.currencies.currentJade + math.floor(player.misc.jadeBuffer)
                    player.misc.jadeBuffer = player.misc.jadeBuffer - math.floor(player.misc.jadeBuffer)
                    player.currencies.currentTokens = player.currencies.currentTokens - trade.sellAmount
                    player.currencies["current" .. string.gsub(trade.buyCurrency, "^%l", string.upper)] = player.currencies["current" .. string.gsub(trade.buyCurrency, "^%l", string.upper)] + trade.buyAmount
                end
            end
        end
    end
end