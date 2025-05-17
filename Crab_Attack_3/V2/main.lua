--[[
	Crab Attack 3

	Author: Andrew Wood
	andrew99wood@gmail.com

	This game is a 2D top-down spaceship vs big boss flash game. The goal of the game is to manuver the ship
	using the arrow keys to avoid all of the Boss's attacks while slowly chiping away at the Boss's components'
	Health. The ship is always shooting straight ahead at the Boss. Each Boss component is launching various
	attacks and has its own health. When a component losses enough health it will be visually damaged and will
	the attack pattern will be altered or disabled.

	There are three stages:
	1. Arms
	2. Body
	3. Core

	Arms Stage:
		Right Arm
		-Energy charges at arm hole
		-Sustained laser fires down (Right screen)
		-Sweeps laser (to middle of screen)

		Left Arm
		-Arm Tenses
		-Blue Cystals build around arm
		-Swings arm
		-Releases cystals in a sweep pattern

		Bottom
		-Existing red charge up
		-Fires semicircular wave of projects that spread out

	Body Stage
		Right/Left Surface
		-Yellow Light shoots projectile, aimed at player
		-alternate with other side
		-when one is destroyed, remaining one shots 3 round bursts with increased fire rate

		Right/Left Missile Bays
		-Trio of Missiles pop up in bay
		-Trio of missiles, as well as a few more, shoot up above the screen
		-Missiles slowly fall from top of screen
		-Track player
		-Player must shoot them down
		-alternate firing missile barrage with other side
		-when one is destroyed, remaining one keeps the missle barrage rate constant 

	Core Stage
		Core Laser
		-Energy Charges at core
		-Laser shadow points straight down from core
		-Sustained Laser fires straight down, slightly wider than shadow
		-Sustains for a second or two

		DAMAGED Core Laser
		-Energy Charges at core
		-Laser shadow points straight down from core (Thinner than before damage)
		-Two additional thinner laser shadows (one left, one right) (random angles)
		-Sustained Laser fires straight down, slightly wider than shadow but thinner than before damage
		-Sustained Laser fires from both additional laser shadows
		-Sustains for a second or two

		Core Electricity/Severed Arms Electricity
		-Random bolts of electricity emit from core/severed arms
		-Experiment with eratic movement/bounce off walls
		-Bolts looks reminicant of Crab Attack 1
		-this bolt generator cannot be damaged, will remain operational until core is destroyed




	Ideas
	-when only one component left, move on to next stage with remaining component still operational
	-power up with stage completion?
	-animation with stage completion?
	-player can take multiple hits
	-IDEA MUSIC SHIP
		-Pick your song
		-Each song has a firing pattern that matches the beat and intenstiy of the song
		-will probably have to be individualy coded (Take forever)
		-power up?






]]

-- virtual resolution handling library
push = require 'push'

-- the "Class" library we're using will allow us to represent anything in
-- our game as code, rather than keeping track of many disparate variables and
-- methods
--
-- https://github.com/vrld/hump/blob/master/class.lua
Class = require 'class'

-- a basic StateMachine class which will allow us to transition to and from
-- game states smoothly and avoid monolithic code in one file
require 'StateMachine'

require 'states/BaseState'
require 'states/CountdownState'
require 'states/PlayState'
require 'states/ScoreState'
require 'states/TitleScreenState'

require 'BossState'

require 'bossStates/Base'
require 'bossStates/Intro'
require 'bossStates/Arms'
require 'bossStates/Body'
require 'bossStates/Core'


-- physical screen dimensions
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- virtual resolution dimensions
VIRTUAL_WIDTH = 1280
VIRTUAL_HEIGHT = 720

--Classes
require 'Boss'
require 'Player'
require 'Music'



local background = love.graphics.newImage('Background.png')
local backgroundScroll = 0
local BACKGROUND_SCROLL_SPEED = 600
local BACKGROUND_LOOPING_POINT = 1078


