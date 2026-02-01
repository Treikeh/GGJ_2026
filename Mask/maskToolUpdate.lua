require "Functionality.mathEx"
require "Mask.maskMaterials"
require "Mask.maskToolData"

function maskToolInit()
    love.graphics.setLineStyle( "smooth" )
    love.graphics.setLineWidth( 3 )
end

local holdingM2 = false

function maskToolUpdate(dt)
    if love.mouse.isDown(1) then
        addLine()
    else
        if #maskToolPositions > 0 and drawing then
            drawing = false

            splitToPolygons() 
        end
    end

    checkSwapBrush()
end

function checkSwapBrush()
    if love.mouse.isDown(2) then
        if not holdingM2 then
            currentBrush = currentBrush + 1
            if currentBrush > #maskMaterials then
                currentBrush = 1
            end
        end

        holdingM2 = true
    else
        holdingM2 = false
    end
end

function addLine()
    local mouseX, mouseY = love.mouse.getPosition( )
    
    if #maskToolPositions == 0 or not drawing then
        initializeDrawing()
        return
    end
    
    local latestPosition = maskToolPositions[#maskToolPositions]
    local distanceFromLastPoint = distanceBetween(latestPosition.x, latestPosition.y, mouseX, mouseY)

    if distanceFromLastPoint > POINTDENSITY then
        addLinePoint(mouseX, mouseY, distanceFromLastPoint)
    end

    -- Remove oldest points if line is too long
    while sumArray(maskToolDistances) > getCurrentMaterial().usageLeft do
        removeLinePoint()
    end
end

function initializeDrawing()
    drawing = true

    local mouseX, mouseY = love.mouse.getPosition( )

    table.insert(getCurrentMaterial().lineSegments, {{}})
    maskToolPositions = {}  
    maskToolDistances = {}  
    addLinePoint(mouseX, mouseY, 0)
end

function splitToPolygons()

    -- Amount of points to be placed between start and end of selection
    local linePoints = distanceBetween(
        maskToolPositions[1].x, maskToolPositions[1].y, 
        maskToolPositions[#maskToolPositions].x, maskToolPositions[#maskToolPositions].y
    ) / POINTDENSITY

    -- Placing points in a line equally spaced between end and start 
    for i = 1, linePoints, 1 do
        v = lerpVector(maskToolPositions[#maskToolPositions], maskToolPositions[1], (1/linePoints)*i)
        addLinePoint(v.x, v.y, 0)
    end

    local lines = splitToLineSegments(maskToolPositions)
end

function splitToLineSegments(wholeLinePoints)
    local crossPointIndexes = getCrossPointIndexes(wholeLinePoints)
    
    print(#crossPointIndexes)
    print(table.concat(crossPointIndexes, ", "))

    local lineSegmentIndex = 1
    local currentSegments = 0

    -- Add points to line segments, splitting into new lines at each cross point
    for i = 1, #wholeLinePoints - 1, 1 do

        for j = 1, #crossPointIndexes, 1 do

            -- Cross point reached, split into new line
            if crossPointIndexes[j] == i then

                if currentSegments > 10 then
                    lineSegmentIndex = lineSegmentIndex + 1
                    currentSegments = 0

                    -- Current material -> Current line segments -> Add a new set of segments
                    table.insert(getCurrentMaterial().lineSegments[#getCurrentMaterial().lineSegments], {})
                end
                
            end
        end

        currentSegments = currentSegments + 1
        -- Current material -> Current line segments -> Current line segment -> Add point to segment
        table.insert(getCurrentMaterial().lineSegments[#getCurrentMaterial().lineSegments][lineSegmentIndex], wholeLinePoints[i])
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