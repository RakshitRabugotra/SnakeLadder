Piece = Class{}

function Piece:init(params)
    --[[
        Required params are:
        -> color
        -> x, y
    ]]
    self.color = params.color
    self.width = TILESIZE * 0.75 
    self.height = TILESIZE * 0.75
    self.x = params.x
    self.y = params.y
end

function Piece:update(dt)
    --[[
        The movement controls for the piece lie here!
    ]]
    if love.keyboard.wasPressed('w') then
        self.y = self.y - 1
    elseif love.keyboard.wasPressed('s') then
        self.y = self.y + 1
    elseif love.keyboard.wasPressed('a') then
        self.x = self.x - 1
    elseif love.keyboard.wasPressed('d') then
        self.x = self.x + 1
    end

    --[[
        Clamp these values to be within the board
    ]]
    self.x = math.min(GRID_N_COLS, math.max(1, self.x))
    self.y = math.min(GRID_N_ROWS, math.max(1, self.y))
end

function Piece:render(offsetX, offsetY)
    --[[
        Render the piece according to the color
    ]]
    love.graphics.setColor(self.color)
    love.graphics.rectangle("line", (self.x-1)*TILESIZE + offsetX + TILESIZE*0.125, (self.y-1)*TILESIZE + offsetY + TILESIZE*0.125, self.width, self.height, 4, 4)
    love.graphics.setColor(COLORS.DEFAULT)
end

--[[
    Function to telling the piece to move places
]]
function Piece:move(numberOfTiles)
    --[[
        We need a function which moves the Piece correctly
        this function should return the correct landing coordinates of the piece
    ]]
    -- Make temp position variables
    local posX, posY = self.x, self.y
    
    if(numberOfTiles <= 0) then
        return {posX, posY}
    end
    -- Let's take a iterative approach

    -- Determine which direction will we move,
    -- if we're on a even 'y' then move right, else left
    local step = (self.y % 2 == 0) and 1 or -1
    
    while(step == 1 and posX <= GRID_N_COLS and numberOfTiles > 0) do
        posX = posX + step
        numberOfTiles = numberOfTiles - 1
    end

    while(step == -1 and posX >= 1 and numberOfTiles > 0) do
        numberOfTiles = numberOfTiles - 1
        posX = posX + step
    end

    -- If there are extra tiles left... then move up the row
    -- and repeat the above process
    if(numberOfTiles > 0 or posX <= 0 or posX > GRID_N_COLS) then
        posY = posY - 1

        -- If we jump out of bounds, then don't do anything
        if(posY < 1) then
            posY = 1
            return {posX, posY}
        end
        
        if(step > 0) then
            posX = GRID_N_COLS
        else
            posX = 1
        end

        -- Move to this position before calculating the new move
        -- As this function will update the self.x and self.y
        self:gotoPlace(posX, posY)
        return self:move(numberOfTiles)
    end

    return {posX, posY}
end

--[[
    Function directly teleporting the piece from one place to other
]]
function Piece:gotoPlace(newX, newY)
    -- Validate and move the piece
    Timer.tween(0.25, {
        [self] = {x = newX, y = newY}
    })
end