local push = require('push')
local bird = require('bird')
local pair = require('pipe-pair')

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
local spawnTimer = 0
local pipes = {}
local lastY = -PIPE_HEIGHT + math.random(80) + 20

BG_LOOP_POINT = 413

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Floppy birb')
    bird:init()
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = false,
        fullscreen = false,
        resizeable = true
    })
    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
    if key == 'escape' then
        love.event.quit(0)
    end
end

function love.keyboard:wasPressed(key)
    return self.keysPressed[key] or false
end

function love.update(dt)
    b_scroll = (b_scroll + (dt * b_speed)) % BG_LOOP_POINT
    g_scroll = (g_scroll + (dt * g_speed)) % VIRTUAL_WIDTH
    bird:update(dt)

    spawnTimer = spawnTimer + dt
    if spawnTimer > 2 then
        local y = math.max(-PIPE_HEIGHT + 10, math.min(lastY + math.random(-20, 20), VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT))
        lastY = y
        table.insert(pipes, pair:new(y))
        spawnTimer = 0
    end

    for k, pipe in pairs(pipes) do
        print(pipe)
        pipe:update(dt)
        if pipe.remove then
            table.remove(pipes, k)
        end
    end
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    love.graphics.draw(background, -b_scroll, 0)
    love.graphics.draw(ground, -g_scroll, VIRTUAL_HEIGHT - ground:getHeight())
    for _, p in pairs(pipes) do
        p:render()
    end
    bird:render()
    push:finish()
end
