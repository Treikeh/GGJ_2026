local cornerRadius = 15
local panelPadding = 50

local BGColor
local TextColor
winQuote = ""

levelsWon = 0
winStreak = 0

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
    --love.graphics.rectangle("fill", panelPadding, panelPadding, width, height, cornerRadius, cornerRadius)

    -- Press start text
    
    love.graphics.setColor(TextColor.r, TextColor.g, TextColor.b)

    drawCenteredText(winQuote, 1000/#winQuote, (screenHeight / 2))
    drawCenteredText("Won: " .. levelsWon, 20, (screenHeight / 2) + 100)

    if winStreak > 1 then
        drawCenteredText("Streak: " .. winStreak, 20, (screenHeight / 2) + 120)
    end
end

function drawCenteredText(text, fontSize, yPos)
    LOVEFont = love.graphics.newFont(fontSize)
    love.graphics.setFont(LOVEFont)
    local textObj = love.graphics.newText(love.graphics.getFont(), text)
    love.graphics.setFont(defaultFont)

    -- Draw text at the center of the screen
    local textWidth = textObj:getWidth()
    local textHeight = textObj:getHeight()
    love.graphics.draw(textObj, (screenWidth / 2) - (textWidth / 2), yPos - (textHeight / 2))
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
        ":)",
        "VAFFEL",
    }

    return winQuotes[love.math.random(#winQuotes)]
end

function getRandomLoseQuote()
    local loseQuotes = {
        "DARN",
        "OOPS",
        "RESET!",
        "BOOO",
        "NO",
        "AW",
        ":(",
        "...",
        "LOSER!",
        "GAH!",
        "OUCH",
        "MISS",
        ":)",
    }

    return loseQuotes[love.math.random(#loseQuotes)]
end