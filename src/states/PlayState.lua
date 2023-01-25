--[[
    The state containing the gameplay
]]
PlayState = Class{__includes = BaseState}

function PlayState:enter()
    -- The transition rectangle alpha, for the transition
    self.transitionRectangleAlpha = 1
    Timer.tween(1, {
        [self] = {transitionRectangleAlpha = 0}
    })
end

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
    -- Keep track of the current player
    self.currentPlayer = 1
    self.players = {
        Piece {
            color = COLORS.RED,
            x = 1,
            y = 10
        },
        Piece {
            color = COLORS.BLUE,
            x = 1,
            y = 10
        },
        Piece {
            color = COLORS.YELLOW,
            x = 1,
            y = 10
        },
        Piece {
            color = COLORS.GREEN,
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
        -- If the player is in-transition, then don't move
        if self.players[self.currentPlayer].isInTransition then return end
        -- Get the position of the player after moving it
        local newPos = self.players[self.currentPlayer]:move(numberOfTiles)
        -- Move the player to the new Position
        self.players[self.currentPlayer]:gotoPlace(newPos[1], newPos[2])
        -- Increment the active player accordingly
        self.currentPlayer = (self.currentPlayer + 1 <= 4) and self.currentPlayer + 1 or 1
    end)

    -- Initializing a jump-object, (can be Ladder or Snake)
    self.jumpObjects = JUMP_OBJECTS
end

function PlayState:update(dt)
    -- Update the Dice object (to check for the input)
    self.dice:update(dt)
    
    -- Update all the players
    for i, player in ipairs(self.players) do
        player:update(dt)
        --[[
            If the player's position collides with jump object,
            move it
        ]]
        for i, jumpObject in ipairs(self.jumpObjects) do
            if(jumpObject:collides(player)) then jumpObject:move(player) end
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
    -- First render the snakes
    for i, snake in ipairs(self.jumpObjects) do
        if(snake.id == 'snake') then
            snake:render(offsetX, offsetY)
        end
    end
    -- Then render the ladders
    for i, ladder in ipairs(self.jumpObjects) do
        if(ladder.id == 'ladder') then
            ladder:render(offsetX, offsetY)
        end
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

    love.graphics.setColor({1, 1, 1, self.transitionRectangleAlpha})
    love.graphics.rectangle("fill", 0, 0, WINDOW_WIDTH, WINDOW_HEIGHT)

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

    -- The roundness of the rectangle
    local rectangleRoundness = 12

    -- Render the rectangle
    love.graphics.setColor(tileColor)
    love.graphics.rectangle("fill", (x-1)*width + offsetX, (y-1)*height + offsetY, width, height, rectangleRoundness, rectangleRoundness)

    -- Also put a small text indicating the number of the tile
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(fontColor)
    -- To take care of the order
    love.graphics.printf(tostring(10-y)..tostring(secondDigit), (x-1)*width + offsetX, (y-1)*height + offsetY, TILESIZE, 'right')

    love.graphics.setColor(COLORS.TILE_COLOR_BORDER)
    -- Make a border rectangle
    love.graphics.rectangle("line", (x-1)*width + offsetX, (y-1)*height + offsetY, width, height, rectangleRoundness, rectangleRoundness)
end