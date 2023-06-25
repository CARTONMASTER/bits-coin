love = love

-- settings
local resolution = 15
local linethickness = 3

-- constants
local w, h = love.graphics.getDimensions()
local dimensionsByResolution = w / resolution

-- stock table
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
        price = 50
    }
}

function love.load()
    for i, v in pairs(stockTable) do
        stockTable[i].price = v.price * 10
    end
end

function love.draw()
    for i = 1, #stockTable do
        local v = stockTable[i]
        local nextv = stockTable[math.min(i + 1, #stockTable)]

        if v.price > nextv.price then
            love.graphics.setColor(1,0,0)
        else
            love.graphics.setColor(0,1,0)
        end
        local nextx = i * dimensionsByResolution
        local currentx = (i - 1) * dimensionsByResolution
        local currentprice = v.price
        local nextprice = nextv.price

        if i == #stockTable then
            nextx = currentx
        end

        local x = (currentx + nextx) / 2
        local y = ((h - currentprice) + (h - nextprice)) / 2
        local sx = linethickness
        local sy = math.sqrt((nextx - currentx)^ 2 + (nextprice - currentprice)^ 2)

        local angle = math.atan2(
            ((i * dimensionsByResolution) - (i - 1) * dimensionsByResolution),
            (nextv.price - v.price)
        )

        love.graphics.push()
        love.graphics.translate(x, y)
        love.graphics.rotate(angle)
        love.graphics.rectangle("fill", -sx / 2, -sy / 2, sx, sy)
        love.graphics.pop()
        --love.graphics.line((i - 1) * dimensionsByResolution, h - (v.price * 10), i * dimensionsByResolution, h - (nextv.price * 10))
    end
end