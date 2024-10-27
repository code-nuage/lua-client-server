require("src/network")
require("src/player")

Game = {}

function Game:load()
    print("lua-client-server\nClient side")
    Network:load()
end

function Game:update(dt)
    Network:update(dt)
end

function Game:draw()
    
end