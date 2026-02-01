require "Mask.maskMaterials"

local cornerRadius = 6
local matSelectWidth = 40
local matSelectHeight = 40

local usageDivider = 500

function drawUI()
    -- Create ui boxes that shows the player which brush they have active
    local totalUsage = 0
    for i = 1, 3 do
        totalUsage = totalUsage + maskMaterials[i].usageLeft
    end

    local xCenter =  (screenWidth / 2)
    local xPos = xCenter - matSelectWidth * (totalUsage / usageDivider) / 2
    local yPos = screenHeight - matSelectHeight * 2 + 20
    
    for i = 1, 3 do
        local color = maskMaterials[i].color
        local usageLeft = maskMaterials[i].usageLeft

        if usageLeft <= 10 then
            goto continue
            return
        end

        love.graphics.setColor(color.r, color.g, color.b)
        -- local xPos = (screenWidth / 3) + (i - 1) * 100

        love.graphics.rectangle("fill", xPos, yPos, matSelectWidth * usageLeft  / usageDivider, matSelectHeight, cornerRadius, cornerRadius)
        -- Select box
        if currentBrush == i then
            love.graphics.setColor(1, 1, 1)
            love.graphics.rectangle("line", xPos, yPos, matSelectWidth * usageLeft  / usageDivider, matSelectHeight, cornerRadius, cornerRadius)

            local text = love.graphics.newText(love.graphics.getFont(), maskMaterials[i].name)
            local textWidth = text:getWidth()
            love.graphics.draw(text, xCenter - textWidth/2, yPos - matSelectHeight + 20)
        end

        -- Material name under the boxes
        --love.graphics.print(maskMaterials[i].name, xPos, yPos + h + 5)

        xPos = xPos + matSelectWidth * (usageLeft / usageDivider)
        ::continue::
    end
    --setToMaterialColor()
    --love.graphics.print(string.format("Current brush: %s", getCurrentMaterial().name), 40, 60)
end