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

-- all code related to game state and state machines
require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/TitleScreenState'

-- physical screen dimensions
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- virtual resolution dimensions
VIRTUAL_WIDTH = 1280
VIRTUAL_HEIGHT = 720

-- background image and starting scroll location (X axis)
local background = love.graphics.newImage('background.png')
local backgroundScroll = 0

-- speed at which we should scroll our images, scaled by dt
local BACKGROUND_SCROLL_SPEED = 800

-- point at which we should loop our background back to X 0
local BACKGROUND_LOOPING_POINT = 1078


function love.load()
    -- initialize our nearest-neighbor filter
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- app window title
    love.window.setTitle('Crab Attack 3')

    -- initialize our nice-looking retro text fonts
    smallFont = love.graphics.newFont('font.ttf', 8)
    mediumFont = love.graphics.newFont('flappy.ttf', 14)
    flappyFont = love.graphics.newFont('flappy.ttf', 28)
    hugeFont = love.graphics.newFont('flappy.ttf', 56)
    love.graphics.setFont(flappyFont)

    -- initialize our virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    -- initialize state machine with all state-returning functions
    gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['play'] = function() return PlayState() end,
    }
    gStateMachine:change('title')
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

    -- now, we just update the state machine, which defers to the right state
    gStateMachine:update(dt)

end

function love.draw()
    push:start()
    
    -- draw the background at the negative looping point
    love.graphics.draw(background, 0, backgroundScroll - BACKGROUND_LOOPING_POINT)

    gStateMachine:render()
    

    --troubeshooting readouts
    love.graphics.setColor(1, 0, 0, 255)
    love.graphics.print('testx: ' .. testx, 10, 10)
    love.graphics.print('testy: ' .. testy, 10, 40)
    -- love.graphics.print('"', testx, testy)
    
    push:finish()
end