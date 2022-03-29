local paddle = {}
function paddle:new(x, y, width, height)
    local res = {
        x = x,
        y = y,
        dy = 0,
        width = width,
        height = height
    }
    setmetatable(res, {__index=paddle})
    return res
end

function paddle:update(dt)
    if self.dy < 0 then
        self.y = math.max(0, self.y + self.dy * dt)
    else
        self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + self.dy * dt)
    end
    self.dy = 0
end

function paddle:draw()
    love.graphics.rectangle('fill',self.x, self.y, self.width, self.height)
end

return paddle