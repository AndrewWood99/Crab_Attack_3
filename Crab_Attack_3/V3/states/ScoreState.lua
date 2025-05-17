--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    
end

function ScoreState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') or love.keyboard.keysPressed[key] == true then
        sounds['music']:stop()
        gStateMachine:change('title')
    end
end

function ScoreState:render()
    love.graphics.setColor(1, 0, 0, 255)
    love.graphics.print('Again?  ENTER')
end