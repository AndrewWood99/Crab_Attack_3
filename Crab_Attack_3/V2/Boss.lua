--[[
	Boss Class
	Author: Andrew Wood
	andrew99wood@gmail.com

	The Boss is the enemy of the game. It generates all attacks for the player. It will break appart as it takes damage.

]]

Boss = Class{}

local SIDEWAYS_SPEED = 1
local BOUNCE = 0



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

    

    

	BODY_HOVER_PATTERN =   	{1, 1, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 3, 3, 3, 3, 2, 2, 1, 1}
	BOTTOM_HOVER_PATTERN = 	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0}
	ARM_ROTATE_PATTERN = 	{0, 0, 1, 1, 2, 2, 3, 3, 3, 3, 3, 3, 2, 2, 1, 1, 0, 0, 0, 0}
	HAND_X_PATTERN =		{200, 200, 5, 5, 8, 8, 12, 12, 12, 12, 11, 11, 8, 8, 5, 5, 2, 2, 1, 1} --761
	HAND_Y_PATTERN =		{0, 0, -3, -3, -7, -7, -11, -11, -12, -12, -11, -11, -8, -8, -6, -6, -3, -3, 0, 0} --326
	HAND_ROTATE_PATTERN =	{30, 30, 1, 1, 0, 0, 0, 0, -2, -2, -2, -2, -3, -3, -3, -3, -2, -2, 0, 0}

	RIGHT_HAND_HITBOX = {--x, y, radius (pixels)
							1122, 815, 58,
							955, 722, 61,
							1040, 765, 62,
							1107, 735, 93,
							1009, 688, 63,
							1096, 617, 95,
							1100, 558, 96
						 }

	LEFT_HAND_HITBOX = 	{--x, y, radius (pixels)
							249, 911, 31,
							238, 886, 43,
							199, 798, 72,
							164, 735, 116,
							102, 644, 93,
							75, 573, 74,
							127, 546, 65,
							94, 518, 67
					   	}
	
	BOTTOM_HITBOX =   	{--x, y, radius (pixels)
							441, 643, 46,
							753, 643, 46,
							--left x, right x, top y, bottom y (pixels)
							430, 762, 567, 690
					  	}

	BODY_HITBOX = 		{--x, y, radius (pixels)
							594, 217, 352,
							386, 216, 199,
							804, 201, 199,
							177, 138, 31,
							1015, 140, 31,
				  		}
end

function Boss:update(dt)
	gBossState:update(dt)

	--Side to side bounce
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

	HOVER_TIMER = HOVER_TIMER + dt
	if HOVER_TIMER > 0.04 then
		HOVER_COUNTER = (HOVER_COUNTER + 1) % 20
		HOVER_TIMER = 0
	end
	




	gBossx = self.x
	gBossy = self.y
end

function Boss:render()
    gBossState:render()
end