require "maskTool"

function love.load()
    maskToolInit()
end

function love.update(dt)
    maskToolUpdate(dt)
end

function love.draw()
    maskToolDraw()
end