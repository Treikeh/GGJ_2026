local trigger = {
    x = 100,
    y = 300,
    w = 80,
    h = 40,
    body,
    shape,
    fixture,
}

local message = ""


function spawnTrigger()
    trigger.body = love.physics.newBody(world, trigger.x, trigger.y, "static")
    trigger.shape = love.physics.newRectangleShape(trigger.w, trigger.h)
    trigger.fixture = love.physics.newFixture(trigger.body, trigger.shape)
    trigger.fixture:setUserData("Trigger")
    trigger.fixture:setSensor(true)

    world:setCallbacks(beginContact, endContact)
end


function drawTrigger()
    love.graphics.setColor(1, 0, 0)
    love.graphics.polygon("fill", trigger.body:getWorldPoints(trigger.shape:getPoints()))
    
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(message, 40, 100)
end



function beginContact(fixtureA, fixtureB, contact)
    local tag1, tag2 = fixtureA:getUserData(), fixtureB:getUserData()

    if tag1 == "Trigger" and tag2 == "Ball" then
        message = tag1 .. " collided with " .. tag2
        changeGameState("reset")
    end
end


function endContact(fixtureA, fixtureB, contact)
    local tag1, tag2 = fixtureA:getUserData(), fixtureB:getUserData()

    if tag1 == "Trigger" and tag2 == "Ball" then
        message = ""
    end
end


function resetTrigger()
    -- Spawn trigger in new position
    local spawnPadding = 100
    local newX = love.math.random(spawnPadding, screenWidth - spawnPadding)
    local newY = love.math.random(spawnPadding, screenHeight - spawnPadding)
    trigger.body:setLinearVelocity(0, 0)
    trigger.body:setPosition(newX, newY)
end