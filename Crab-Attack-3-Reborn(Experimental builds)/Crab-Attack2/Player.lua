--[[
    Player Class
    Author: Andrew Wood
    andrew99wood@gmail.com
]]

Player = Class{}

function Player:init()
    -- load player image from disk and assign its width and height
    self.image = love.graphics.newImage('player.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    -- position player in the middle of the screen
    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)
end

function Player:render()
    love.graphics.draw(self.image, self.x, self.y)
end