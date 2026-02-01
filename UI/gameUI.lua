require "Mask.maskMaterials"

local cornerRadius = 6
local matSelectWidth = 40
local matSelectHeight = 40

function drawUI()
    -- Create ui boxes that shows the player which brush they have active
    for i = 1, 3 do
        local color = maskMaterials[i].color
        love.graphics.setColor(color.r, color.g, color.b)
        local xPos = (screenWidth / 3) + (i - 1) * 100
        local yPos = screenHeight - matSelectHeight * 2
        love.graphics.rectangle("fill", xPos, yPos, matSelectWidth, matSelectHeight, cornerRadius, cornerRadius)

        -- Select box
        if currentBrush == i then
            love.graphics.setColor(1, 1, 1)
            love.graphics.rectangle("line", xPos, yPos, matSelectWidth, matSelectHeight, cornerRadius, cornerRadius)
        end

        -- Material name under the boxes
        local text = love.graphics.newText(love.graphics.getFont(), maskMaterials[i].name)
        local textWidth = text:getWidth()
        love.graphics.draw(text, (xPos + matSelectWidth / 2) - (textWidth / 2), yPos + matSelectHeight + 5)
        --love.graphics.print(maskMaterials[i].name, xPos, yPos + h + 5)
    end
    --setToMaterialColor()
    --love.graphics.print(string.format("Current brush: %s", getCurrentMaterial().name), 40, 60)
end