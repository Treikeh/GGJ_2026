require "mathEx"

local maskToolPositions = {}  
local maskToolDistances = {}  
local maskToolLength = 1000

local drawing = false

function maskToolInit()
    love.graphics.setLineStyle( "smooth" )
    love.graphics.setLineWidth( 3 )
end

function maskToolUpdate(dt)
    if love.mouse.isDown(1) then
        addLine()
    else
        drawing = false
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

    if distanceFromLastPoint > 5 then
        addLinePoint(mouseX, mouseY, distanceFromLastPoint)
    end

    while sumArray(maskToolDistances) > maskToolLength do
        removeLinePoint()
    end
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
        love.graphics.line(linePositions)
        
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