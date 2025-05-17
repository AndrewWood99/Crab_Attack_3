--[[
    Countdown State
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Counts down visually on the screen (3,2,1) so that the player knows the
    game is about to begin. Transitions to the PlayState as soon as the
    countdown is complete.
]]

CountdownState = Class{__includes = BaseState}

--Approach Speed the Boss comes down from the top of the screen
local APPROACH_SPEED = 3


function CountdownState:init()
    self.player = Player()
    self.boss = Boss()

    gBossx = VIRTUAL_WIDTH / 2 - 386
    gBossy = -612
end

--[[
    Keeps track of how much time has passed and decreases count if the
    timer has exceeded our countdown time. If we have gone down to 0,
    we should transition to our PlayState.
]]
function CountdownState:update(dt)
    if gBossy > -90 then
        gBossy = gBossy + APPROACH_SPEED * ((-gBossy/100) + 0.1)
    else
        gBossy = gBossy + APPROACH_SPEED
    end
    


    gBossState:update(dt)

    HOVER_TIMER = HOVER_TIMER + dt
    if HOVER_TIMER > 0.04 then
        HOVER_COUNTER = (HOVER_COUNTER + 1) % 20
        HOVER_TIMER = 0
    end


    if gBossy >= 0 then
        gBossState:change('arms')
        gStateMachine:change('play')
    end
end

function CountdownState:render()
    self.player:render()
    self.boss:render()
end