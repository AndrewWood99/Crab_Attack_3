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


function Shot:collides(boss)
    if checkCircularCollision(self.x + (self.width / 2), self.y, boss.body_center_x, boss.body_center_y, boss.body_radius, 0) then
        return true
    end

    return false
end

function Shot:update(dt)
    self.y = self.y + SHOT_SCROLL * dt
end

function Shot:render()
    love.graphics.draw(SHOT_IMAGE, self.x, self.y)
end






--Collision Function--
function checkCircularCollision(ax, ay, bx, by, ar, br)
    local dx = bx - ax
    local dy = by - ay
    return dx^2 + dy^2 < (ar + br)^2
end