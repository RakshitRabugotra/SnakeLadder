--[[
    Implementation of a Dice in lua
]]
Dice = Class{}

function Dice:init()
    self.x = 0
    self.y = 0
    self.width = TILESIZE * 2.75
    self.height = TILESIZE * 2.75

    -- Initialize the dice number to be something not feasible
    -- so we can know, that the game hasn't started yet
    self.currentNumber = -1
    self.callback = function() return end
end

function Dice:update(dt)
    -- Keyboard bindings for the dice
    if love.keyboard.wasPressed('space') then
        -- Roll the die, generate a random number
        self.currentNumber = self:rollDie()
        self.callback(self.currentNumber)
    end

    -- io.write("Current Die Number: "..tostring(self.currentNumber).."\n")
end

function Dice:render()
    -- Render the number in beautiful manner
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height, 8, 8)
    -- Show the current number of dice in it
    love.graphics.setFont(gFonts['medium'])
    love.graphics.print(tostring(self.currentNumber), self.x + self.width/2, self.y + self.height/2 - 16)
end

--[[
    To generate a new random number
]]
function Dice:rollDie()
    -- Return a random number
    math.randomseed(os.time())
    self.currentNumber = math.random(1, 6)
    return self.currentNumber
end

--[[
    A function which takes callback function,
    and provides it with the random number generated right now
]]
function Dice:onRollCall(callback)
    self.callback = callback
end
