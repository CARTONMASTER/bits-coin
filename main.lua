local w, h = love.graphics.getDimensions()

local RESOLUTION = 15

local dimensionsByResolution = w / RESOLUTION

local stockTable = {
    {
        price = 1
    },
    { 
        price = 3
    },
    {
        price = 1.5
    },
    {
        price = 5
    },
    { 
        price = 16
    },
    {
        price = 14
    }
}

function love.draw()
    local i2 = 2
    for i = 1, #stockTable do
        local v = stockTable[i]
        local nextv = stockTable[math.min(i + 1, #stockTable)]

        if v.price > nextv.price then
            love.graphics.setColor(1,0,0)
        else
            love.graphics.setColor(0,1,0)
        end

        love.graphics.line((i - 1) * dimensionsByResolution, h - (v.price * 10), i * dimensionsByResolution, h - (nextv.price * 10))
    end
end