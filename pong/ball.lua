local ball = {}

function ball:new(x, y, size)
    local res = {
        -- position
        x = x,
        y = y,
        -- velocity
        d_x = math.random(2) == 1 and 100 or -100,
        d_y = math.random(-50, 50),
        size = size,
    }
    setmetatable(res, {__index = ball})
    return res
end

function ball:update(dt, paddles)
    self.x = self.x + self.d_x * dt
    self.y = self.y + self.d_y * dt
    --print(dt .. tostring(paddles))
    if(self.y < 0 or self.y > VIRTUAL_HEIGHT - self.size) then
        self.d_y = -self.d_y
        self.y = math.min(VIRTUAL_HEIGHT - self.size, math.max(0, self.y))
    end
    for _, p in pairs(paddles) do
        if(self:collides(p)) then
            -- also snap it to paddle
            self:deflect(p)
        end
    end
end

function ball:draw()
    if(self.size == nil) then
        print(self.x)
        print(self.size)
        -- debug.debug()
    else
        love.graphics.circle('fill', self.x, self.y, self.size)
    end
end

function ball:collides(paddle)
    if(self.x > paddle.x + paddle.width or paddle.x > self.x + self.size) then
        return false
    end
    if(self.y > paddle.y + paddle.height or paddle.y > self.y + self.size) then
        return false
    end
    return true
end

function ball:deflect(paddle)
    self.d_x = -self.d_x * 1.03 -- increase speed by a small factor
    if(self.x > VIRTUAL_WIDTH / 2) then
        -- right paddle
        self.x = paddle.x - self.size
        self.d_y = -math.random(10, 150)
    else
        -- left paddle
        self.x = paddle.x + paddle.width
        self.d_y = math.random(10, 150)
    end
end

return ball