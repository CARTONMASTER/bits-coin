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
    hold = false
}

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