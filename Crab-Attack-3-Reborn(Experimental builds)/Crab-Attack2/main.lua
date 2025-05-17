--[[
    Crab Attack 3 - Lesson 0

    Author: Andrew Wood
    andrew99wood@gmail.com
]]

-- virtual resolution handling library
push = require 'push'

-- classic OOP class library
Class = require 'class'

-- bird class we've written
require 'Player'

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
end

function love.draw()
    push:start()
    
    -- draw the background at the negative looping point
    love.graphics.draw(background, 0, backgroundScroll - BACKGROUND_LOOPING_POINT)

    -- render our bird to the screen using its own render logic
    player:render()
    
    push:finish()
end