-- For the constants being used in the game
require 'src/constants'

-- The utils modules will handle things, such as quads generation
require 'src/Util'

-- push is a library that will allow us to draw our game at a virtual
-- resolution, instead of however large our window is; used to provide
-- a more retro aesthetic
--
-- https://github.com/Ulydev/push
push = require 'lib/push'

-- the "Class" library we're using will allow us to represent anything in
-- our game as code, rather than keeping track of many disparate variables and
-- methods
--
-- https://github.com/vrld/hump/blob/master/class.lua
Class = require 'lib/class'

-- The kinfe module for timer and tweens, etc
Timer = require 'lib/knife.timer'

-- The states for our state machine
require 'src/StateMachine'
require 'src/states/BaseState'
require 'src/states/StartState'
require 'src/states/PlayState'

-- The entities used in our game
require 'src/Piece'
require 'src/Dice'
require 'src/JumpObject'