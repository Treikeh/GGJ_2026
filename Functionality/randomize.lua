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