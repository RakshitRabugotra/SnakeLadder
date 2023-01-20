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

    io.write("Current player position: "..tostring(self.x).."/"..tostring(self.y).."\n")
end

function Piece:render(offsetX, offsetY)
    --[[
        Render the piece according to the color
    ]]
    love.graphics.setColor(self.color)
    love.graphics.rectangle("line", (self.x-1)*TILESIZE + offsetX + TILESIZE*0.15, (self.y-1)*TILESIZE + offsetY + TILESIZE*0.15, self.width, self.height, 4, 4)
    love.graphics.setColor(COLORS.DEFAULT)
end