enet = require("enet")

require("src/server")

function love.load()
    Server:load()
end

function love.update(dt)
    Server:update(dt)
end