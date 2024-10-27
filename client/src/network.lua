Network = {}

function Network:load()
    HOST = enet.host_create()
    SERVER = HOST:connect(CONFIG.IP .. ":" .. CONFIG.PORT)

    SERVER:send(PLAYER.name .. "," .. PLAYER.x .. "," .. PLAYER.y)
end

function Network:update()
    local event = HOST:service(CONFIG.RATE)
    if event then
        if event.type == "receive" then
            print("Received message from server: " .. event.data)
        end
    end

    SERVER:send("PLAYERDATA," .. PLAYER.name .. "," .. PLAYER.x .. "," .. PLAYER.y)
end