--[[
    
]]

Core = Class{__includes = Base}



function Core:init()
	self.boss = Boss()
end

function Core:update(dt)

end


function Core:render()
	love.graphics.draw(self.boss.body_image, gBossx, gBossy)
    love.graphics.draw(self.boss.right_arm_image, gBossx, gBossy)
    love.graphics.draw(self.boss.left_arm_image, gBossx, gBossy)
    love.graphics.draw(self.boss.bottom_image, gBossx, gBossy)
end