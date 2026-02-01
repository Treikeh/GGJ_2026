function getRandomColor()
    local r, g, b = 0, 0, 0
    
    while r + g + b < 0.5 do
        r = love.math.random(0, 255) / 255
        g = love.math.random(0, 255) / 255
        b = love.math.random(0, 255) / 255
    end

    return {r=r, g=g, b=b}
end

function setRandomBG()
    color = getRandomColor()
    love.graphics.setBackgroundColor(color.r, color.g, color.b)
end


function getRandomPosition(screenPadding)
    local x = love.math.random(screenPadding, screenWidth - screenPadding)
    local y = love.math.random(screenPadding, screenHeight - screenPadding)
    return x, y
end

function getRandomSize(min, max)
    local x = love.math.random(min, max)
    local y = love.math.random(min, max)
    return x, y
end