--[[
    Runs when the game first starts up, only once; used to initialize the game.
]]
function love.load()
	-- set love's default filter to "nearest-neighbor", which essentially
    -- means there will be no filtering of pixels (blurriness), which is
    -- important for a nice crisp, 2D look
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- set the title of our application window
    love.window.setTitle('Crab Attack 3')

    --Logos and start graphics
    Logo = love.graphics.newImage('Logo.png')
    PressRed = love.graphics.newImage('PressRed.png')
    PressYellow = love.graphics.newImage('PressYellow.png')


    BODY_IMAGE = love.graphics.newImage('Body.png')
	LEFT_ARM_IMAGE = love.graphics.newImage('LeftArm.png')
	LEFT_HAND_IMAGE = love.graphics.newImage('LeftHand.png')
	RIGHT_ARM_IMAGE = love.graphics.newImage('RightArm.png')
	RIGHT_HAND_IMAGE = love.graphics.newImage('RightHand.png')
	BOTTOM_IMAGE = love.graphics.newImage('Bottom.png')

	BOTTOM_LIGHT_1 = love.graphics.newImage('1.png')
	BOTTOM_LIGHT_2 = love.graphics.newImage('2.png')
	BOTTOM_LIGHT_3 = love.graphics.newImage('3.png')
	BOTTOM_LIGHT_4 = love.graphics.newImage('4.png')
	BOTTOM_LIGHT_5 = love.graphics.newImage('5.png')
	BOTTOM_LIGHT_6 = love.graphics.newImage('6.png')
	BOTTOM_LIGHT_7 = love.graphics.newImage('7.png')
	BOTTOM_LIGHT_8 = love.graphics.newImage('8.png')
	BOTTOM_LIGHT_9 = love.graphics.newImage('9.png')
	BOTTOM_LIGHT_10 = love.graphics.newImage('10.png')
	BOTTOM_LIGHT_11 = love.graphics.newImage('11.png')
	BOTTOM_LIGHT_12 = love.graphics.newImage('12.png')
	BOTTOM_LIGHT_13 = love.graphics.newImage('13.png')
	BOTTOM_LIGHT_14 = love.graphics.newImage('14.png')
	BOTTOM_LIGHT_15 = love.graphics.newImage('15.png')
	BOTTOM_LIGHT_16 = love.graphics.newImage('16.png')
	BOTTOM_LIGHT_17 = love.graphics.newImage('17.png')
	BOTTOM_LIGHT_18 = love.graphics.newImage('18.png')
	BOTTOM_LIGHT_19 = love.graphics.newImage('19.png')
	BOTTOM_LIGHT_20 = love.graphics.newImage('20.png')

	BOTTOM_IMAGE_LIGHTS = {
		BOTTOM_LIGHT_1,
		BOTTOM_LIGHT_2,
		BOTTOM_LIGHT_3,
		BOTTOM_LIGHT_4,
		BOTTOM_LIGHT_5,
		BOTTOM_LIGHT_6,
		BOTTOM_LIGHT_7,
		BOTTOM_LIGHT_8,
		BOTTOM_LIGHT_9,
		BOTTOM_LIGHT_10,
		BOTTOM_LIGHT_11,
		BOTTOM_LIGHT_12,
		BOTTOM_LIGHT_13,
		BOTTOM_LIGHT_14,
		BOTTOM_LIGHT_15,
		BOTTOM_LIGHT_16,
		BOTTOM_LIGHT_17,
		BOTTOM_LIGHT_18,
		BOTTOM_LIGHT_19,
		BOTTOM_LIGHT_20
	}




    -- "seed" the RNG so that calls to random are always random
    -- use the current time, since that will vary on startup every time
    math.randomseed(os.time())

    
    -- initialize our virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    -- initialize state machine with all state-returning functions
    gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['countdown'] = function() return CountdownState() end,
        ['play'] = function() return PlayState() end,
        ['score'] = function() return ScoreState() end
    }
    gStateMachine:change('title')

    gBossState = BossState {
    	['intro'] = function() return Intro() end,
    	['arms'] = function() return Arms() end,
    	['body'] = function() return Body() end,
    	['core'] = function() return Core() end,
    }
    gBossState:change('intro')



    --Added global variables for the boss location 
    --Needed to pass on locations to Boss states
    gBossx = VIRTUAL_WIDTH / 2 - 386
    gBossy = -612

    --Hover Vriables
    HOVER_COUNTER = 0
	HOVER_TIMER = 0

	--Boss Part Location Variables
	rightArmX = 0
	rightArmY = -720
	rightArmR = 0
	leftArmX = 0
	leftArmY = -720
	leftArmR = 0
	rightHandX = 0
	rightHandY = -720
	rightHandR = 0
	leftHandX = 0
	leftHandY = -720
	leftHandR = 0
	bottomX = 0
	bottomY = -720
	bodyX = 0
	bodyY = -720


    -- initialize input table
    love.keyboard.keysPressed = {}



    TroubleFont = love.graphics.newFont('font.ttf', 32)
    love.graphics.setFont(TroubleFont)

end


--[[
    Called by LÖVE whenever we resize the screen; here, we just want to pass in the
    width and height to push so our virtual resolution can be resized as needed.
]]
function love.resize(w, h)
    push:resize(w, h)
end


function love.keypressed(key)
    -- add to our table of keys pressed this frame
    love.keyboard.keysPressed[key] = true
    
    if key == 'escape' then
        love.event.quit()
    end
end


--[[
    New function used to check our global input table for keys we activated during
    this frame, looked up by their string value.
]]
function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

--[[
    Runs every frame, with "dt" passed in, our delta in seconds 
    since the last frame, which LÖVE2D supplies us.
]]
function love.update(dt)
	-- scroll background by preset speed * dt, looping back to 0 after the looping point
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) 
        % BACKGROUND_LOOPING_POINT

    gStateMachine:update(dt)


	

	-- reset input table
    love.keyboard.keysPressed = {}
end


function love.draw()
	push:start()

	-- draw the background at the negative looping point
    love.graphics.draw(background, 0, backgroundScroll - 1078)

	gStateMachine:render()

	--troubeshooting readouts
	--love.graphics.setColor(1, 0, 0, 255)
    --love.graphics.print('Approach Speed: ' .. APPROACH_SPEED, 10, 10)
    --love.graphics.print('Distance1: ' .. distance1, 10, 40)
    --love.graphics.print('Player X: ' .. gplayerx, 10, 70)



	

	push:finish()
end