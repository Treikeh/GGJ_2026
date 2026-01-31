require "mathEx"

local maskToolPositions = {}  
local maskToolDistances = {}  
local maskToolLength = 1000

local lineSegments = {}

local POINTDENSITY = 3

local drawing = false

function maskToolInit()
    love.graphics.setLineStyle( "smooth" )
    love.graphics.setLineWidth( 3 )
end

function maskToolUpdate(dt)
    if love.mouse.isDown(1) then
        addLine()
    else
        if #maskToolPositions > 0 and drawing then
            drawing = false 

            splitToPolygons() 
        end
    end
end

function addLine()
    local mouseX, mouseY = love.mouse.getPosition( )
    
    if #maskToolPositions == 0 or not drawing then
        drawing = true
        maskToolPositions = {}  
        maskToolDistances = {}  
        addLinePoint(mouseX, mouseY, 0)
        return
    end
    
    local latestPosition = maskToolPositions[#maskToolPositions]
    local distanceFromLastPoint = distanceBetween(latestPosition.x, latestPosition.y, mouseX, mouseY)

    if distanceFromLastPoint > POINTDENSITY then
        addLinePoint(mouseX, mouseY, distanceFromLastPoint)
    end

    while sumArray(maskToolDistances) > maskToolLength do
        removeLinePoint()
    end
end

function splitToPolygons()
    local linePoints = distanceBetween(
        maskToolPositions[1].x, maskToolPositions[1].y, 
        maskToolPositions[#maskToolPositions].x, maskToolPositions[#maskToolPositions].y
    ) / POINTDENSITY

    for i = 1, linePoints, 1 do
        v = lerpVector(maskToolPositions[1], maskToolPositions[#maskToolPositions], 1+(0.5/linePoints)-(1/linePoints)*i)
        addLinePoint(v.x, v.y, 0)
    end

    local lines = splitToLineSegments(maskToolPositions)
end

function splitToLineSegments(wholeLinePoints)
    local crossPointIndexes = getCrossPointIndexes(wholeLinePoints)
    
    print(#crossPointIndexes)
    print(table.concat(crossPointIndexes, ", "))

    lineSegments = {{}}
    local lineSegmentIndex = 1

    for i = 1, #wholeLinePoints - 1, 1 do

        for j = 1, #crossPointIndexes, 1 do
            if crossPointIndexes[j] == i then
                if #lineSegments[lineSegmentIndex] > 10 then
                    lineSegmentIndex = lineSegmentIndex + 1
                    table.insert(lineSegments, {})
                end

                wholeLinePoints[i] = {x=wholeLinePoints[i + 1].x, y=wholeLinePoints[i + 1].y}
            end
        end
        table.insert(lineSegments[lineSegmentIndex], wholeLinePoints[i])
    end
    
end

function getCrossPointIndexes(linePoints)
    local crossPointIndexes = {}

    local skip = 0

    for i = 2, #linePoints - 1, 1 do
        for j = 2, #linePoints - 1, 1 do

            for k = 1, #crossPointIndexes, 1 do
                if crossPointIndexes[k] < j + 10 and crossPointIndexes[k] > j - 10 then
                    goto continue
                end
            end

            if i < j + 10 and i > j - 10 then
                goto continue
            end
            
            if squareDistance(linePoints[i], linePoints[j]) < POINTDENSITY * 1.9 then
                table.insert(crossPointIndexes, j)
            end

            ::continue::
        end
    end

    return crossPointIndexes
end

function addLinePoint(x, y, distanceFromLastPoint)
    table.insert(maskToolPositions, {x=x, y=y})
    table.insert(maskToolDistances, distanceFromLastPoint)
end

function removeLinePoint()
    table.remove(maskToolPositions, 1)
    table.remove(maskToolDistances, 1)
end

function maskToolDraw()
    local linePositions = convertToIntArray(maskToolPositions)

    if #linePositions >= 4 then
        
        if drawing then
            love.graphics.line(linePositions)
        else
            for i = 1, #lineSegments, 1 do
                -- print("SEGMENT ", i, "LENGTH", #lineSegments[i])
                if #lineSegments[i] > 3 then
                    drawMaskShape(convertToIntArray(lineSegments[i]))
--[[                     love.graphics.setColor(love.math.colorFromBytes(128, 50 * i, 255))
                    love.graphics.line(convertToIntArray(lineSegments[i]))
 ]]                end
            end
            print("")
        end
    end
end

function drawMaskShape(vertices)
    if #maskToolPositions < 3 then return end
    local ok, result = pcall(love.math.triangulate, vertices)

    if not ok then
        -- print("Triangulation error:", result)
        return
    end

    local triangles = result

    for i, triangle_vertices in ipairs(triangles) do
        love.graphics.polygon("fill", triangle_vertices)
    end
end

function convertToIntArray(vector2Array)
    local intArray = {}
    for i = 1, #vector2Array, 1 do
        table.insert(intArray, vector2Array[i].x)
        table.insert(intArray, vector2Array[i].y)
    end

    return intArray
end