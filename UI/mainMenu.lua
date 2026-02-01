local cornerRadius = 15
local panelPadding = 50

local mainMenuShaderCode = [[
    extern float time;
    vec4 effect(vec4 color, Image image, vec2 uvs, vec2 screen_coords) {
        float r = sin(time);
        float g = sin(time) * 2;
        float b = sin(time) * 3;
        vec4 pixel = vec4(r, g, b, 1);
        return pixel;
    }
]]


function createShader()
    mainMenuShader = love.graphics.newShader(mainMenuShaderCode)
end

function drawMainMenu()
    -- Background panel
    love.graphics.setShader(mainMenuShader)
    mainMenuShader:send("time", time)
    love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)
    love.graphics.setShader()
    
    -- Press start text
    love.graphics.setColor(TextColor.r, TextColor.g, TextColor.b)

    randomKey = getRandomKey()

    local LOVEFont = love.graphics.newFont(100)
    love.graphics.setFont(LOVEFont)
    local text = love.graphics.newText(love.graphics.getFont(), "Khe Tiss")
    local textWidth = text:getWidth()
    local textHeight = text:getHeight()
    love.graphics.draw(text, (screenWidth / 2) - (textWidth / 2), 0 + 75)

    local startText = "Press " .. randomKey .. " to start"

    local LOVEFont = love.graphics.newFont(1000/#startText)
    love.graphics.setFont(LOVEFont)
    local text = love.graphics.newText(love.graphics.getFont(), startText)

    -- Draw text at the center of the screen
    local textWidth = text:getWidth()
    local textHeight = text:getHeight()
    love.graphics.draw(text, (screenWidth / 2) - (textWidth / 2), (screenHeight / 2) - (textHeight / 2))


    local LOVEFont = love.graphics.newFont(30)
    love.graphics.setFont(LOVEFont)
    local text = love.graphics.newText(love.graphics.getFont(), "Press R to restart")
    -- Draw text at the center of the screen

    local textWidth = text:getWidth()
    local textHeight = text:getHeight()
    love.graphics.draw(text, (screenWidth / 2) - (textWidth / 2), (screenHeight / 1.5) - (textHeight / 2))

    love.graphics.setFont(defaultFont)
end


function updateMainMenu(dt)
    time = time + dt
end

function getRandomKey()
    local letters = "abcdefghijklmnopqrstuvwxyz"

    local i = love.math.random(#letters)
    return string.sub(letters,i,i)
end