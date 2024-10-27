Network = {}

function Network:load()
    HOST = enet.host_create()
    SERVER = HOST:connect(CONFIG.IP .. ":" .. CONFIG.PORT)
end

function Network:update()
    event = HOST:service(CONFIG.RATE)
    if event then
        print("Received message from server: " .. event.data)
    end

    if love.keyboard.isDown("space") then
        SERVER:send("Hello World!")
    end
end