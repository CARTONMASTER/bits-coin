local camera = {
    offset = {
        x = 0, y = 0
    },
    pre_offset = {
        x = 0, y = 0
    },
    start_pre_offset = {
        x = 0, y = 0
    },
    hold = false,
    scroll = {
        x = 1, y = 1
    }
}

local w, h = love.graphics.getDimensions()

function camera.mousereleased(x, y, button)
    if button == 2 then
        camera.hold = false
        camera.offset = {
            x = camera.offset.x + camera.pre_offset.x,
            y = camera.offset.y + camera.pre_offset.y
        }
        camera.start_pre_offset = {
            x = 0, y = 0
        }
        camera.pre_offset = {
            x = 0, y = 0
        }
    end
end

function camera.mousepressed(x, y, button)
    if button == 2 then
        camera.hold = true
        camera.start_pre_offset = {
            x = x, y = y
        }
    end
end

function camera.wheelmoved(x, y)
    print(y)

    --[[camera.offset = {
        x = camera.offset.x + w / 2, y = camera.offset.y * h / 2
    }]]

    camera.scroll = {
        x = math.min(math.max(camera.scroll.x + x, 1), 15), y = math.min(math.max(camera.scroll.y + y, 1), 15)
    }
end

function camera.keypressed(key)
    if key == "c" then
        camera.offset = {
            x = 0, y = 0
        }
    end
end

function camera.update()
    if camera.hold == true then
        local x, y = love.mouse.getPosition()

        camera.pre_offset = {
            x = camera.start_pre_offset.x - x,
            y = camera.start_pre_offset.y - y,
        }
    end
end

camera.__index = camera
return camera