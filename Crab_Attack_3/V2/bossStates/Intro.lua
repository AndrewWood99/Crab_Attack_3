--[[
    
]]

Intro = Class{__includes = Base}


function Intro:init()
	self.boss = Boss()
    self.player = Player()
end

function Intro:update(dt)
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
end


function Intro:render()
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