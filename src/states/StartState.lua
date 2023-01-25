--[[
    The start state containing menus and title screen
]]
StartState = Class{__includes = BaseState}

function StartState:init()
    self.highlighted = 1
end

function StartState:update(dt)
    if love.keyboard.wasPressed('up') then
        self.highlighted = (self.highlighted > 1) and self.highlighted - 1 or 2
        gSounds['select']:play()
    elseif love.keyboard.wasPressed('down') then
        self.highlighted = (self.highlighted < 2) and self.highlighted + 1 or 1
        gSounds['select']:play()
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        if self.highlighted == 1 then
            -- Change to Gameplay state
            gSounds['confirm']:play()
            -- Transition to the playing state
            gStateMachine:change('play', {})
        
        elseif self.highlighted == 2 then
            -- Quit the game
            gSounds['confirm']:play()
            love.event.quit()
        end
    end
end


function StartState:render()
    --[[
        For rendering our main menu
    ]]
    love.graphics.setFont(gFonts['medium'])

    if self.highlighted == 1 then
        love.graphics.setColor(0, 255/255, 255/255, 1)
    end

    love.graphics.printf("START", 0, WINDOW_HEIGHT*0.75 - 28, WINDOW_WIDTH, 'center')

    -- Reset the color back to white
    love.graphics.setColor(1, 1, 1, 1)

    if self.highlighted == 2 then
        love.graphics.setColor(0, 1, 1, 1)
    end

    love.graphics.printf("QUIT GAME", 0, WINDOW_HEIGHT*0.75 + 28, WINDOW_WIDTH, 'center')
end
