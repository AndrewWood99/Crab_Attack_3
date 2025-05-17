Music = Class{}

function Music:init()
	-- initialize our table of sounds
    sounds = {
        -- https://www.newgrounds.com/audio/listen/661012
        ['music'] = love.audio.newSource('Space-Battle.mp3', 'static')
    }

    -- Set Looping True
    sounds['music']:setLooping(true)

    
end

function Music:update(track, volume)
	sounds[track]:setVolume(1)
    sounds[track]:play()
end