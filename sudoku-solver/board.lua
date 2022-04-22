BLANK = -1

local BIG_FONT = love.graphics.newFont(64)
local BOARD_SIZE = 9 * 9

local _M = {
    board1 = {
        2, 6, BLANK, BLANK, BLANK, 3, BLANK, 1, 5 ,
        4, 7, BLANK, BLANK, BLANK, BLANK, BLANK, BLANK, 8 ,
        5, 8, 1, BLANK, BLANK, 4, 7, 6, 3,
        BLANK, 3, BLANK, 4, 8, 9, BLANK, 7, BLANK ,
        BLANK, BLANK, 6, BLANK, BLANK, 2, 8, 3, BLANK ,
        BLANK, BLANK, 8, 3, 1, BLANK, BLANK, BLANK, BLANK ,
        6, 9, BLANK, BLANK, BLANK, 8, BLANK, BLANK, 7 ,
        6, BLANK, BLANK, BLANK, 9, BLANK, 2, BLANK, BLANK ,
        BLANK, 1, BLANK, 5, BLANK, BLANK, BLANK, 9, 6 ,
    }
}
_M.__index = _M

local function unwrap(i, b)
    local res = {}

    local offset_x = i % 9
    local offset_y = math.floor(i / 9)

    for y = 0,2,1 do
        for x = 0,2,1 do
            table.insert(res, b[(offset_y + y) * 9 + (offset_x + x)  + 1])
            -- print(offset_x,  x)
        end
    end
    
    return res
end

function _M:new(board)
    local res = {
        board = {},
        _draw = {}
    }

    for i, v in pairs(self[board]) do
        res.board[i] = v
    end

    for k = 0,2,1 do
        for j = 0,2,1 do
            table.insert(res._draw, unwrap(k * 9 * 3  + (j * 3), self[board]))
        end
    end

    setmetatable(res, _M)
    return res
end

function _M:draw_squares(x, y, size, board)

    if size < 10 then return end
    for i, v in pairs(board) do
        i = i - 1
        local j = (i % 3) * size + x
        local k = math.floor(i / 3) * size + y
        -- draw background
        love.graphics.setColor(j / 1000, k / 1000, .5, 1)
        love.graphics.rectangle('fill', j, k, size, size)

        -- if v > BLANK then 
        if type(v) == 'table' then 
            _M:draw_squares((j) + 5, (k) + 5, math.floor(size / 3) - 4, v)
            -- print(v)
        elseif v > BLANK then
            local w = BIG_FONT:getWidth(v)
            local h = BIG_FONT:getHeight()
            love.graphics.setFont(BIG_FONT)
            love.graphics.setColor(.7, .0, .0, 1)
            love.graphics.print(v, j, k)
        end
    end
end

function _M:draw()
    for i = 1,3*3, 1 do
        local x = (i - 1) % 3 * 333
        local y = math.floor((i - 1) / 3) * 333

        -- love.graphics.setColor(x / 1000, y / 1000, .5, 1)
        -- love.graphics.rectangle('fill', x, y, 333, 333)
    end


    _M:draw_squares(5, 5, math.floor(1000 / 3) - 4, self._draw)

end

return _M
