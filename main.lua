require "maskTool"
require "endTrigger"
require "ball"
require "mainMenu"
require "resetMenu"
require "materials"

screenWidth = 720
screenHeight = 480

local gameState = {
    menu = false, 
    running = true,
    reset = false,
}



function love.load()
    love.window.setMode(screenWidth, screenHeight)
    love.graphics.setBackgroundColor(0.1, 0, 0)
    maskToolInit()
    
    world = love.physics.newWorld(0, 9.8 * 40, true)

    spawnBall()
    --spawnTrigger()
end


function love.draw()
    -- Reset colour
    love.graphics.setColor(1, 1, 1)

    if gameState["menu"] then
        drawMainMenu()
    elseif gameState["running"] then
        drawMaterials()
        drawBall()
        --drawTrigger()
        maskToolDraw()
    elseif gameState["reset"] then
        drawResetMenu()
    end

end


function love.update(dt)
    if gameState["running"] then
        maskToolUpdate(dt)
        
        updateBall(materials)
        world:update(dt)
    end
end


function love.keypressed(key)
    if gameState["menu"] then
        if key == "w" then
            changeGameState("running")
        end
    elseif gameState["reset"] then
        if key == "r" then
            resetBall()
            --resetTrigger()
            changeGameState("running")
        end
    end
end



function changeGameState(newState)
    gameState.menu = newState == "menu"
    gameState.running = newState == "running"
    gameState.reset = newState == "reset"
end