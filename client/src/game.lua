require("src/network")
require("src/player")

Game = {}

function Game:load()
    print("lua-client-server\nClient side")
    PLAYER = Player:new(CONFIG.NAME, 100, 100)
    Network:load()
end

function Game:update(dt)
    PLAYER:update(dt)
    Network:update(dt)
end

function Game:draw()
    PLAYER:draw()
end