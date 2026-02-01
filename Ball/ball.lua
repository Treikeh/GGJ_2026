require "Functionality.mathEx"
require "Functionality.randomize"

local ball = {
    x = 10,
    y = 200,
    r = 10,
    color = {r = 1, g = 1, b = 1},
    matType = 0,
}

function spawnBall()
    ball.body = love.physics.newBody(world, ball.x, ball.y, "dynamic")
    ball.shape = love.physics.newCircleShape(ball.r)
    ball.fixture = love.physics.newFixture(ball.body, ball.shape)
    ball.fixture:setUserData("Ball")

    resetBall()
end

function resetBall()
    randomizeBallPos()
    ball.color = getRandomColor()

    updateBall()
    launchBallTowardsCenter()
end

function drawBall()
    love.graphics.setColor(ball.color.r, ball.color.g, ball.color.b)
    love.graphics.circle("fill", ball.body:getX(), ball.body:getY(), ball.shape:getRadius())
    love.graphics.setColor(1, 1, 1)
    love.graphics.circle("line", ball.body:getX(), ball.body:getY(), ball.shape:getRadius())
end


function updateBall(materials)
    -- Set default parameter
    materials = materials or {}

    -- Update ball x and y position to the balls body position
    ball.x, ball.y = ball.body:getPosition()

    -- Wrap ball back to top or bottom
    if ball.x < 0 then
        ball.body:setPosition(screenWidth - 1, ball.y)
    elseif ball.x > screenWidth then
        ball.body:setPosition(1, ball.y)
    end

    -- Warp ball back to left or right
    if ball.y < 0 then
        ball.body:setPosition(ball.x, screenHeight - 1)
    elseif ball.y > screenHeight then
        ball.body:setPosition(ball.x, 1)
    end

    -- Check which material the ball is inside
    ball.matType = 0 -- Reset so that we can check again every frame
    for i = 1, #materials do
        -- NOTE: Might want to add an if statement to check if matType == 0
        local segmentList = materials[i].lineSegments
        for j = 1, #segmentList, 1 do
            local polygons = segmentList[j]
            isBallInMaterial(polygons, i)
        end
    end

    -- Change physics based on the current material
    if ball.matType == 1 then
        applyLeftMaterial()
    elseif ball.matType == 2 then
        applyUpMaterial()
    elseif ball.matType == 3 then
        applyRightMaterial()
    end
end


function applyUpMaterial()
    ball.body:applyForce(0, -600)
end


function applyLeftMaterial()
    ball.body:applyForce(-500, 0)
end

function applyRightMaterial()
    ball.body:applyForce(500, 0)
end




function randomizeBallPos()
    local spawnPadding = 100
    local newX = love.math.random(spawnPadding, screenWidth - spawnPadding)
    local newY = love.math.random(spawnPadding, screenHeight - spawnPadding)
    ball.body:setLinearVelocity(0, 0)
    ball.body:setPosition(newX, newY)
end


function launchBallTowardsCenter()
    local centerX = screenWidth / 2
    local centerY = screenHeight / 2
    local dirX, dirY = normalizeVector(centerX - ball.x, centerY - ball.y)
    local force = love.math.random(150, 400)
    ball.body:setLinearVelocity(dirX * force, dirY * force)
end



function isBallInMaterial(polygons, matIndex)
    for i = 1, #polygons do
        -- Check if ball is inside a polygon to a material
        if ball.matType == 0 and isBallInPolygon(ball.x, ball.y, polygons[i]) then
            -- Set the matType to the current material
            ball.matType = matIndex
        end
    end
end

function isBallInPolygon(x, y, vertices)
    local result = false
    local len = #vertices
    for i = 1, #vertices do
        local insideX = vertices[i].x < x and vertices[len].x >= x or vertices[len].x < x and vertices[i].x >= x
        if insideX then
            local insideY = (vertices[i].y + (x - vertices[i].x) / (vertices[len].x - vertices[i].x) * (vertices[len].y - vertices[i].y) > y)
            if insideY then
                result = not result
            end
        end
        len = i
    end
    return result
end