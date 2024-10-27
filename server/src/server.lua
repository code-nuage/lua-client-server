require("src/player")

Server = {}

function Server:load()
    print("lua-client-server\nServer Side")
    HOST = enet.host_create(CONFIG.IP .. ":" .. CONFIG.PORT)
end

function Server:update(dt)
    local event = HOST:service(CONFIG.RATE)

    if event then
        if event.type == "receive" then
            player_listener(event.data)
        elseif event.type == "connect" then
            print(tostring(event.peer) .. " connected")
        elseif event.type == "disconnect" then
            print(tostring(event.peer) .. " disconnected")
        end
    end

    event = HOST:service()
end