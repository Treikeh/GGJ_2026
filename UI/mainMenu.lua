local panelPadding = 50

function drawMainMenu()
    -- Background panel
    love.graphics.rectangle("fill", panelPadding, panelPadding, screenWidth - (panelPadding * 2), screenHeight - (panelPadding * 2))

    -- Press start text
    love.graphics.setColor(0, 0, 0)
    local text = love.graphics.newText(love.graphics.getFont(), "Press w to start")
    -- Draw text at the center of the screen
    local textWidth = text:getWidth()
    local textHeight = text:getHeight()
    love.graphics.draw(text, (screenWidth / 2) - (textWidth / 2), (screenHeight / 2) - (textHeight / 2))
end