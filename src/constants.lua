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