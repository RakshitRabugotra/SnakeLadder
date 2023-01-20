--[[
    The state containing the gameplay
]]
PlayState = Class{__includes = BaseState}

function PlayState:init()

    -- Instantiate a 2D array definning the positions the player can get to
    gBoard = {}

    for row = 1, 10 do
        column = {}
        for col = 1, 10 do
            table.insert(column, 0)
        end
        table.insert(gBoard, column)
    end

    --[[
        Instantiate a playing piece
    ]]
    gPlayer = Piece {
        color = COLORS.RED,
        x = 1,
        y = 1
    }

    --[[
        Instantiate a Dice object
    ]]
    gDice = Dice {
        x = 0,
        y = 0,
        sizeFactor = 2.75
    }
end

function PlayState:update(dt)
    gDice:update(dt)
    gPlayer:update(dt)
end

function PlayState:render()
    love.graphics.setFont(gFonts["medium"])

    -- Get the offset of the tiles
    local offsetX = (WINDOW_WIDTH - TILESIZE * GRID_N_COLS)/2
    local offsetY = (WINDOW_HEIGHT - TILESIZE * GRID_N_ROWS)/2

    -- Iterate over the board and render the boxs
    for r, row in ipairs(gBoard) do
        for c, element in ipairs(row) do
            renderBlock(r, c, TILESIZE, TILESIZE, offsetX, offsetY)

            --[[
                Check and render players
            ]]
            if c == gPlayer.x and r == gPlayer.y then
                gPlayer:render(offsetX, offsetY)    
            end
        end
    end

    -- Render the dice over the board (if overlapping)

    -- Calculate the position of the dice
    gDice.x = (offsetX - gDice.width)/2
    gDice.y = (WINDOW_HEIGHT - gDice.height)/2 
    gDice:render()

    -- love.graphics.printf("PLAY STATE", 0, VIRTUAL_HEIGHT*0.5-16, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor({1, 1, 1, 1})
end


--[[
    Util functions
]]
function renderBlock(x, y, width, height, offsetX, offsetY)
    love.graphics.rectangle("line", (x-1)*width + offsetX, (y-1)*height + offsetY, width, height, 5, 5)
end