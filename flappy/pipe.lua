local _M = {}
_M.__index = _M

PIPE_IMAGE = love.graphics.newImage('pipe.png')
PIPE_HEIGHT = 288
PIPE_WIDTH = 70

function _M:new(orientation, y)
    local p = {
        x = VIRTUAL_WIDTH,
        y = y,
        width = PIPE_IMAGE:getWidth(),
        height = PIPE_HEIGHT,
        orientation = orientation
    }
    setmetatable(p, self)
    return p
end

function _M:update(dt)
end

function _M:render()
    -- love.graphics.draw( drawable, x, y, r, sx, sy, ox, oy, kx, ky )
    if self.orientation == 'top' then 
        love.graphics.draw(PIPE_IMAGE, self.x, self.y + PIPE_HEIGHT, 0, 1, -1)
    else
        love.graphics.draw(PIPE_IMAGE, self.x, self.y, 0, 1, 1)
    end

end

return _M