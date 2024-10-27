Server = {}

function Server:load()
    print("lua-client-server\nServer Side")
    HOST = enet.host_create(CONFIG.IP .. ":" .. CONFIG.PORT)
end

function Server:update(dt)
    local event = HOST:service(CONFIG.RATE)

    if event then
        if event.type == "receive" then
            print("Received message: " .. event.data)
        elseif event.type == "connect" then
            print(event.peer, " connected")
        elseif event.type == "disconnect" then
            print(event.peer, " disconnected")
        end
    end

    event = HOST:service()
end