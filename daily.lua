daily = {}

function daily.init()
    local DAILY_CYCLE_DURATION = 22 * 60 * 60 -- 22 HOURS
    daily.startTime = math.floor(socket.gettime() / DAILY_CYCLE_DURATION) * DAILY_CYCLE_DURATION
    daily.endTime = daily.startTime + DAILY_CYCLE_DURATION
end

function daily.update(dt)
    local currentTime = socket.gettime()
    if currentTime >= daily.endTime then
        daily.init()
    end
end