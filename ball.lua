local ball = {
    x = 100,
    y = 100,
    r = 10,
}


function spawnBall(world)
    ball.body = love.physics.newBody(world, ball.x, ball.y, "dynamic")
    ball.shape = love.physics.newCircleShape(ball.r)
    ball.fixture = love.physics.newFixture(ball.body, ball.shape)
end


function drawBall()
    love.graphics.print(ball.y, 40, 40)
    love.graphics.circle("fill", ball.x, ball.y, ball.r)
end


function updateBall()
    ball.x, ball.y = ball.body:getPosition()
end


function collisionOnEnter(fixture_a, fixture_b, contact)
    local dx, dy = contact:getNormal()
    local point = {contact:getPositions()}
end