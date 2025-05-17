--[[
    Player Class
    Author: Andrew Wood
    andrew99wood@gmail.com
]]

Player = Class{}

local PLAYER_SPEED = 5

function Player:init()
    -- load player image from disk and assign its width and height
    self.image = love.graphics.newImage('player.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    -- position player in the middle bottom of the screen
    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 1.25 - (self.height / 2)

    self.radius = 30

end

function Player:collides(boss)
    if checkCircularCollision(self.x + (self.width / 2), self.y + (self.width / 2), boss.body_center_x, boss.body_center_y, boss.body_radius, self.radius) then
        return true
    end

    return false
end

function Player:update(dt)
    
    -- movement
    if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
        self.x = self.x + -PLAYER_SPEED
    end
    if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
        self.x = self.x + PLAYER_SPEED
    end
    if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
        self.y = self.y + -PLAYER_SPEED
    end
    if love.keyboard.isDown("s") or love.keyboard.isDown("down") then
        self.y = self.y + PLAYER_SPEED
    end
end

function Player:render()
    love.graphics.draw(self.image, self.x, self.y)
end