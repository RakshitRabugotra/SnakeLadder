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
    ]]
    if(numberOfTiles <= 0) then return end

    -- Let's take a iterative approach

    -- Determine which direction will we move,
    -- if we're on a even 'y' then move right, else left
    local step = (self.y % 2 == 0) and 1 or -1
    io.write("Step: ", step, "\n")
    
    while(step == 1 and self.x <= GRID_N_COLS and numberOfTiles > 0) do
        self.x = self.x + step
        numberOfTiles = numberOfTiles - 1
    end

    while(step == -1 and self.x >= 1 and numberOfTiles > 0) do
        numberOfTiles = numberOfTiles - 1
        self.x = self.x + step
    end

    -- If there are extra tiles left... then move up the row
    -- and repeat the above process
    if(numberOfTiles > 0 or self.x <= 0 or self.x > GRID_N_COLS) then
        self.y = self.y - 1

        -- If we jump out of bounds, then don't do anything
        if(self.y < 1) then return end
        
        if(step > 0) then
            self.x = GRID_N_COLS
        else
            self.x = 1
        end
        -- self.x = self.x - step

        self:move(numberOfTiles)
    end
end

--[[
    Function directly teleporting the piece from one place to other
]]
function Piece:gotoPlace(x, y)
    -- Validate and move the piece
    self.x = x
    self.y = y
end