function distanceBetween(x1, y1, x2, y2)
    local dx = x2 - x1
    local dy = y2 - y1
    return math.sqrt(dx * dx + dy * dy)
end

function sumArray(numberArray)
    local sum = 0
    for i = 1, #numberArray, 1 do
        sum = sum + numberArray[i]
    end

    return sum
end