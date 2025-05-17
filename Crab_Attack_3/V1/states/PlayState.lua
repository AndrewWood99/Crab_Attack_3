--[[
    PlayState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The PlayState class is the bulk of the game, where the player actually controls the bird and
    avoids pipes. When the player collides with a pipe, we should go to the GameOver state, where
    we then go back to the main menu.
]]

PlayState = Class{__includes = BaseState}



function PlayState:init()
    self.player = Player()
    self.boss = Boss()
end

function PlayState:update(dt)
    self.player:update(dt)
    self.boss:update(dt)

    if gkilled == 1 then
        gStateMachine:change('title')
    end
end

function PlayState:render()
    self.player:render()
    self.boss:render()
end

--[[
    Called when this state is transitioned to from another state.
]]
function PlayState:enter()
    
end

--[[
    Called when this state changes to another state.
]]
function PlayState:exit()

end