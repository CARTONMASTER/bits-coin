love = love
camera = require("camera")

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
    }
}

-- region

function love.load()
    for i, v in pairs(stockTable) do
        stockTable[i].price = v.price * 10
    end
end

function love.update()
    camera.update()
end

function love.wheelmoved(a, b)
    camera.wheelmoved(a, b)
end

function love.mousepressed(a, b, c)
    camera.mousepressed(a, b, c)
end

function love.mousereleased(a, b, c)
    camera.mousereleased(a, b, c)
end

function love.keypressed(key)
    camera.keypressed(key)

    if key == "r" then
        table.insert(stockTable, {
            price = stockTable[#stockTable].price + love.math.random(-20, 50)
        })
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

        local editedDimensions = dimensionsByResolution * camera.scroll.y

        local nextx = i * editedDimensions
        local currentx = (i - 1) * editedDimensions
        local currentprice = v.price * camera.scroll.y
        local nextprice = nextv.price * camera.scroll.y

        if i == #stockTable then
            nextx = currentx
        end

        local x = (currentx + nextx) / 2
        local y = ((h - currentprice) + (h - nextprice)) / 2
        local sx = linethickness * camera.scroll.y
        local sy = math.sqrt((nextx - currentx)^ 2 + (nextprice - currentprice)^ 2)

        local angle = math.atan2(
            ((i * editedDimensions) - (i - 1) * editedDimensions),
            (nextprice - currentprice)
        )

        love.graphics.push()
        love.graphics.translate(x - camera.offset.x - camera.pre_offset.x, y - camera.offset.y - camera.pre_offset.y)
        love.graphics.rotate(angle)
        love.graphics.rectangle("fill", -sx / 2, -sy / 2, sx, sy)
        love.graphics.pop()
        --love.graphics.line((i - 1) * dimensionsByResolution, h - (v.price * 10), i * dimensionsByResolution, h - (nextv.price * 10))
    end
end