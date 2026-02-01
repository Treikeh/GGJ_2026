require "Functionality.randomize"

local trigger = {
    x = 100,
    y = 300,
    w = 50,
    h = 50,
    color = {r = 1, g = 1, b = 1}
}

local message = ""


function spawnTrigger()
    trigger.body = love.physics.newBody(world, trigger.x, trigger.y, "static")
    trigger.shape = love.physics.newRectangleShape(trigger.w, trigger.h)
    trigger.fixture = love.physics.newFixture(trigger.body, trigger.shape)
    trigger.fixture:setUserData("Trigger")
    trigger.fixture:setSensor(true)

    trigger.color = getRandomColor()

    world:setCallbacks(beginContact, endContact)
end


function drawTrigger()
    love.graphics.setColor(trigger.color.r, trigger.color.g, trigger.color.b)
    love.graphics.rectangle("fill", trigger.x - trigger.w / 2, trigger.y - trigger.h / 2, trigger.w, trigger.h)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", trigger.x - trigger.w / 2, trigger.y - trigger.h / 2, trigger.w, trigger.h)
    
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
    randomizeTriggerPos()
    trigger.color = getRandomColor()
end


function randomizeTriggerPos()
    local spawnPadding = 100
    local newX = love.math.random(spawnPadding, screenWidth - spawnPadding)
    local newY = love.math.random(spawnPadding, screenHeight - spawnPadding)
    trigger.x = newX
    trigger.y = newY
    trigger.body:setLinearVelocity(0, 0)
    trigger.body:setPosition(newX, newY)
end