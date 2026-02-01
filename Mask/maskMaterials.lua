require "Functionality.mathEx"
require "Functionality.randomize"

function setToMaterialColor(index)
    if index == nil then
        index = currentBrush
    end

    color = maskMaterials[index].color;
    love.graphics.setColor(color.r, color.g, color.b)
end

function addMaterial(name, amount, color)
    table.insert(maskMaterials, {
        name=name,
        usageLeft=amount,
        color=color,
        lineSegments = {}
    })
end

function resetMaterials()
    maskMaterials = {}

    local totalAmount = 3000

    local leftMatAmount = love.math.random(totalAmount /2)
    local upMatAmount = love.math.random(totalAmount /3 * 2 - leftMatAmount)
    local rightMatAmount = love.math.random(totalAmount - leftMatAmount - upMatAmount)

    addMaterial("Left", leftMatAmount, getRandomColor())
    addMaterial("Up", upMatAmount, getRandomColor())
    addMaterial("Right", rightMatAmount, getRandomColor())
end

maskMaterials = {}
resetMaterials()

function getCurrentMaterial()
    return maskMaterials[currentBrush];
end

function getCurrentLineSegments()
    local lineSegments = getCurrentMaterial().lineSegments
    return lineSegments[#lineSegments]
end