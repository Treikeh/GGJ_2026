require "Functionality.mathEx"
require "Mask.maskMaterials"
require "Mask.maskToolData"

function maskToolDraw()
    love.graphics.setColor(0, 1, 0)
    local linePositions = convertToIntArray(maskToolPositions)

    setToMaterialColor()
    drawMasks()
    if #linePositions >= 4 then
        if drawing then
            love.graphics.line(linePositions)
        end
    end
end

function drawMasks()
    for i = 1, #maskMaterials, 1 do
        for j = 1, #maskMaterials[i].lineSegments, 1 do
            local lineSegments = maskMaterials[i].lineSegments[j]

            if lineSegments == nil then
                return
            end

            for k = 1, #lineSegments, 1 do
                if #lineSegments[k] > 3 then
                    setToMaterialColor(i)
                    drawMaskShape(convertToIntArray(lineSegments[k]))

                    love.graphics.setColor(0, 0, 0)
                    love.graphics.line(convertToIntArray(lineSegments[k]))
                end 
            end
        end
    end
end

function drawMaskShape(vertices)
    if #vertices < 3 then return end
    local ok, triangles = pcall(love.math.triangulate, vertices)

    if not ok then
        return
    end

    for i, triangle_vertices in ipairs(triangles) do
        love.graphics.polygon("fill", triangle_vertices)
    end
end