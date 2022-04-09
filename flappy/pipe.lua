local _M = {}
_M.__index = _M

local PIPE_IMAGE = love.graphics.newImage('pipe.png')
local PIPE_SCROLL = -60

function _M:new()
    local p = {
        x = VIRTUAL_WIDTH,
        y = math.random(VIRTUAL_HEIGHT / 4,  VIRTUAL_HEIGHT - 10),
        width = PIPE_IMAGE:getWidth(),
    }
    setmetatable(p, self)
    return p
end

function _M:update(dt)
    self.x = self.x + PIPE_SCROLL * dt
end

function _M:render()
    love.graphics.draw(PIPE_IMAGE, math.floor(self.x + 0.5), math.floor(self.y))
end

return _M