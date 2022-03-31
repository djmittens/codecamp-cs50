local push = require('push')
local paddle= require('paddle')
local ball = require('ball')

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200 -- good value multiplied by dt

PLAYER_1 = {
    name = "Player 1",
    paddle = paddle:new(10, 30, 5, 20),
    score = 0
}

PLAYER_2 = {
    name = "Player 2",
    paddle = paddle:new(VIRTUAL_WIDTH - 15, VIRTUAL_HEIGHT - 50, 5, 20),
    score = 0
}

PADDLES = {PLAYER_1.paddle, PLAYER_2.paddle}

BALL = ball:new(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4)

GAME_STATE = 'start'

SOUNDS = {}


function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- Seed the RNG on startup
    math.randomseed(os.time())

    smallFont = love.graphics.newFont('font.ttf', 8)
    scoreFont = love.graphics.newFont('font.ttf', 32) -- Fonts are immutable so we need to load again to set the size

    -- Setting the default font here
    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })
    love.window.setTitle("Pong 0.0.1")

    SOUDNS = {
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static'),
        ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
    }
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if GAME_STATE == 'start' or GAME_STATE == 'serve' then
            GAME_STATE = 'play'
        elseif GAME_STATE == 'victory' then
            GAME_STATE = 'start'
            PLAYER_1.score = 0
            PLAYER_2.score = 0
        else
            GAME_STATE = 'serve'
            BALL = ball:new(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4)
        end
    end
end

function love.update(dt)
    -- Player 1 
    if love.keyboard.isDown('w') then
        PLAYER_1.paddle.dy = -PADDLE_SPEED
    end
    if love.keyboard.isDown('s') then
        PLAYER_1.paddle.dy = PADDLE_SPEED
    end
    if love.keyboard.isDown('up') then
        PLAYER_2.paddle.dy = -PADDLE_SPEED
    end
    if love.keyboard.isDown('down') then
        PLAYER_2.paddle.dy = PADDLE_SPEED
    end

    if GAME_STATE == 'play' then
        PLAYER_1.paddle:update(dt)
        PLAYER_2.paddle:update(dt)
        BALL:update(dt, PADDLES)
        if(BALL.x < 0) then
            PLAYER_2.score = PLAYER_2.score + 1
            BALL = ball:new(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4)
            GAME_STATE = 'serve'
            if(SOUNDS.score) then SOUNDS.score:play() end
        end
        if(BALL.x > VIRTUAL_WIDTH) then
            PLAYER_1.score = PLAYER_1.score + 1
            BALL = ball:new(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4)
            GAME_STATE = 'serve'
            if(SOUNDS.score) then SOUNDS.score:play() end
        end
    end
    if PLAYER_1.score == 5 or PLAYER_2.score == 5 then
        GAME_STATE = 'victory'
    end
end

local function drawFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.print('FPS: '.. love.timer.getFPS(), 10, 10)
end

function love.draw()
    push:apply('start')
    -- love.graphics.clear(40, 45, 52, 255) -- Cool Pongish background sampled from rando internet
    -- Yet another api change that got me rolling
    love.graphics.clear(40. / 255, 45. / 255, 52. / 255, 1) -- Cool Pongish background sampled from rando internet

    if GAME_STATE == 'start' then
        love.graphics.setFont(smallFont)
        love.graphics.printf( -- Neat function to print hello world
        'Welcome to PONG! Please press Enter to begin', 0, 20, VIRTUAL_WIDTH, 'center')
    elseif GAME_STATE == 'serve' then
        love.graphics.setFont(smallFont)
        love.graphics.printf( -- Neat function to print hello world
        'Serve!', 0, 20, VIRTUAL_WIDTH, 'center')
    elseif GAME_STATE == 'victory' then
        love.graphics.setFont(smallFont)
        love.graphics.printf( -- Neat function to print hello world
        'Player wins!', 0, 20, VIRTUAL_WIDTH, 'center')
    end

    -- draw a left paddle
    PLAYER_1.paddle:draw()
    -- right paddle
    PLAYER_2.paddle:draw()
    BALL:draw()

    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(PLAYER_1.score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(PLAYER_2.score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)

    drawFPS()

    push:apply('end')
end

