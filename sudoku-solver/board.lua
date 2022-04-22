BLANK = -1

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
            local x = (k - 1) * 100
            local y = (i - 1) * 100

            love.graphics.setColor(x / 255, y / 255, 50, 1)
            love.graphics.rectangle('fill', x , y, 100, 100)
            
            if v > 0 then
                love.graphics.setColor(.5, .5, .5, 1)
                love.graphics.print(v, x, y)
            end
            
            print(x, y)
        end
    end
end

return _M
