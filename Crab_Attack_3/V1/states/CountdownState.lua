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
local APPROACH_SPEED = 5

--Squared value for approach speed slowdown
local APPROACH_P = 0.15

function CountdownState:init()
    self.player = Player()
    self.boss = Boss()

    gBossy = -612
end

--[[
    Keeps track of how much time has passed and decreases count if the
    timer has exceeded our countdown time. If we have gone down to 0,
    we should transition to our PlayState.
]]
function CountdownState:update(dt)
    gBossy = gBossy + APPROACH_SPEED - ((200 + gBossy) * APPROACH_P * APPROACH_P)
    

    if gBossy >= 0 then
        gStateMachine:change('play')
    end
end

function CountdownState:render()
    self.player:render()
    self.boss:render()
end