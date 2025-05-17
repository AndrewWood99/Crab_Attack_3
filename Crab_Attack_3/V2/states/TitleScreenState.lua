--[[
    TitleScreenState Class
    
    Author: Andrew Wood
    andrew99wood@gmail.com

    The TitleScreenState is the starting screen of the game, shown on startup
]]

TitleScreenState = Class{__includes = BaseState}



function TitleScreenState:init()
    self.timer = 0

    self.player = Player()
    self.music = Music()

    

    
    self.music:update('music',1)
end

function TitleScreenState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') or love.keyboard.keysPressed[key] == true then
        gStateMachine:change('countdown')
    end

    self.timer = self.timer + dt
end

function TitleScreenState:render()
    
    love.graphics.draw(Logo, VIRTUAL_WIDTH / 2 - 516, VIRTUAL_HEIGHT / 2 - 200)

    if self.timer % 1 > 0.5 then
        love.graphics.draw(love.graphics.newImage('PressRed.png'), VIRTUAL_WIDTH / 2 - 250, VIRTUAL_HEIGHT / 2)
    else
        love.graphics.draw(love.graphics.newImage('PressYellow.png'), VIRTUAL_WIDTH / 2 - 250, VIRTUAL_HEIGHT / 2)
    end

    self.player:render()

    
end