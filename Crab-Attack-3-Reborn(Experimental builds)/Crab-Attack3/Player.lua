--[[
    Player Class
    Author: Andrew Wood
    andrew99wood@gmail.com
]]

Player = Class{}

local GRAVITY = 0.2

function Player:init()
    -- load player image from disk and assign its width and height
    self.image = love.graphics.newImage('player.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    -- position player in the middle of the screen
    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)

    -- Y velocity
    self.dy = 0
end

function Player:update(dt)
    -- apply gravity to velocity
    self.dy = self.dy + GRAVITY * dt

    -- apply current velocity to Y position
    self.y = self.y + self.dy
end

function Player:render()
    love.graphics.draw(self.image, self.x, self.y)
end