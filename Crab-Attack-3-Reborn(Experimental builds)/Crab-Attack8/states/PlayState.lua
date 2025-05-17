--[[
    Author: Andrew Wood
    andrew99wood@gmail.com

    The PlayState class is the bulk of the game, where the player actually controls the bird and
    avoids pipes. When the player collides with a pipe, we should go to the GameOver state, where
    we then go back to the main menu.
]]

PlayState = Class{__includes = BaseState}

PIPE_SPEED = 60
PIPE_WIDTH = 70
PIPE_HEIGHT = 288

BIRD_WIDTH = 38
BIRD_HEIGHT = 24

function PlayState:init()
    self.player = Player()
    self.boss = Boss()
    self.timer = 0

    -- our table of spawning Shots
    self.shots = {}
end

function PlayState:update(dt)
    -- update timer for pipe spawning
    self.timer = self.timer + dt

    -- spawn a new Shot if the timer is past seconds
    if self.timer > 0.10 then
        table.insert(self.shots, Shot(self.player))
        self.timer = 0
    end

    self.player:update(dt)

    self.boss:update(dt)

    -- for every shot in the scene...
    for k, shot in pairs(self.shots) do
        shot:update(dt)

        -- if shot is no longer visible past left edge, remove it from scene
        if shot.y < -shot.height or shot:collides(self.boss)then
            table.remove(self.shots, k)
            testx = testx + 1
        end
    end

    -- player hits boss --
    if self.player:collides(self.boss) then
        testy = 0
        testx = 0
        gStateMachine:change('title')
    else
        testy = 1
    end
end

function PlayState:render()
    self.boss:render()
    self.player:render()

    -- render all the shots in our scene
    for k, shot in pairs(self.shots) do
        shot:render()
    end
end