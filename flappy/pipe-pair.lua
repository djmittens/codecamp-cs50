local _M = {}
_M.__index = _M

local pipe = require('pipe')

GAP_HEIGHT = 90
PIPE_SCROLL = 60

function _M:new(y)
    local pair = {
        x = VIRTUAL_WIDTH + 32,
        y = y,
        top = pipe:new('top', y),
        bottom = pipe:new('bottom', y + PIPE_HEIGHT + GAP_HEIGHT),
        remove = false
    }
    setmetatable(pair, self)
    return pair
end

function _M:update(dt)
    if self.x > -PIPE_WIDTH then
        self.x = self.x - PIPE_SCROLL * dt
        self.top.x = self.x
        self.bottom.x = self.x
    else
        self.remove = true
    end
end

function _M:render()
    self.top:render()
    self.bottom:render()
end
return _M