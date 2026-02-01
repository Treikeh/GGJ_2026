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
    for i = 1, #maskMaterials, 1 do
        maskMaterials[i].lineSegments = {}
    end    
end

maskMaterials = {}

addMaterial("Space", 1000, getRandomColor())
addMaterial("Bab", 1000, getRandomColor())
addMaterial("ABA", 1000, getRandomColor())

function getCurrentMaterial()
    return maskMaterials[currentBrush];
end

function getCurrentLineSegments()
    local lineSegments = getCurrentMaterial().lineSegments
    return lineSegments[#lineSegments]
end