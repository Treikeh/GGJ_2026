local cornerRadius = 15
local panelPadding = 50

function drawMainMenu()
    -- Background panel
    local width = screenWidth - (panelPadding * 2)
    local height = screenHeight - (panelPadding * 2)
    love.graphics.rectangle("fill", panelPadding, panelPadding, width, height, cornerRadius, cornerRadius)

    -- Press start text
    love.graphics.setColor(0, 0, 0)
    local text = love.graphics.newText(love.graphics.getFont(), "Press w to start")
    -- Draw text at the center of the screen
    local textWidth = text:getWidth()
    local textHeight = text:getHeight()
    love.graphics.draw(text, (screenWidth / 2) - (textWidth / 2), (screenHeight / 2) - (textHeight / 2))
end