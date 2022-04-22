BLANK = -1

local BIG_FONT = love.graphics.newFont(64)

local _M = {
    board1 = {
        { 2, 6, BLANK, BLANK, BLANK, 3, BLANK, 1, 5 },
        { 4, 7, BLANK, BLANK, BLANK, BLANK, BLANK, BLANK, 8 },
        { 5, 8, 1, BLANK, BLANK, 4, 7, 6, 3 },
        { BLANK, 3, BLANK, 4, 8, 9, BLANK, 7, BLANK },
        { BLANK, BLANK, 6, BLANK, BLANK, 2, 8, 3, BLANK },
        { BLANK, BLANK, 8, 3, 1, BLANK, BLANK, BLANK, BLANK },
        { 6, 9, BLANK, BLANK, BLANK, 8, BLANK, BLANK, 7 },
        { 6, BLANK, BLANK, BLANK, 9, BLANK, 2, BLANK, BLANK },
        { BLANK, 1, BLANK, 5, BLANK, BLANK, BLANK, 9, 6 },
    }
}
_M.__index = _M

function _M:new(board)
    local res = {
        board = {}
    }
    for i, v in pairs(self[board]) do
        res.board[i] = v
    end

    setmetatable(res, _M)
    return res
end

function _M:draw()
    for i, v in pairs(self.board) do
        for k, v in pairs(v) do
            local x = (k - 1) * 111 + 5
            local y = (i - 1) * 111 + 5

            love.graphics.setColor(.75, .75, 50, 1)
            love.graphics.rectangle('fill', x , y, 100, 100)
            
            if v > 0 then
                local font = BIG_FONT
                local w = font:getWidth(v)
                local h = font:getHeight()
                love.graphics.setColor(.5, .0, .0, 1)
                love.graphics.setFont(font)
                love.graphics.print(v, x + (100 - w) / 2, y + (100 - h) / 2)
            end
        end
    end
end

return _M
