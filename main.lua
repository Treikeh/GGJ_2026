require "Mask.maskToolData"
require "Mask.maskToolDraw"
require "Mask.maskToolUpdate"
require "Mask.maskMaterials"

require "Ball.endTrigger"
require "Ball.ball"

require "UI.mainMenu"
require "UI.resetMenu"
require "UI.gameUI"


screenWidth = 720
screenHeight = 480

local materials = {}

local gameState = {
    menu = false, 
    running = true,
    reset = false,
}


function love.load()
    love.window.setTitle("Weeeee!!")
    love.window.setMode(screenWidth, screenHeight)

    setRandomBG()

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

        drawUI()
    elseif gameState["reset"] then
        drawResetMenu()
    end

end


function love.update(dt)
    maskToolUpdate(dt)
    if gameState["running"] then

        updateBall(maskMaterials)
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
        
        resetKey(key)

    elseif gameState["reset"] then
        resetKey(key)
    end
end

function resetKey(key)
    if key == "r" then
        lineSegments = {}
        resetBall()
        --resetTrigger()
        changeGameState("running")
        setRandomBG()
    end
end



function changeGameState(newState)
    gameState.menu = newState == "menu"
    gameState.running = newState == "running"
    gameState.reset = newState == "reset"
end