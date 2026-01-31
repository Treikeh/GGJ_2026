local ball = {
    x = 100,
    y = 100,
    r = 10,
    body,
    shape,
    fixture,
}


function spawnBall()
    ball.body = love.physics.newBody(world, ball.x, ball.y, "dynamic")
    ball.shape = love.physics.newCircleShape(ball.r)
    ball.fixture = love.physics.newFixture(ball.body, ball.shape)
    ball.fixture:setUserData("Ball")
end


function drawBall()
    love.graphics.print(ball.y, 40, 40)

    love.graphics.setColor(1, 1, 1)
    love.graphics.circle("fill", ball.body:getX(), ball.body:getY(), ball.shape:getRadius())
end


function updateBall()
    if ball then
        ball.x, ball.y = ball.body:getPosition()
    end
end