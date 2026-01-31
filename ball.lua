local ball = {
    x = 100,
    y = 100,
    r = 10,
    body,
    shape,
    fixture,
    color = {r = 1, g = 1, b = 1}
}


function spawnBall()
    ball.body = love.physics.newBody(world, ball.x, ball.y, "dynamic")
    ball.shape = love.physics.newCircleShape(ball.r)
    ball.fixture = love.physics.newFixture(ball.body, ball.shape)
    ball.fixture:setUserData("Ball")
end


function drawBall()
    love.graphics.print(ball.y, 40, 40)

    love.graphics.setColor(ball.color.r, ball.color.g, ball.color.b)
    love.graphics.circle("fill", ball.body:getX(), ball.body:getY(), ball.shape:getRadius())
end


function updateBall()
    if ball then
        ball.x, ball.y = ball.body:getPosition()
    end

    local outOfX = ball.x < 0 or ball.x > screenWidth
    local outOfY = ball.y < 0 or ball.y > screenHeight
    if outOfX or outOfY then
        changeGameState("reset")
    end
end


function resetBall()
    -- Spawn ball in randon position
    local spawnPadding = 100
    local newX = love.math.random(spawnPadding, screenWidth - spawnPadding)
    local newY = love.math.random(spawnPadding, screenHeight - spawnPadding)
    ball.body:setLinearVelocity(0, 0)
    ball.body:setPosition(newX, newY)

    -- Set ball color to a new random
    --local newR = love.math.random(0, 1)
    --local newG = love.math.random(0, 1)
    --local newB = love.math.random(0, 1)
    --ball.color.r = newR
    --ball.color.g = newG
    --ball.color.b = newB
end