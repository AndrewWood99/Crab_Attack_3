--[[
    
]]

Arms = Class{__includes = Base}

local RIGHT_HAND_HITBOX = {--x, y, radius (pixels)
							1122, 815, 58,
							955, 722, 61,
							1040, 765, 62,
							1107, 735, 93,
							1009, 688, 63,
							1096, 617, 95,
							1100, 558, 96
						  }

local LEFT_HAND_HITBOX = {--x, y, radius (pixels)
							249, 911, 31,
							238, 886, 43,
							199, 798, 72,
							164, 735, 116,
							102, 644, 93,
							75, 573, 74,
							127, 546, 65,
							94, 518, 67
						 }

local BOTTOM_HITBOX =   {--x, y, radius (pixels)
							441, 643, 46,
							753, 643, 46,
							--left x, right x, top y, bottom y (pixels)
							430, 762, 567, 690
						}

local BODY_HITBOX = {--x, y, radius (pixels)
						594, 217, 352,
						386, 216, 199,
						804, 201, 199,
						177, 138, 31,
						1015, 140, 31,
					}




function Arms:init()
    self.boss = Boss()
    self.player = Player()

    distance = 1
    distance1 = 1
end


function Arms:update(dt)

	--Right Hand Collide
	for i=0, 6 do
		distance = math.sqrt(((RIGHT_HAND_HITBOX[(i * 3) + 1] + gBossx) - (gplayerx + ghitbox[1]))^2 + ((RIGHT_HAND_HITBOX[(i * 3) + 2] + gBossy) - (gplayery + ghitbox[2]))^2)
		if distance < (RIGHT_HAND_HITBOX[(i * 3) + 3] + ghitbox[3]) then
			killed = 1
			love.graphics.draw(self.boss.bottom_image, gBossx, gBossy)
		end
	end

	distance1 = math.sqrt(( (-gplayerx)^2))


end


function Arms:render()
    love.graphics.draw(self.boss.body_image, gBossx, gBossy)
    love.graphics.draw(self.boss.right_arm_image, gBossx, gBossy)
    love.graphics.draw(self.boss.right_hand_image, gBossx, gBossy)
    love.graphics.draw(self.boss.left_arm_image, gBossx, gBossy)
    love.graphics.draw(self.boss.left_hand_image, gBossx, gBossy)
    love.graphics.draw(self.boss.bottom_image, gBossx, gBossy)
end