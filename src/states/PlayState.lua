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
        self.player[1]:move(numberOfTiles)
    end)

    -- Initializing a jump-object, (can be Ladder or Snake)
    self.jumpObjects = {
        JumpObject {
            startX = 2,
            startY = 1,
    
            endX = 9,
            endY = 9
        },
    }

    -- For debugging only
    self.lastPosX = self.players[1].x
    self.lastPosY = self.players[1].y
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

    -- Render the last position
    love.graphics.setColor(COLORS.GREEN)
    love.graphics.rectangle("line", (self.lastPosX-1)*TILESIZE + offsetX, (self.lastPosY-1)*TILESIZE + offsetY, TILESIZE, TILESIZE, 8, 8)

    -- Render a line between these two boxs
    love.graphics.setLineWidth(2)
    love.graphics.line((self.lastPosX-1)*TILESIZE + offsetX + TILESIZE/2, (self.lastPosY-1)*TILESIZE + offsetY + TILESIZE/2, (self.players[1].x-1)*TILESIZE + offsetX + TILESIZE/2, (self.players[1].y-1)*TILESIZE + offsetY + TILESIZE/2)

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
    -- Render the rectangle
    love.graphics.rectangle("line", (x-1)*width + offsetX, (y-1)*height + offsetY, width, height, 5, 5)
    -- Also put a small text indicating the number of the tile
    love.graphics.setFont(gFonts['small'])
    -- To take care of the order
    local secondDigit = (y % 2 == 0) and (x-1) or (10-x)
    love.graphics.printf(tostring(10-y)..tostring(secondDigit), (x-1)*width + offsetX, (y-1)*height + offsetY, TILESIZE, 'right')
end