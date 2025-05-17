--[[
    
]]

Body = Class{__includes = Base}



function Body:init()
	self.boss = Boss()
end

function Body:update(dt)
	
end


function Body:render()
	love.graphics.draw(self.boss.body_image, gBossx, gBossy)
    love.graphics.draw(self.boss.right_arm_image, gBossx, gBossy)
    love.graphics.draw(self.boss.left_arm_image, gBossx, gBossy)
    love.graphics.draw(self.boss.bottom_image, gBossx, gBossy)
end