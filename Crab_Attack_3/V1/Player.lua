--[[
	Player Class
	Author: Andrew Wood
	andrew99wood@gmail.com

	The Player is the small ship that starts at the bottom of the screen. The ship is moved with the arrow keys.
	The ship is always firing straight ahead. The ship must avoid touching any attack from the Boss or the Boss
	itself to avoid taking damage.


]]

Player = Class{}

local PLAYER_SPEED = 4

function Player:init()
	self.image = love.graphics.newImage('Player.png')
	self.x = VIRTUAL_WIDTH / 2 - 8
    self.y = VIRTUAL_HEIGHT - 150

    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.dy = 0


    ghitbox = {41, 34, 24} --x, y, radius (pixels)
    gkilled = 0
    gplayerx = 0
    gplayery = 0

end




function Player:update(dt)
    self.dx = 0
    self.dy = 0


    if love.keyboard.isDown('right') then
        self.dx = PLAYER_SPEED
    elseif love.keyboard.isDown('left') then
        self.dx = -PLAYER_SPEED
    else 
        self.dx = 0
    end

    if love.keyboard.isDown('down') then
        self.dy = PLAYER_SPEED
    elseif love.keyboard.isDown('up') then
        self.dy = -PLAYER_SPEED
    else 
        self.dy = 0
    end

    
    self.x = self.x + self.dx
    self.y = self.y + self.dy

    gplayerx = self.x
    gplayery = self.y
end


function Player:render()
    love.graphics.draw(self.image, self.x, self.y)
end