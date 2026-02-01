require "Functionality.randomize"


local spawnPadding = 50

local minObstacles, maxObstacles = 7, 9
obstacles = {}

local rectMinSize, rectMaxSize = 20, 200
local minRadius, maxRadius = 20, 100



function spawnObstacles()
    msg = ""
    for i = 1, love.math.random(minObstacles, maxObstacles) do
        local type = getRandomObstacleType()
        if type == 1 or type == 3 then
            createRectangleObstacle()
        elseif type == 2 then
            createSphereObstalce()
        end
    end
end


function drawObstacles()
    for i = 1, #obstacles do
        local obstacle = obstacles[i]
        if obstacle.type == 1 then
            drawRectObstacle(obstacle)
        elseif obstacle.type == 2 then
            drawSphereObstacle(obstacle)
        end
    end
end



function resetObstacles()
    destoryObstacles()
    obstacles = {}
    spawnObstacles()
end


function destoryObstacles()
    for i = 1, #obstacles do
        local obstacle = obstacles[i]
        obstacle.fixture:destroy()
        obstacle.body:destroy()
        obstacle.shape:destroy()
    end
end


function getRandomObstacleType()
    return love.math.random(1, 3)
end


-- RECTANGLE
function createRectangleObstacle()
        local x, y = getRandomPosition(spawnPadding)
        local w, h = getRandomSize(rectMinSize, rectMaxSize)
        local body = love.physics.newBody(world, x, y, "static")
        local shape = love.physics.newRectangleShape(w, h)
        local fixture = love.physics.newFixture(body, shape)
        -- Insert obstacle into table
        table.insert(obstacles, {
            type = 1,
            pos = {x = x, y = y},
            size = {w = w, h = h},
            color = getRandomColor(),
            body = body,
            shape = shape,
            fixture = fixture,
        }
        )
end


function drawRectObstacle(rect)
    local x, y = rect.pos.x, rect.pos.y
    local w, h = rect.size.w, rect.size.h
    local color = rect.color
    love.graphics.setColor(color.r, color.g, color.b)
    love.graphics.rectangle("fill", x - w / 2, y - h / 2, w, h)
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("line", x - w / 2, y - h / 2, w, h)
end


-- SPHERE
function createSphereObstalce()
    local x, y = getRandomPosition(spawnPadding)
    local r = love.math.random(minRadius, maxRadius)
    local body = love.physics.newBody(world, x, y, "static")
    local shape = love.physics.newCircleShape(r)
    local fixture = love.physics.newFixture(body, shape)
    -- Insert obstacle into table
        table.insert(obstacles, {
            type = 2,
            pos = {x = x, y = y},
            radius = r,
            color = getRandomColor(),
            body = body,
            shape = shape,
            fixture = fixture,
        }
        )
end


function drawSphereObstacle(sphere)
    local x, y = sphere.pos.x, sphere.pos.y
    local r = sphere.radius
    local color = sphere.color
    love.graphics.setColor(color.r, color.g, color.b)
    love.graphics.circle("fill", x, y, r)
    love.graphics.setColor(0, 0, 0)
    love.graphics.circle("line", x, y, r)
end