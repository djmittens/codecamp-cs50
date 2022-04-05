
local push = require('push')

WINDOW_HEIGHT = 720
WINDOW_WIDTH = 1280

VIRTUAL_HEIGHT = 288
VIRTUAL_WIDTH = 512

local background = love.graphics.newImage('background.png')
local b_scroll = 0
local b_speed = 30
local ground = love.graphics.newImage('ground.png')
local g_scroll = 0
local g_speed = 60

BG_LOOP_POINT = 413

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Floppy birb')
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync=false,
        fullscreen=false,
        resizeable=true
    })
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key=='escape' then
        love.event.quit(0)
    end
end

function love.update(dt)
    b_scroll = (b_scroll + (dt * b_speed)) % BG_LOOP_POINT
    g_scroll = (g_scroll + (dt * g_speed)) % VIRTUAL_WIDTH
end

function love.draw()
    push:start()
    love.graphics.draw(background, -b_scroll, 0)
    love.graphics.draw(ground, -g_scroll, VIRTUAL_HEIGHT - 16)
    push:finish()
end