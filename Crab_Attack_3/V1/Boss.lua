--[[
	Boss Class
	Author: Andrew Wood
	andrew99wood@gmail.com

	The Boss is the enemy of the game. It generates all attacks for the player. It will break appart as it takes damage.

]]

Boss = Class{}

local SIDEWAYS_SPEED = 1
local BOUNCE = 0

local BODY_IMAGE = love.graphics.newImage('Body.png')
local LEFT_ARM_IMAGE = love.graphics.newImage('LeftArm.png')
local LEFT_HAND_IMAGE = love.graphics.newImage('LeftHand.png')
local RIGHT_ARM_IMAGE = love.graphics.newImage('RightArm.png')
local RIGHT_HAND_IMAGE = love.graphics.newImage('RightHand.png')
local BOTTOM_IMAGE = love.graphics.newImage('Bottom.png')

function Boss:init()
	self.body_image = BODY_IMAGE
	self.left_arm_image = LEFT_ARM_IMAGE
	self.left_hand_image = LEFT_HAND_IMAGE
	self.right_arm_image = RIGHT_ARM_IMAGE
	self.right_hand_image = RIGHT_HAND_IMAGE
	self.bottom_image = BOTTOM_IMAGE

	self.x = VIRTUAL_WIDTH / 2 - 386
    self.y = 0

    self.width = 773
    self.height = 602

    self.dx = 0
    self.dy = 0
end

function Boss:update(dt)
	gBossState:update(dt)

	if self.x <= 0 then
		BOUNCE = 0
	elseif self.x >= VIRTUAL_WIDTH - self.width then
		BOUNCE = 1
	end

	if BOUNCE == 0 then
		self.x = self.x + SIDEWAYS_SPEED
	else
		self.x = self.x + -SIDEWAYS_SPEED
	end

	gBossx = self.x
	gBossy = self.y
end

function Boss:render()
    gBossState:render()
end