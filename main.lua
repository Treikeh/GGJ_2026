require "maskTool"
require "endTrigger"
require "ball"
require "mainMenu"
require "resetMenu"


screenWidth = 720
screenHeight = 480

local materials = {}

local gameState = {
    menu = false, 
    running = true,
    reset = false,
}


function love.load()
    love.window.setTitle("AAAAAAAHHHHHH!!!!!!")
    love.window.setMode(screenWidth, screenHeight)
    love.graphics.setBackgroundColor(0.1, 0, 0)

    world = love.physics.newWorld(0, 9.8 * 40, true)

    maskToolInit()

    spawnBall()
    --spawnTrigger()
end


function love.draw()
    -- Reset color
    love.graphics.setColor(1, 1, 1)

    if gameState["menu"] then
        drawMainMenu()
    elseif gameState["running"] then
        maskToolDraw()
        --drawTrigger()
        drawBall()

        love.graphics.print(string.format("Current brush: %s", currentBrush), 40, 60)
    elseif gameState["reset"] then
        drawResetMenu()
    end

end


function love.update(dt)
    maskToolUpdate(dt)
    if gameState["running"] then

        -- Set the materials that will be used be the ball
        materials = {
            lineSegments,
        }

        updateBall(materials)
        world:update(dt)
    end
end


function love.keypressed(key)
    if gameState["menu"] then
        if key == "w" then
            changeGameState("running")
        end
    elseif gameState["running"] then
        if key == "1" then currentBrush = 1 end
        if key == "2" then currentBrush = 2 end
        if key == "3" then currentBrush = 3 end
    elseif gameState["reset"] then
        if key == "r" then
            lineSegments = {}
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