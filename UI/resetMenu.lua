local cornerRadius = 15
local panelPadding = 50

local BGColor
local TextColor
local winQuote

function loadResetMenu()
    BGColor = getRandomColor()
    TextColor = getRandomColor()
    
    winQuote = getRandomWinQuote()
end

function drawResetMenu()
    -- Background panel

    love.graphics.setColor(BGColor.r, BGColor.g, BGColor.b)
    local width = screenWidth - (panelPadding * 2)
    local height = screenHeight - (panelPadding * 2)
    love.graphics.rectangle("fill", panelPadding, panelPadding, width, height, cornerRadius, cornerRadius)

    -- Press start text
    
    love.graphics.setColor(TextColor.r, TextColor.g, TextColor.b)

    LOVEFont = love.graphics.newFont(1000/#winQuote)
    love.graphics.setFont(LOVEFont)
    local text = love.graphics.newText(love.graphics.getFont(), winQuote)
    love.graphics.setFont(defaultFont)

    -- Draw text at the center of the screen
    local textWidth = text:getWidth()
    local textHeight = text:getHeight()
    love.graphics.draw(text, (screenWidth / 2) - (textWidth / 2), (screenHeight / 2) - (textHeight / 2))
end

function getRandomWinQuote()
    local winQuotes = {
        "WOW",
        "INCREBILBSBWB",
        "HOLY",
        "MARRY ME",
        "WAAAAAOW",
        "JEZZEE BREEZY",
        "SWEARWORD BUT POSITIVE",
        "IMPRESSIVE",
        "WHAT A MOVE",
        "LETS GO!",
        "IT IS [YOUR NAME] TIME",
        "THERE ARE TWO WOLVES",
        "HE WILL REMEMBER THIS",
        "NOTHING LASTS FOREVER",
        "ENTROPY",
        "YOU'RE BEING WATCHED",
        "WOWIE",
        "TAKE THAT SUPERMAN!",
        "GREAT! GREAAT!",
        "... jeg vil spise mat",
        "MOREN DIN",
        "LÆTTIS",
        "AIRTASTICAL",
        "FRESHNESS",
        "IT'S IN THE GAME",
        "SPONSET AV",
        "YOU HAVE A FUTURE",
        "I AM PROUD OF ME",
        "YOU DID IT",
        "YEA",
        ":)"
    }

    return winQuotes[love.math.random(#winQuotes)]
end