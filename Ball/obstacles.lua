require "Functionality.randomize"


local spawnPadding = 50

local minSize, maxSize = 20, 200
local obstacles = {}


function spawnObstacles()
    for i = 1, 7 do
        local xPos, yPos = getRandomPosition(spawnPadding)
        local xSize, ySize = getRandomSize(minSize, maxSize)
        local body = love.physics.newBody(world, xPos, yPos, "static")
        local shape = love.physics.newRectangleShape(xSize, ySize)
        local fixture = love.physics.newFixture(body, shape)
        table.insert(obstacles, {
            size = {x = xSize, y = ySize},
            pos = {x = xPos, y = yPos},
            color = getRandomColor(),
            body = body,
            shape = shape,
            fixture = fixture,
        }
        )
    end
end


function drawObstacles()
    for i = 1, #obstacles do
        local xPos, yPos = obstacles[i].pos.x, obstacles[i].pos.y
        local xSize, ySize = obstacles[i].size.x, obstacles[i].size.y
        local color = obstacles[i].color
        love.graphics.setColor(color.r, color.g, color.b)
        love.graphics.rectangle("fill", xPos - xSize / 2, yPos - ySize / 2, xSize, ySize)
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("line", xPos - xSize / 2, yPos - ySize / 2, xSize, ySize)
    end
end



function resetObstacles()
    for i = 1, #obstacles do
        local obstacle = obstacles[i]
        local xPos, yPos = getRandomPosition(spawnPadding)
        local xSize, ySize = getRandomSize(minSize, maxSize)
        local color = getRandomColor()

        obstacle.pos.x = xPos
        obstacle.pos.y = yPos
        obstacle.size.x = xSize
        obstacle.size.y = ySize
        obstacle.color = color


        local shape = love.physics.newRectangleShape(xSize, ySize)
        local fixture = love.physics.newFixture(obstacle.body, shape)

        obstacle.fixture:destroy()
        obstacle.shape = shape
        obstacle.fixture = fixture
        obstacle.body:setPosition(xPos, yPos)
    end
end