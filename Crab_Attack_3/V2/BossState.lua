--
-- Boss Statemachine
--
-- There are three stages:
--	1. Arms
--	2. Body
--	3. Core


BossState = Class{}

function BossState:init(bossStates)
	self.empty = {
		render = function() end,
		update = function() end,
		enter = function() end,
		exit = function() end
	}
	self.states = bossStates or {} -- [name] -> [function that returns states]
	self.current = self.empty
end

function BossState:change(stateName)
	assert(self.states[stateName]) -- state must exist!
	self.current = self.states[stateName]()
end

function BossState:update(dt)
	self.current:update(dt)
end

function BossState:render()
	self.current:render()
end
