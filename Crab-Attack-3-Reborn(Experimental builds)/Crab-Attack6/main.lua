--[[
    Crab Attack 3 - Lesson 0

    Author: Andrew Wood
    andrew99wood@gmail.com
]]

testx = 0
testy = 0

-- virtual resolution handling library
push = require 'push'

-- classic OOP class library
Class = require 'class'

-- Player class we've written
require 'Player'

-- Boss class we've written
require 'Boss'

-- Shot class
require 'Shot'

-- physical screen dimensions
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- virtual resolution dimensions
VIRTUAL_WIDTH = 1280
VIRTUAL_HEIGHT = 720

-- background image and starting scroll location (X axis)
local background = love.graphics.newImage('background.png')
local backgroundScroll = 0

-- images we load into memory from files to later draw onto the screen
local background = love.graphics.newImage('background.png')

-- speed at which we should scroll our images, scaled by dt
local BACKGROUND_SCROLL_SPEED = 800

-- point at which we should loop our background back to X 0
local BACKGROUND_LOOPING_POINT = 1078

-- our player sprite
local player = Player()

-- our boss sprite
local boss = Boss()

-- our table of spawning Shots
local shots = {}

-- our timer for spawning Shots
local spawnTimer = 0

function love.conf(t)
    t.console = true
end
print("test")

function love.load()
    -- initialize our nearest-neighbor filter
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- app window title
    love.window.setTitle('Crab Attack 3')

    -- initialize our virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)    
    if key == 'escape' then
        love.event.quit()
    end
end

function love.update(dt)
    -- scroll background by preset speed * dt, looping back to 0 after the looping point
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) 
        % BACKGROUND_LOOPING_POINT

    spawnTimer = spawnTimer + dt

    -- spawn a new Shot if the timer is past seconds
    if spawnTimer > 0.14 then
        table.insert(shots, Shot(player))
        spawnTimer = 0
    end

    player:update(dt)

    boss:update(dt)

    -- for every shot in the scene...
    for k, shot in pairs(shots) do
        shot:update(dt)

        -- if shot is no longer visible past left edge, remove it from scene
        if shot.y < -shot.height then
            table.remove(shots, k)
            testx = testx + 1
        end
    end
end

function love.draw()
    push:start()
    
    -- draw the background at the negative looping point
    love.graphics.draw(background, 0, backgroundScroll - BACKGROUND_LOOPING_POINT)

    -- render all the shots in our scene
    for k, shot in pairs(shots) do
        shot:render()
    end

    player:render()
    boss:render()

    --troubeshooting readouts
    love.graphics.setColor(1, 0, 0, 255)
    love.graphics.print('testx: ' .. testx, 10, 10)
    love.graphics.print('testy: ' .. testy, 10, 40)
    love.graphics.print('"', testx, testy)
    
    push:finish()
end