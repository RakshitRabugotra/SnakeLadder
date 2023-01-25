-- The title of the game
GAME_TITLE = "Snakes n Ladders"

-- For debugging
SHOW_FPS = true

--[[
    The window dimensions
]]
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

--[[
    The tilesize information
]]
TILESIZE = 64
GRID_N_COLS = 10
GRID_N_ROWS = 10

--[[
    Constants for the push setup screen function
]]
VSYNC = true
FULLSCREEN = false
RESIZABLE = false

--[[
    The table of colors
]]
COLORS = {
    WHITE = {1, 1, 1, 1},
    RED = {1, 0, 0, 1},
    GREEN = {0, 1, 0, 1},
    BLUE = {0, 0, 1, 1},
    BLACK = {0, 0, 0, 1},
    YELLOW = {1, 1, 0, 1},

    TILE_COLOR_EVEN = {234/255, 219/255, 196/255, 1},
    TILE_COLOR_ODD = {189/255, 160/255, 116/255, 1},
    TILE_COLOR_BORDER = {107/255, 65/255, 37/255, 1},
}

COLORS.DEFAULT = COLORS.WHITE


--[[
    All the jump objects are here
]]
Class = require 'lib/class'
require 'src/JumpObject'

JUMP_OBJECTS = {
    JumpObject {
        startX = 2,
        startY = 1,
        id = 'snake',
        endX = 3,
        endY = 4
    },
    JumpObject {
        startX = 4,
        startY = 1,
        id = 'snake',
        endX = 7,
        endY = 2
    },
    JumpObject {
        startX = 9,
        startY = 1,
        id = 'snake',
        endX = 5,
        endY = 8
    },
    JumpObject {
        startX = 3,
        startY = 2,
        id = 'snake',
        endX = 5,
        endY = 6
    },
    JumpObject {
        startX = 5,
        startY = 2,
        id = 'snake',
        endX = 2,
        endY = 5
    },
    JumpObject {
        startX = 10,
        startY = 2,
        id = 'snake',
        endX = 9,
        endY = 6
    },
    JumpObject {
        startX = 6,
        startY = 3,
        id = 'snake',
        endX = 8,
        endY = 8
    },
    JumpObject {
        startX = 1,
        startY = 5,
        id = 'snake',
        endX = 3,
        endY = 8
    },
    JumpObject {
        startX = 5,
        startY = 5,
        id = 'snake',
        endX = 1,
        endY = 10
    },
    JumpObject {
        startX = 7,
        startY = 5,
        id = 'snake',
        endX = 5,
        endY = 7
    },
    JumpObject {
        startX = 10,
        startY = 5,
        id = 'snake',
        endX = 6,
        endY = 10
    },
    JumpObject {
        startX = 2,
        startY = 7,
        id = 'snake',
        endX = 5,
        endY = 10
    },
    JumpObject {
        startX = 7,
        startY = 8,
        id = 'snake',
        endX = 10,
        endY = 10
    },
    JumpObject {
        startX = 3,
        startY = 9,
        id = 'snake',
        endX = 1,
        endY = 10
    },
    JumpObject {
        startX = 8,
        startY = 10,
        id = 'snake',
        endX = 4,
        endY = 10
    },
    

    --[[
        Ladders on the games
    ]]
    JumpObject {
        endX = 3,
        endY = 1,
        id = 'ladder',
        startX = 1,
        startY = 2,
    },
    JumpObject {
        endX = 10,
        endY = 1,
        id = 'ladder',
        startX = 8,
        startY = 2,
    },
    JumpObject {
        endX = 3,
        endY = 3,
        id = 'ladder',
        startX = 1,
        startY = 3,
    },
    JumpObject {
        endX = 5,
        endY = 3,
        id = 'ladder',
        startX = 4,
        startY = 5,
    },
    JumpObject {
        endX = 7,
        endY = 3,
        id = 'ladder',
        startX = 4,
        startY = 9,
    },
    JumpObject {
        endX = 7,
        endY = 4,
        id = 'ladder',
        startX = 9,
        startY = 6,
    },
    JumpObject {
        endX = 4,
        endY = 7,
        id = 'ladder',
        startX = 2,
        startY = 8,
    },
    JumpObject {
        endX = 7,
        endY = 7,
        id = 'ladder',
        startX = 6,
        startY = 9,
    },
    JumpObject {
        endX = 8,
        endY = 8,
        id = 'ladder',
        startX = 10,
        startY = 9,
    },
    JumpObject {
        endX = 1,
        endY = 9,
        id = 'ladder',
        startX = 3,
        startY = 10,
    },
    JumpObject {
        endX = 7,
        endY = 9,
        id = 'ladder',
        startX = 6,
        startY = 10,
    },
}