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


function resetTrigger(obstacles)
    randomizeTriggerPos(obstacles)
    trigger.color = getRandomColor()
end


function randomizeTriggerPos(obstacles)
    local obstacle = obstacles[love.math.random(1, #obstacles)]
    local newX = obstacle.pos.x
    local newY = obstacle.pos.y

    if obstacle.type == 1 then
        --
        local dirX, dirY = love.math.random(-obstacle.size.w, obstacle.size.w), love.math.random(-obstacle.size.h, obstacle.size.h)
        newX = newX + dirX
        newY = newY + dirY
    elseif obstacle.type == 2 then
        local dirX, dirY = normalizeVector(love.math.random(-255, 255), love.math.random(-255, 255))
        newX = newX + (dirX * obstacle.radius)
        newY = newY + (dirY* obstacle.radius)
    end

    trigger.x = newX
    trigger.y = newY
    trigger.body:setLinearVelocity(0, 0)
    trigger.body:setPosition(newX, newY)
end


function getRectPosition()
end

function getSpherePosition()
end