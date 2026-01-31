require "Mask.maskMaterials"

function drawUI()
    setToMaterialColor()
    love.graphics.print(string.format("Current brush: %s", getCurrentMaterial().name), 40, 60)
end