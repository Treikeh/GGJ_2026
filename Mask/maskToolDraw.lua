require "Functionality.mathEx"
require "Mask.maskMaterials"
require "Mask.maskToolData"

function maskToolDraw()
    love.graphics.setColor(0, 1, 0)
    local linePositions = convertToIntArray(maskToolPositions)

    if #linePositions >= 4 then
        
        setToMaterialColor()
        if drawing then
            love.graphics.line(linePositions)
        end
        drawMasks()
    end
end

function drawMasks()
    for i = 1, #maskMaterials, 1 do
        for j = 1, #maskMaterials[i].lineSegments, 1 do
            if #maskMaterials[i].lineSegments[j] > 3 then
                setToMaterialColor(i)
                drawMaskShape(convertToIntArray(maskMaterials[i].lineSegments[j]))

                love.graphics.setColor(0, 0, 0)
                love.graphics.line(convertToIntArray(maskMaterials[i].lineSegments[j]))
            end 
        end

    end
end

function drawMaskShape(vertices)
    if #maskToolPositions < 3 then return end
    local ok, triangles = pcall(love.math.triangulate, vertices)

    if not ok then
        return
    end

    for i, triangle_vertices in ipairs(triangles) do
        love.graphics.polygon("fill", triangle_vertices)
    end
end