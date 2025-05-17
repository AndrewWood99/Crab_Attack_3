--[[
    
]]

Arms = Class{__includes = Base}



--due to picture scale issue, divide all hitbox pixel measurements by this constant
local SCALE_FIX = 1.57

local distance

local rightArmHitX = {}
local rightArmHitY = {}

function Arms:init()
    self.boss = Boss()
    self.player = Player()
end


function Arms:update(dt)

	--move Boss
		rightArmX = gBossx + 606
		rightArmY = gBossy + 191 + -(2 * BODY_HOVER_PATTERN[HOVER_COUNTER + 1])
		rightArmR = ARM_ROTATE_PATTERN[HOVER_COUNTER + 1] * -0.03

		leftArmX = gBossx + 158
		leftArmY = gBossy + 191+ -(2 * BODY_HOVER_PATTERN[HOVER_COUNTER + 1])
		leftArmR = ARM_ROTATE_PATTERN[HOVER_COUNTER + 1] * 0.03

		rightHandX = gBossx + 761 + HAND_X_PATTERN[HOVER_COUNTER + 1]
		rightHandY = gBossy + 320 + HAND_Y_PATTERN[HOVER_COUNTER + 1]
		rightHandR = HAND_ROTATE_PATTERN[HOVER_COUNTER + 1] * 0.025

		leftHandX = gBossx + 59 + -HAND_X_PATTERN[HOVER_COUNTER + 1]
		leftHandY = gBossy + 320 + HAND_Y_PATTERN[HOVER_COUNTER + 1]
		leftHandR = HAND_ROTATE_PATTERN[HOVER_COUNTER + 1] * -0.025

		bottomX = gBossx
		bottomY = gBossy + -(3 * BOTTOM_HOVER_PATTERN[HOVER_COUNTER + 1])

		bodyX = gBossx
		bodyY = gBossy + -(2 * BODY_HOVER_PATTERN[HOVER_COUNTER + 1])


		


	--Detect Collisions

		--Right Hand Collide
		for i=0, 6 do
			distance = math.sqrt((((RIGHT_HAND_HITBOX[(i * 3) + 1] / SCALE_FIX) + rightHandX - 761) - (gplayerx + ghitbox[1]))^2 + (((RIGHT_HAND_HITBOX[(i * 3) + 2] / SCALE_FIX) + rightHandY - 320) - (gplayery + ghitbox[2]))^2)
			if distance < ((RIGHT_HAND_HITBOX[(i * 3) + 3] / SCALE_FIX) + ghitbox[3]) then
				gkilled = 1
			end
		end

		--Left Hand Collide
		for i=0, 7 do
			distance = math.sqrt((((LEFT_HAND_HITBOX[(i * 3) + 1] / SCALE_FIX) + gBossx) - (gplayerx + ghitbox[1]))^2 + (((LEFT_HAND_HITBOX[(i * 3) + 2] / SCALE_FIX) + gBossy) - (gplayery + ghitbox[2]))^2)
			if distance < ((LEFT_HAND_HITBOX[(i * 3) + 3] / SCALE_FIX) + ghitbox[3]) then
				gkilled = 1
			end
		end

		--Bottom Collide
		for i=0, 1 do
			distance = math.sqrt((((BOTTOM_HITBOX[(i * 3) + 1] / SCALE_FIX) + gBossx) - (gplayerx + ghitbox[1]))^2 + (((BOTTOM_HITBOX[(i * 3) + 2] / SCALE_FIX) + gBossy) - (gplayery + ghitbox[2]))^2)
			if distance < ((BOTTOM_HITBOX[(i * 3) + 3] / SCALE_FIX) + ghitbox[3]) then
				gkilled = 1
			end
			if ((BOTTOM_HITBOX[7] / SCALE_FIX) + gBossx) < (gplayerx + ghitbox[1]) and (gplayerx + ghitbox[1]) < ((BOTTOM_HITBOX[8] / SCALE_FIX) + gBossx) and (gplayery + ghitbox[2]) < ((BOTTOM_HITBOX[10] / SCALE_FIX) + gBossy) then
				gkilled = 1
			end
		end

		--Body Collide
		for i=0, 4 do
			distance = math.sqrt((((BODY_HITBOX[(i * 3) + 1] / SCALE_FIX) + gBossx) - (gplayerx + ghitbox[1]))^2 + (((BODY_HITBOX[(i * 3) + 2] / SCALE_FIX) + gBossy) - (gplayery + ghitbox[2]))^2)
			if distance < ((BODY_HITBOX[(i * 3) + 3] / SCALE_FIX) + ghitbox[3]) then
				gkilled = 1
			end
		end

	



end


function Arms:render()
	--Arms
	love.graphics.draw(self.boss.right_arm_image, rightArmX, rightArmY, rightArmR, 1, 1, 606, 191) 
	love.graphics.draw(self.boss.left_arm_image, leftArmX, leftArmY, leftArmR, 1, 1, 158, 191)
	--Hands
	love.graphics.draw(self.boss.right_hand_image, rightHandX, rightHandY, rightHandR, 1, 1, 761, 320)
    love.graphics.draw(self.boss.left_hand_image, leftHandX, leftHandY, leftHandR, 1, 1, 59, 320)
	--Bottom
	love.graphics.draw(self.boss.bottom_image, bottomX, bottomY)
	love.graphics.draw(BOTTOM_IMAGE_LIGHTS[HOVER_COUNTER + 1], bottomX - 56, bottomY - 15)
	--Body
    love.graphics.draw(self.boss.body_image, bodyX, bodyY)

end