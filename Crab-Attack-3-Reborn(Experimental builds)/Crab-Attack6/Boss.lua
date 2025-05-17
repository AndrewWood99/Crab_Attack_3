--[[
    Boss Class
    Author: Andrew Wood
    andrew99wood@gmail.com

]]

Boss = Class{}

local BOSS_SPEED = 2
local BOSS_MOVEMENT_DIRECTION = 1
local BOSS_SCREEN_EDGE_OVERHANG = 100

function Boss:init()
    -- load player image from disk and assign its width and height
    self.image = love.graphics.newImage('boss.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = (VIRTUAL_WIDTH / 2) - (self.width / 2)
    self.y = -30
end

function Boss:update(dt)
    
    if self.x + self.width > (VIRTUAL_WIDTH + BOSS_SCREEN_EDGE_OVERHANG) then
        BOSS_MOVEMENT_DIRECTION = -1
    elseif self.x < (0 - BOSS_SCREEN_EDGE_OVERHANG) then
        BOSS_MOVEMENT_DIRECTION = 1
    end

    self.x = self.x + (BOSS_SPEED * BOSS_MOVEMENT_DIRECTION)

end

function Boss:render()
    love.graphics.draw(self.image, self.x, self.y)
end