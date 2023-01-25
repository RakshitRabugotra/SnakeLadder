--[[
    The state containing the gameplay
]]
PlayState = Class{__includes = BaseState}

function PlayState:init()
    --[[
        Instantiate a 2D array definning the positions the player can get to
    ]]
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
    self.players = {
        Piece {
            color = COLORS.RED,
            x = 1,
            y = 10
        }
    }

    --[[
        Instantiate a Dice object
    ]]
    self.dice = Dice{}

    -- Set the die to move player on every roll
    self.dice:onRollCall(function(numberOfTiles)
        pos = self.players[1]:move(numberOfTiles)
        io.write("new Position: X/Y:", pos[1], "/", pos[2], "\n")
        self.players[1]:gotoPlace(pos[1], pos[2])
    end)

    -- Initializing a jump-object, (can be Ladder or Snake)
    self.jumpObjects = {
        JumpObject {
            startX = 2,
            startY = 1,
    
            endX = 2,
            endY = 10
        },
    }
end

function PlayState:update(dt)
    -- Update the Dice object (to check for the input)
    self.dice:update(dt)
    
    local x = self.players[1].x
    local y = self.players[1].y
    -- For debugging purpose only
    if love.keyboard.wasPressed('space') then
        self.lastPosX = x
        self.lastPosY = y
    end
    
    -- Update all the players
    for i, player in ipairs(self.players) do
        player:update(dt)
        --[[
            If the player's position collides with jump object,
            move it
        ]]
        for i, jumpObject in ipairs(self.jumpObjects) do
            if(jumpObject:collides(player)) then
                jumpObject:move(player)
                -- Timer.tween(2, {
                    -- [player] = {x = jumpObject.endX, y = jumpObject.endY}
                -- })
            end
        end
    end
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
        end
    end

    --[[
        Render the Ladders n Snakes
    ]]
    for i, jumpObject in ipairs(self.jumpObjects) do
        jumpObject:render(offsetX, offsetY)
    end

    --[[
        Render the players
    ]]
    for i, player in ipairs(self.players) do
        player:render(offsetX, offsetY)
    end

    -- Render the dice over the board (if overlapping)
    -- Calculate the position of the dice
    self.dice.x = (offsetX - self.dice.width)/2
    self.dice.y = (WINDOW_HEIGHT - self.dice.height)/2 
    self.dice:render()

    -- Set the Color of the screen to Default
    love.graphics.setColor(COLORS.DEFAULT)
end


--[[
    Util functions
]]
function renderBlock(x, y, width, height, offsetX, offsetY)
    local secondDigit = (y % 2 == 0) and (x-1) or (10-x)
    local tileColor = (y % 2 == 0) and COLORS.TILE_COLOR_EVEN or COLORS.TILE_COLOR_ODD
    local fontColor = (y % 2 == 0) and COLORS.TILE_COLOR_ODD or COLORS.TILE_COLOR_EVEN

    -- Render the rectangle
    love.graphics.setColor(tileColor)
    love.graphics.rectangle("fill", (x-1)*width + offsetX, (y-1)*height + offsetY, width, height, 5, 5)

    -- Also put a small text indicating the number of the tile
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(fontColor)
    -- To take care of the order
    love.graphics.printf(tostring(10-y)..tostring(secondDigit), (x-1)*width + offsetX, (y-1)*height + offsetY, TILESIZE, 'right')

    love.graphics.setColor(COLORS.TILE_COLOR_BORDER)
    -- Make a border rectangle
    love.graphics.rectangle("line", (x-1)*width + offsetX, (y-1)*height + offsetY, width, height, 5, 5)
end