require("src/network")
require("src/player")

Game = {}

function Game:load()
    print("lua-client-server\nClient side")
    math.randomseed(CONFIG.EPOCH)
    love.graphics.setFont(CONFIG.FONT)
    PLAYER = Player:new(CONFIG.NAME, 100, 100)
    print("Player's UUID: " .. PLAYER.uuid)
    Network:load()
end

function Game:update(dt)
    PLAYER:update(dt)
    Network:update()
end

function Game:draw()
    PLAYER:draw()
    Network:players_draw()
end