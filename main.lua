--[[
    This is an attempt to recreate the game of Snakes and Ladder
]]
require 'src/Dependencies'

-- Called by LOVE2D on loading the game
function love.load()
    -- Set the title of the game
    love.window.setTitle(GAME_TITLE)

    -- seeding the RNG
    math.randomseed(os.time())

    -- Fetch the background color
    gBackgroundImage = love.graphics.newImage("files/bg-image.jpg")

    -- Setting up background color
    love.graphics.setBackgroundColor(128/255, 128/255, 128/255, 1)

    -- Setting up the global state-machine
    gStateMachine = StateMachine {
        ['start'] = function() return StartState() end,
        ['play'] = function() return PlayState() end,
    }
    gStateMachine:change('start', {})

    -- Load the textures in
    gTextures = {

    }

    -- Make Quads out of it
    gQuads = {

    }

    -- Load the fonts
    gFonts = {
        ['small'] = love.graphics.newFont('fonts/font.ttf', 16),
        ['medium'] = love.graphics.newFont('fonts/font.ttf', 32),
        ['large'] = love.graphics.newFont('fonts/font.ttf', 64),
        ['huge'] = love.graphics.newFont('fonts/font.ttf', 112),
    }

    -- Load the sound-effects
    gSounds = {
        ['select'] = love.audio.newSource('sounds/select.wav', 'static'),
        ['confirm'] = love.audio.newSource('sounds/confirm.wav', 'static')
    }

    -- Setup the virtual screen
    -- push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    --     vsync = VSYNC,
    --     fullscreen = FULLSCREEN,
    --     resizable = RESIZABLE
    -- })
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = VYSNC,
        resizable = RESIZABLE,
        fullscreen = FULLSCREEN
    })

    -- For handling the input anywhere inside the code
    love.keyboard.keysPressed = {}
end


-- Called by LOVE2D every frame to update the entities on screen
function love.update(dt)
    -- Update the Timer
    Timer.update(dt)
    
    -- Updating what's in the state-machine
    gStateMachine:update(dt)

    -- Setting keys pressed to empty, to avoid infinitely pressing a key
    love.keyboard.keysPressed = {} 
end


-- Called by LOVE2D for input handling with keyboard
function love.keypressed(key)
    -- For accessing inputs in other function
    love.keyboard.keysPressed[key] = true

    -- Quiting the application if espace is pressed
    if key == 'escape' then
        love.event.quit()
    -- Toggle the fullscreen
    elseif key == 'f' or key == 'f11' then
        FULLSCREEN = not FULLSCREEN
        toggleFullscreen(FULLSCREEN)
    end
end

-- For checking whether a key was pressed or not
function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

-- Called by LOVE2D as an event callback to resizing the window
function love.resize(w, h)
    -- Reset the globals
    WINDOW_WIDTH = w
    WINDOW_HEIGHT = h
    -- push:resize(w, h)
end

-- Called by LOVE2D every frame to render things on the screen
function love.draw()
    -- push:apply('start')
    love.graphics.clear({0, 0, 0, 1})

    love.graphics.setColor({1, 1, 1, 0.5})
    -- Render the background image fitted to the size
    love.graphics.draw(gBackgroundImage, 0, 0)

    -- Rendering the things in State-Machine to the screen
    gStateMachine:render()

    -- Rendering the FPS on screen
    renderFPS(SHOW_FPS)

    -- push:apply('end')
    love.graphics.setColor(COLORS.DEFAULT)
end