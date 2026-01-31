function distanceBetween(x1, y1, x2, y2)
    local dx = x2 - x1
    local dy = y2 - y1
    return math.sqrt(dx * dx + dy * dy)
end

function squareDistance(aV, bV)
    return math.abs(aV.x - bV.x) + math.abs(aV.y - bV.y)
end

function sumArray(numberArray)
    local sum = 0
    for i = 1, #numberArray, 1 do
        sum = sum + numberArray[i]
    end

    return sum
end

function convertToIntArray(vector2Array)
    local intArray = {}
    for i = 1, #vector2Array, 1 do
        table.insert(intArray, vector2Array[i].x)
        table.insert(intArray, vector2Array[i].y)
    end

    return intArray
end

function normalizeVector(x, y)
    local length = math.sqrt(x^2 + y^2)
    local newX = x / length
    local newY = y / length
    return newX, newY
end

function lerpVector(aV, bV, t)
    local lerpedVector = {x=0, y=0}

    lerpedVector.x = lerp(aV.x, bV.x, t)
    lerpedVector.y = lerp(aV.y, bV.y, t)

    return lerpedVector
end

function lerp(a, b, t)
    return a + (b - a) * t
end