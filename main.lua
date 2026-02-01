require "Mask.maskToolData"
require "Mask.maskToolDraw"
require "Mask.maskToolUpdate"
require "Mask.maskMaterials"

require "Ball.endTrigger"
require "Ball.ball"
require "Ball.obstacles"

require "UI.mainMenu"
require "UI.resetMenu"
require "UI.gameUI"

time = 0
screenWidth = 720
screenHeight = 480

local gravityForce = 400
local materials = {}

local winTimer = 0

local gameState = {
    menu = true, 
    running = false,
    reset = false,
}


function love.load()
    love.window.setTitle("Khe Tiss")
    love.window.setMode(screenWidth, screenHeight)

    defaultFont = love.graphics.newFont(12)

    BGColor = getRandomColor()
    TextColor = getRandomColor()

    createShader()
    setRandomBG()

    world = love.physics.newWorld(0, gravityForce, true)
    world:setSleepingAllowed(false)

    maskToolInit()

    spawnBall()
    spawnObstacles()
    spawnTrigger(obstacles)

end


function love.draw()
    -- Reset color
    love.graphics.setColor(1, 1, 1)

    if gameState["menu"] then
        drawMainMenu()
    elseif gameState["running"] then
        maskToolDraw()
        drawObstacles()
        drawTrigger()
        drawBall()

        drawUI()
    elseif gameState["reset"] then
        drawResetMenu()
    end

end


function love.update(dt)
    time = time + dt
    maskToolUpdate(dt)
    if gameState["running"] then

        updateBall(maskMaterials)
        world:update(dt)
    elseif gameState["reset"] then
        
        winTimer = winTimer + dt

        if winTimer > 1 then
            resetGame()
        end
    end
end


function love.keypressed(key)
    if gameState["menu"] then
        resetGame()
    
    elseif gameState["running"] then
        if key == "1" then currentBrush = 1 end
        if key == "2" then currentBrush = 2 end
        if key == "3" then currentBrush = 3 end

        if key == "a" then currentBrush = 1 end
        if key == "w" then currentBrush = 2 end
        if key == "d" then currentBrush = 3 end
        
        if key == "r" then
            winQuote = getRandomLoseQuote()
            changeGameState("reset")
        end

        if key == "y" then
            changeGameState("reset")
        end

    elseif gameState["reset"] then
        resetGame()
    end
end

function love.wheelmoved(x, y)
    if y > 0 then
        currentBrush = currentBrush - 1
        if currentBrush < 1 then
            currentBrush = 3
        end
    elseif y < 0 then
        currentBrush = currentBrush + 1
        if currentBrush > 3 then
            currentBrush = 1
        end
    end
end

function resetGame()
    lineSegments = {}
    resetBall()
    resetObstacles()
    resetTrigger(obstacles)
    changeGameState("running")
    setRandomBG()
    resetMaterials()
    loadResetMenu()

    winTimer = 0
end



function changeGameState(newState)
    gameState.menu = newState == "menu"
    gameState.running = newState == "running"
    gameState.reset = newState == "reset"
end