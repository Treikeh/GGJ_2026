local cornerRadius = 15
local panelPadding = 50

function drawMainMenu()
    -- Press start text
    love.graphics.setColor(TextColor.r, TextColor.g, TextColor.b)

    randomKey = getRandomKey()

    local LOVEFont = love.graphics.newFont(100)
    love.graphics.setFont(LOVEFont)
    local text = love.graphics.newText(love.graphics.getFont(), "Khe Tiss")
    local textWidth = text:getWidth()
    local textHeight = text:getHeight()
    love.graphics.draw(text, (screenWidth / 2) - (textWidth / 2), 0 + 75)

    local startText = "Press " .. randomKey .. " to start"

    local LOVEFont = love.graphics.newFont(1000/#startText)
    love.graphics.setFont(LOVEFont)
    local text = love.graphics.newText(love.graphics.getFont(), startText)

    -- Draw text at the center of the screen
    local textWidth = text:getWidth()
    local textHeight = text:getHeight()
    love.graphics.draw(text, (screenWidth / 2) - (textWidth / 2), (screenHeight / 2) - (textHeight / 2))


    local LOVEFont = love.graphics.newFont(30)
    love.graphics.setFont(LOVEFont)
    local text = love.graphics.newText(love.graphics.getFont(), "Press R to restart")
    -- Draw text at the center of the screen

    local textWidth = text:getWidth()
    local textHeight = text:getHeight()
    love.graphics.draw(text, (screenWidth / 2) - (textWidth / 2), (screenHeight / 1.5) - (textHeight / 2))

    love.graphics.setFont(defaultFont)
end


function updateMainMenu(dt)
    time = time + dt
end

function getRandomKey()
    local letters = "abcdefghijklmnopqrstuvwxyz"

    local i = love.math.random(#letters)
    return string.sub(letters,i,i)
end