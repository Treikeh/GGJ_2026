require "Mask.maskMaterials"

local cornerRadius = 6
local matSelectWidth = 40
local matSelectHeight = 40

local usageDivider = 500

local hovering = false
local holding = true

function drawUI()
    -- Create ui boxes that shows the player which brush they have active
    local totalUsage = 0
    for i = 1, 3 do
        totalUsage = totalUsage + maskMaterials[i].usageLeft
    end

    local xCenter =  (screenWidth / 2)
    local xPos = xCenter - matSelectWidth * (totalUsage / usageDivider) / 2
    local yPos = screenHeight - matSelectHeight * 2 + 20

    local mouseX, mouseY = love.mouse.getPosition( )

    hovering = false
    
    local skip = false
    for i = 1, 3 do
        local color = maskMaterials[i].color
        local usageLeft = maskMaterials[i].usageLeft

        if usageLeft > 10 then
            love.graphics.setColor(color.r, color.g, color.b)
            -- local xPos = (screenWidth / 3) + (i - 1) * 100

            local currentWidth = matSelectWidth * usageLeft  / usageDivider

            love.graphics.rectangle("fill", xPos, yPos, currentWidth, matSelectHeight, cornerRadius, cornerRadius)
            -- Select box
            if currentBrush == i then
                love.graphics.setColor(1, 1, 1)
                love.graphics.rectangle("line", xPos, yPos, currentWidth, matSelectHeight, cornerRadius, cornerRadius)

                local text = love.graphics.newText(love.graphics.getFont(), maskMaterials[i].name)
                local textWidth = text:getWidth()
                love.graphics.draw(text, xCenter - textWidth/2, yPos - matSelectHeight + 20)
            end

            if mouseX > xPos and mouseX < xPos + currentWidth then
                if mouseY > yPos and mouseY < yPos + matSelectHeight then
                    if love.mouse.isDown(1) then
                        if not holding then
                            currentBrush = i
                        end
                    else
                        holding = false
                    end

                    hovering = true
                end
            end

            -- Material name under the boxes
            --love.graphics.print(maskMaterials[i].name, xPos, yPos + h + 5)

            xPos = xPos + matSelectWidth * (usageLeft / usageDivider)
        end

    end

    if not hovering and love.mouse.isDown(1) then
        holding = true
    end

    --setToMaterialColor()
    --love.graphics.print(string.format("Current brush: %s", getCurrentMaterial().name), 40, 60)
end