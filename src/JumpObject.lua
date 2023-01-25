--[[
    Represents an entity which can change the
    position of the given player
]]

JumpObject = Class{}

function JumpObject:init(params)
    --[[
        * Required params are
        (start position)
        startX, startY

        (end position)
        endX, endY
    ]]
    self.startX = params.startX
    self.startY = params.startY

    self.endX = params.endX
    self.endY = params.endY

    -- ID of the object
    --[[
        Can be 'ladder' or 'snake'
    ]]
    self.id = params.id
    if(self.id ~= 'ladder' and self.id ~= 'snake') then self.id = 'ladder' end

    -- The dimension of the tiles
    self.width = TILESIZE * 0.75
    self.height = TILESIZE * 0.75
end

function JumpObject:collides(object)
    --[[
        If the object's position collides with start,
        then true
    ]]
    return (object.x == self.startX and object.y == self.startY)
end

function JumpObject:move(object)
    --[[
        Moves the object to the end position of the jump object
    ]]
    -- We will tween the position of object over a period of time
    Timer.tween(1, {
        [object] = {x = self.endX, y = self.endY}
    })
end

function JumpObject:render(renderOffsetX, renderOffsetY)
    --[[
        For now we will render the start position with 'S'
        and end position with 'E'
    ]]
    love.graphics.setFont(gFonts['small'])

    love.graphics.setColor(COLORS.BLACK)
    love.graphics.rectangle("line", (self.startX-1)*TILESIZE + TILESIZE*0.125 + renderOffsetX, (self.startY-1)*TILESIZE + TILESIZE*0.125 + renderOffsetY, self.width, self.height, 8, 8)
    love.graphics.rectangle("line", (self.endX-1)*TILESIZE + TILESIZE*0.125 + renderOffsetX, (self.endY-1)*TILESIZE + TILESIZE*0.125 + renderOffsetY, self.width, self.height, 8, 8)
    
    if(self.id == 'ladder') then
        love.graphics.setColor(COLORS.TILE_COLOR_BORDER)
    else
        love.graphics.setColor(COLORS.DEFAULT)
    end
    love.graphics.printf("S", (self.startX-1)*TILESIZE + renderOffsetX, (self.startY-1)*TILESIZE + renderOffsetY + TILESIZE/2 - 8, TILESIZE, 'center')
    love.graphics.printf("E", (self.endX-1)*TILESIZE + renderOffsetX, (self.endY-1)*TILESIZE + renderOffsetY + TILESIZE/2 - 8, TILESIZE, 'center')

    -- Also render a line between the two ends
    love.graphics.setLineWidth(2)
    love.graphics.line(
        (self.startX-1)*TILESIZE + renderOffsetX + TILESIZE/2, 
        (self.startY-1)*TILESIZE + renderOffsetY + TILESIZE/2,
        (self.endX-1)*TILESIZE + renderOffsetX + TILESIZE/2,
        (self.endY-1)*TILESIZE + renderOffsetY + TILESIZE/2
    )
end