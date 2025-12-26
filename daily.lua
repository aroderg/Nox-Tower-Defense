daily = {day = {}, week = {}}

function daily.init()
    local DAILY_CYCLE_DURATION = 24 * 60 * 60 -- 24 HOURS
    local WEEKLY_CYCLE_DURATION = 7 * 24 * 60 * 60 -- 168 HOURS
    daily.day.startTime = math.floor(socket.gettime() / DAILY_CYCLE_DURATION) * DAILY_CYCLE_DURATION
    daily.day.endTime = daily.day.startTime + DAILY_CYCLE_DURATION
    daily.week.startTime = math.floor(socket.gettime() / WEEKLY_CYCLE_DURATION) * WEEKLY_CYCLE_DURATION
    daily.week.endTime = daily.week.startTime + WEEKLY_CYCLE_DURATION
end

function daily.update(dt)
    local currentTime = socket.gettime()
    if currentTime >= daily.day.endTime then
        daily.init()
    elseif currentTime >= daily.week.endTime then
        daily.init()
    end
end