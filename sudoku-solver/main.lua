W_DIM = 1000

local board = require('board')

GAMEBOARD = board:new(BOARD1)

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.time())
    love.window.setMode(W_DIM, W_DIM, {
        fullscreen = false,
        vsync= true,
        resizable = false,
        centered = true
    })
    
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.update(dt)
end

function love.draw()
    GAMEBOARD:draw()
end