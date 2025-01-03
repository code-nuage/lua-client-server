Network = {}

PLAYERS = {}

function Network:load()
    HOST = enet.host_create()
    SERVER = HOST:connect(CONFIG.IP .. ":" .. CONFIG.PORT)
end

function Network:update()
    local event = HOST:service(CONFIG.RATE)
    if event then
        if event.type == "receive" then
            Network:players_update(event.data)
        end
    end

    SERVER:send("PLAYERDATA," .. PLAYER.name .. "," .. PLAYER.uuid .."," .. PLAYER.x .. "," .. PLAYER.y)
end

-- MANAGE SERVER'S PLAYERSDATA
function Network:players_update(data)
    local type, name, uuid, x, y = string.match(data, "(%w+),(%w+),(%w+),([%d%.]+),([%d%.]+)")
    print(uuid)
    if type == "PLAYERDATA" and name and x and y then

        if PLAYERS[uuid] == nil then
            PLAYERS[uuid] = NetworkPlayer:new(name, x, y)
        else
            PLAYERS[uuid]:update(x, y)
        end

        print("Receive PLAYERDATA: ", PLAYERS[uuid].name, PLAYERS[uuid].x, PLAYERS[uuid].y)
    end
end

function Network:players_draw()
    for _, player in pairs(PLAYERS) do
        if player.name ~= PLAYER.name then -- Check if the received player is not the player, and exlude it from the "Network Drawing"
            love.graphics.rectangle("fill", player.x, player.y, 32, 32)
            love.graphics.print(player.name, player.x + 16 - CONFIG.FONT:getWidth(player.name) / 2, player.y - 24)
        end
    end
end

-- MANAGE CLIENT'S SERVER DATA
NetworkPlayer = {}
NetworkPlayer.__index = NetworkPlayer

function NetworkPlayer:new(name, x, y)
    local instance = setmetatable({}, NetworkPlayer)
    instance.name = name
    instance.x = x
    instance.y = y
    return instance
end

function NetworkPlayer:update(x, y)
    self.x = x
    self.y = y
end