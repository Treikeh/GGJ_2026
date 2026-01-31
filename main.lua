require "maskTool"
require "ball"

local world = love.physics.newWorld(0, 9.8 * 40, true)

function love.load()
    maskToolInit()
    spawnBall(world)
    world:setCallbacks(collisionOnEnter)
end

function love.draw()
    drawBall()
    maskToolDraw()
end

function love.update(dt)
    maskToolUpdate(dt)
    updateBall(dt)
    world:update(dt)
end