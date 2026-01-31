materials = {
    { -- Space
        {
            {x = 100, y = 100},
            {x = 100, y = 400},
            {x = 300, y = 100},
            {x = 300, y = 400}
        },
        {
            {x = 350, y = 450},
            {x = 350, y = 750},
            {x = 550, y = 750},
            {x = 550, y = 450}
        },
    },
    { -- Upside down
        {
            {x = 100, y = 450},
            {x = 100, y = 750},
            {x = 300, y = 450},
            {x = 300, y = 750}
        },
        {
            {x = 350, y = 100},
            {x = 350, y = 400},
            {x = 550, y = 400},
            {x = 550, y = 100}
        },
    }
}

local materialColors = {
    {r = 1, g = 0, b = 0},
    {r = 0, g = 1, b = 0}
}


function drawMaterials()
    for i = 1, #materials do
        makePolygons(materials[i])
    end
end


function makePolygons(polygons)
    for i = 1, #polygons do
        love.graphics.setColor(materialColors[i].r, materialColors[i].g, materialColors[i].b)
        local shape = polygons[i]
        local points = {}
        for v = 1, #shape do
            table.insert(points, shape[v].x)
            table.insert(points, shape[v].y)
        end
        love.graphics.polygon("line", points)
    end
end