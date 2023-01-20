--[[
    File containing utilities function
]]

function toggleFullscreen(fullscreen)
    love.window.setFullscreen(fullscreen, 'desktop')
    love.resize(love.graphics.getDimensions())
end

function renderFPS(show_fps)
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print("FPS: "..tostring(love.timer.getFPS()), 4, 4)
    love.graphics.setColor(1, 1, 1, 1)
end