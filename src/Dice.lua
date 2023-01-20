--[[
    Implementation of a Dice in lua
]]
Dice = Class{}

function Dice:init(params)
    self.x = params.x
    self.y = params.y
    self.width = TILESIZE * params.sizeFactor
    self.height = TILESIZE * params.sizeFactor

    self.currentNumber = self:rollDie()
end

function Dice:update(dt)
    -- Keyboard bindings for the dice
    if love.keyboard.wasPressed('space') then
        -- Roll the die, generate a random number
        self.currentNumber = self:rollDie()
    end

    io.write("Current Die Number: "..tostring(self.currentNumber).."\n")
end

function Dice:render()
    -- Render the number in beautiful manner
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height, 8, 8)
end

function Dice:rollDie()
    -- Return a random number
    math.randomseed(os.time())
    return math.random(1, 6)
end