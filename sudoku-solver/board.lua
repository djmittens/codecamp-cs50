BLANK = -1

local BIG_FONT = love.graphics.newFont(64)
local LIL_FONT = love.graphics.newFont(24)
local BOARD_SIZE = 9 * 9

BOARD1 = {
    2, 6, BLANK, BLANK, BLANK, 3, BLANK, 1, 5,
    4, 7, BLANK, BLANK, BLANK, BLANK, BLANK, BLANK, 8,
    5, 8, 1, BLANK, BLANK, 4, 7, 6, 3,
    BLANK, 3, BLANK, 4, 8, 9, BLANK, 7, BLANK,
    BLANK, BLANK, 6, BLANK, BLANK, 2, 8, 3, BLANK,
    BLANK, BLANK, 8, 3, 1, BLANK, BLANK, BLANK, BLANK,
    6, 9, BLANK, BLANK, BLANK, 8, BLANK, BLANK, 7,
    6, BLANK, BLANK, BLANK, 9, BLANK, 2, BLANK, BLANK,
    BLANK, 1, BLANK, 5, BLANK, BLANK, BLANK, 9, 6,
}

local _M = {
}
_M.__index = _M

local function unwrap(i, b)
    local res = {}

    local offset_x = i % 9
    local offset_y = math.floor(i / 9)

    for y = 0, 2, 1 do
        for x = 0, 2, 1 do
            table.insert(res, b[(offset_y + y) * 9 + (offset_x + x) + 1])
        end
    end

    return res
end

local function update_draw(board)
    board._draw = {}
    for k = 0, 2, 1 do
        for j = 0, 2, 1 do
            table.insert(board._draw, unwrap(k * 9 * 3 + (j * 3), board.board))
        end
    end
end

function _M:new(board)
    local res = {
        board = {},
        _draw = {}
    }

    for i, v in pairs(board) do
        if v > BLANK then
            res.board[i] = v
        else
            res.board[i] = { 1, 2, 3, 4, 5, 6, 7, 8, 9 }
        end
    end

    update_draw(res)

    setmetatable(res, _M)
    return res
end

local function mouseon(x, y, size)
    local m_x, m_y = love.mouse.getPosition()
    return m_x > x and m_x < x + size and m_y > y and m_y < y + size
end

function _M:draw_squares(x, y, size, board)

    if size < 10 then return end

    local font
    if size < 50 then
        font = LIL_FONT
    else
        font = BIG_FONT
    end

    for i, v in pairs(board) do
        i = i - 1
        local j = (i % 3) * size + x
        local k = math.floor(i / 3) * size + y
        -- draw background
        -- local scale = 1 - (size + j + k) / 2000
        -- local scale = math.sqrt(math.pow(k, 2) + j + .5) / 2000 + .3
        local scale
        if type(v) == 'table' then
            scale = .1
        else
            scale = .8
        end

        love.graphics.setColor(scale, scale, scale, 2)
        love.graphics.rectangle('fill', j, k, size, size)

        -- if v > BLANK then
        if type(v) == 'table' then
            _M:draw_squares(j, k, math.floor(size / 3), v)
            -- print(v)
        elseif v > BLANK then
            local w = (size - font:getWidth(v)) / 2
            local h = (size - font:getHeight()) / 2
            love.graphics.setFont(font)
            love.graphics.setColor(.7, .0, .0, 1)
            love.graphics.print(v, j + w, k + h)
        end
    end
end

function _M:draw()
    _M:draw_squares(0, 0, math.floor(1000 / 3), self._draw)
end

return _M
