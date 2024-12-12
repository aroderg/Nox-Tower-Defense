--- Spawn a Spiked Crystal somewhere in the tower's range.
function spawnCrystal()
    crystal = {}
    local cx = 0
    local cy = 0
    while math.dist(960, 540, cx + 11, cy + 11) >= player.tower.range - 16 do
        local cx = love.math.random(0, 1898)
        local cy = love.math.random(0, 1058)
        if math.dist(960, 540, cx + 11, cy + 11) > TOWER_SIZE + 16 and math.dist(960, 540, cx + 11, cy + 11) < player.tower.range - 16 then
            crystal.x = cx
            crystal.y = cy
            break
        end
    end
    crystal.timer_lifespan = 0
    crystal.timer_explosionDuration = 0.25
    crystal.timer_explosion = 0
    crystal.state = "alive"
    table.insert(spikedCrystals, crystal)
end

--- Spawn a Magma Pool somewhere on the screen.
function spawnMagmaPool()
    magmaPool = {}
    local mx = love.math.random(0, 1884)
    local my = love.math.random(0, 1044)
    magmaPool.x = mx
    magmaPool.y = my
    while math.dist(960, 540, mx + 18, my + 18) <= TOWER_SIZE + 18 do
        local mx = love.math.random(0, 1884)
        local my = love.math.random(0, 1044)
        if math.dist(960, 540, mx + 18, my + 18) > TOWER_SIZE + 18 then
            magmaPool.x = mx
            magmaPool.y = my
            break
        end
    end
    table.insert(magmaPools, magmaPool)
end