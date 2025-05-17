--[[
    Shot Class
    Author: Andrew Wood
    andrew99wood@gmail.com

]]

Shot = Class{}

-- since we only want the image loaded once, not per instantation, define it externally
local SHOT_IMAGE = love.graphics.newImage('shot.png')

local SHOT_SCROLL = -450

function Shot:init(player)

    self.width = SHOT_IMAGE:getWidth()
    self.height = SHOT_IMAGE:getHeight()

    -- position shot from player
    self.x = player.x + (player.width / 2) - (self.width / 2)
    self.y = player.y
end

function Shot:update(dt)
    self.y = self.y + SHOT_SCROLL * dt
end

function Shot:render()
    love.graphics.draw(SHOT_IMAGE, self.x, self.y)
end