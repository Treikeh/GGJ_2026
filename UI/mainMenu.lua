local cornerRadius = 15
local panelPadding = 50

function drawMainMenu()
    -- Background panel
    love.graphics.setColor(BGColor.r, BGColor.g, BGColor.b)
    local width = screenWidth - (panelPadding * 2)
    local height = screenHeight - (panelPadding * 2)
    love.graphics.rectangle("fill", panelPadding, panelPadding, width, height, cornerRadius, cornerRadius)

    -- Press start text
    love.graphics.setColor(TextColor.r, TextColor.g, TextColor.b)

    randomKey = getRandomKey()

    local startText = "Press " .. randomKey .. " to start"

    local LOVEFont = love.graphics.newFont(1000/#startText)
    love.graphics.setFont(LOVEFont)
    local text = love.graphics.newText(love.graphics.getFont(), startText)
    love.graphics.setFont(defaultFont)

    -- Draw text at the center of the screen
    local textWidth = text:getWidth()
    local textHeight = text:getHeight()
    love.graphics.draw(text, (screenWidth / 2) - (textWidth / 2), (screenHeight / 2) - (textHeight / 2))
end

function getRandomKey()
    local letters = "abcdefghijklmnopqrstuvwxyz"

    local i = love.math.random(#letters)
    return string.sub(letters,i,i)
end